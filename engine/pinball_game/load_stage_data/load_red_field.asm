_LoadStageDataRedFieldTop: ; 0x14000
	call Func_14091
	call Func_159f4
	call Func_15450
	call Func_16859
	call Func_14ece
	call Func_14234
	call Func_16425
	call Func_142fc
	call Func_1404a
	ret

_LoadStageDataRedFieldBottom: ; 0x1401c
	call Func_14091
	call Func_14377
	call Func_14135
	call Func_asm_1522d
	call Func_14282
	call Func_1414b
	call Func_14234
	call Func_14746
	call Func_14707
	call Func_140f9
	call Func_16878
	call Func_140e2
	call Func_16425
	call Func_142fc
	call Func_1404a
	ret

Func_1404a: ; 0x1404a
	ld a, [wd57d]
	and a
	ret z
	ld a, [hGameBoyColorFlag]
	and a
	ret nz
	ld a, [wd580]
	and a
	ret z
	ld a, $f
	ld [wd581], a
	call Func_1762f
	ld hl, wTimerDigits
	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld hl, wTimerDigits
	ld a, [wTimerMinutes]
	and $f
	call LoadTimerDigitTiles
	ld a, [wTimerSeconds]
	swap a
	and $f
	call LoadTimerDigitTiles
	ld a, [wTimerSeconds]
	and $f
	call LoadTimerDigitTiles
	ld a, e
	srl a
	srl a
	ld d, $90 ; colon
	call LoadTimerDigitTiles
	ret

Func_14091: ; 0x14091
	ld a, $ff
	ld [wd4d7], a
	ld [wd4db], a
	ld a, [wd4b4]
	ld [wd4c5], a
	ld a, [wd4b6]
	ld [wd4c6], a
	ld a, [wBallRotation]
	ld [wd4c7], a
	ld a, [wd503]
	and a
	ret z
	xor a
	ld [wd503], a
	ld a, [wd502]
	res 1, a
	ld [wd502], a
	and $1
	ld c, a
	ld a, [wStageCollisionState]
	and $fe
	or c
	ld [wStageCollisionState], a
	lb de, $00, $07
	call PlaySoundEffect
	ld a, [wCurrentStage]
	bit 0, a
	ret nz
	callba LoadStageCollisionAttributes
	call Func_159f4
	ret

Func_140e2: ; 0x140e2
	ld a, $ff
	ld [wd60e], a
	ld [wd60f], a
	ld a, [wd60c]
	call Func_16f28
	ld a, [wd60d]
	add $14
	call Func_16f28
	ret

Func_140f9: ; 0x140f9
	ld a, [wd4ef]
	and a
	jr z, .asm_1410c
	xor a
	ld a, $66
	ld [wc7e3], a
	ld a, $67
	ld [wc803], a
	ld a, $2
.asm_1410c
	call Func_149d9
	ld a, [wLeftMapMoveCounter]
	call Func_149f5
	ld a, [wd4f1]
	and a
	jr z, .asm_14127
	ld a, $6a
	ld [wc7f0], a
	ld a, $6b
	ld [wc810], a
	ld a, $2
.asm_14127
	add $3
	call Func_149d9
	ld a, [wRightMapMoveCounter]
	add $4
	call Func_149f5
	ret

Func_14135: ; 0x14135
	ld bc, $0000
.asm_14138
	push bc
	ld hl, wIndicatorStates
	add hl, bc
	ld a, [hl]
	res 7, a
	call Func_169cd
	pop bc
	inc c
	ld a, c
	cp $5
	jr nz, .asm_14138
	ret

Func_1414b: ; 0x1414b
	ld a, [wInSpecialMode]
	and a
	ret z
	ld a, [wSpecialMode]
	cp $2
	ret z
	ld a, [wd5c6]
	and a
	jr nz, .asm_14165
	ld a, [wCapturingMon]
	and a
	jr nz, .asm_14165
	jp Func_14210

.asm_14165
	callba Func_141f2
	callba Func_10362
	ld a, [hGameBoyColorFlag]
	and a
	callba nz, Func_10301
	ld a, [wCapturingMon]
	and a
	ret z
	ld a, BANK(PikachuSaverGfx)
	ld hl, PikachuSaverGfx + $c0
	ld de, vTilesOB tile $7e
	ld bc, $0020
	call FarCopyData
	ld a, BANK(BallCaptureSmokeGfx)
	ld hl, BallCaptureSmokeGfx
	ld de, vTilesSH tile $10
	ld bc, $0180
	call FarCopyData
	ld a, [wBallType]
	cp GREAT_BALL
	jr nc, .notPokeball
	ld a, Bank(PinballPokeballShakeGfx)
	ld hl, PinballPokeballShakeGfx
	ld de, vTilesOB tile $38
	ld bc, $0040
	call FarCopyData
	ret

.notPokeball
	cp ULTRA_BALL
	jr nc, .notGreatball
	ld a, Bank(PinballGreatballShakeGfx)
	ld hl, PinballGreatballShakeGfx
	ld de, vTilesOB tile $38
	ld bc, $0040
	call FarCopyData
	ret

.notGreatball
	cp MASTER_BALL
	jr nc, .notUltraball
	ld a, Bank(PinballUltraballShakeGfx)
	ld hl, PinballUltraballShakeGfx
	ld de, vTilesOB tile $38
	ld bc, $0040
	call FarCopyData
	ret

.notUltraball
	ld a, Bank(PinballMasterballShakeGfx)
	ld hl, PinballMasterballShakeGfx
	ld de, vTilesOB tile $38
	ld bc, $0040
	call FarCopyData
	ret

Func_141f2: ; 0x141f2
	ld a, $80
	hlCoord 7, 4, vBGMap
	call Func_14209
	hlCoord 7, 5, vBGMap
	call Func_14209
	hlCoord 7, 6, vBGMap
	call Func_14209
	hlCoord 7, 7, vBGMap
	; fall through

Func_14209: ; 0x14209
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret

Func_14210: ; 0x14210
	ld hl, wd586
	ld b, $18
.asm_14215
	ld a, [hli]
	xor $1
	ld [hli], a
	dec b
	jr nz, .asm_14215
	callba Func_10184
	ld a, [hGameBoyColorFlag]
	and a
	callba nz, Func_102bc
	ret

Func_14234: ; 0x14234
	ld a, [wInSpecialMode]
	and a
	ret z
	ld a, [wSpecialMode]
	cp $1
	ret nz
	ld a, [wd554]
	cp $3
	ret z
	ld a, [wCurrentStage]
	bit 0, a
	jr nz, .asm_1425c
	ld a, BANK(EvolutionTrinketsGfx)
	ld hl, EvolutionTrinketsGfx
	ld de, vTilesSH tile $10
	ld bc, $00e0
	call FarCopyData
	jr .asm_1426a

.asm_1425c
	ld a, BANK(EvolutionTrinketsGfx)
	ld hl, EvolutionTrinketsGfx
	ld de, vTilesOB tile $20
	ld bc, $00e0
	call FarCopyData
.asm_1426a
	ld a, [wd551]
	and a
	ret z
	ld a, [hGameBoyColorFlag]
	and a
	ret z
	ld a, BANK(PaletteData_dd188)
	ld hl, PaletteData_dd188
	ld de, $0070
	ld bc, $0010
	call Func_6fd
	ret

Func_14282: ; 0x14282
	ld a, [wInSpecialMode]
	and a
	jr z, .asm_1429e
	ld a, [wSpecialMode]
	and a
	jr nz, .asm_14296
	ld a, [wNumMonHits]
	and a
	call nz, Func_142b3
	ret

.asm_14296
	cp $1
	jr nz, .asm_1429e
	call Func_142c3
	ret

.asm_1429e
	ld a, [wd624]
	call Func_174d4
	ld a, BANK(CaughtPokeballGfx)
	ld hl, CaughtPokeballGfx
	ld de, vTilesSH tile $2e
	ld bc, $0020
	call FarCopyData
	ret

Func_142b3: ; 0x142b3
	push af
	callba Func_10611
	pop af
	dec a
	jr nz, Func_142b3
	ret

Func_142c3: ; 0x142c3
	ld de, $0000
	ld a, [wd554]
	and a
	ret z
	ld b, a
.asm_142cc
	ld a, [wCurrentEvolutionType]
	call Func_142d7
	inc de
	dec b
	jr nz, .asm_142cc
	ret

Func_142d7: ; 0x142d7
	push bc
	push de
	dec a
	ld c, a
	ld b, $0
	swap c
	sla c
	ld hl, EvolutionProgressIconsGfx
	add hl, bc
	swap e
	sla e
	push hl
	ld hl, vTilesSH tile $2e
	add hl, de
	ld d, h
	ld e, l
	pop hl
	ld bc, $0020
	ld a, BANK(EvolutionProgressIconsGfx)
	call FarCopyData
	pop de
	pop bc
	ret

Func_142fc: ; 0x142fc
	ld a, [wd4c8]
	and a
	jr nz, .asm_1430e
	callba LoadBallGfx
	jr .asm_14328

.asm_1430e
	cp $1
	jr nz, .asm_1431e
	callba LoadMiniBallGfx
	jr .asm_14328

.asm_1431e
	callba Func_dd62
.asm_14328
	ld a, [hGameBoyColorFlag]
	and a
	ret z
	ld a, [wBallType]
	cp GREAT_BALL
	jr nc, .notPokeball
	ld a, BANK(PokeBallObjPalette)
	ld hl, PokeBallObjPalette
	ld de, $0040
	ld bc, $0008
	call Func_6fd
	ret

.notPokeball
	cp ULTRA_BALL
	jr nc, .notGreatball
	ld a, BANK(GreatBallObjPalette)
	ld hl, GreatBallObjPalette
	ld de, $0040
	ld bc, $0008
	call Func_6fd
	ret

.notGreatball
	cp MASTER_BALL
	jr nc, .notUltraball
	ld a, BANK(UltraBallObjPalette)
	ld hl, UltraBallObjPalette
	ld de, $0040
	ld bc, $0008
	call Func_6fd
	ret

.notUltraball
	ld a, BANK(MasterBallObjPalette)
	ld hl, MasterBallObjPalette
	ld de, $0040
	ld bc, $0008
	call Func_6fd
	ret

Func_14377: ; 0x14377
	ld a, [wInSpecialMode]
	and a
	jr nz, .asm_143b1
	ld a, [wd609]
	and a
	jr z, .asm_14393
	ld a, [wd498]
	add $15
	callba Func_30256
	ret

.asm_14393
	ld a, [wd608]
	and a
	jr z, .asm_143a6
	ld a, $1a
	callba Func_30256
	ret

.asm_143a6
	callba Func_30253
	ret

.asm_143b1
	ld a, [wSpecialMode]
	cp $2
	ret nz
	ld a, [wd54d]
	cp $3
	jr nz, .asm_143c9
	callba Func_30253
	ret

.asm_143c9
	ld a, [wd604]
	and a
	ld a, $14
	jr nz, .asm_143d6
	ld a, [wd55a]
	add $12
.asm_143d6
	callba Func_30256
	ret