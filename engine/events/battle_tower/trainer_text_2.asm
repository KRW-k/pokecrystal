BattleTowerText::
; Print text c for trainer [wBT_OTTrainerClass]
; 1: Intro text
; 2: Player lost
; 3: Player won
;	ldh a, [rSVBK]
;	push af
;	ld a, BANK(wBT_OTTrainerClass)
;	ldh [rSVBK], a
;if DEF(_CRYSTAL11)
;	ld hl, wBT_OTTrainerClass
;else
; BUG ALERT
; Instead of loading the Trainer Class, this routine
; loads the 6th character in the Trainer's name, then
; uses it to get the gender of the trainer.
; As a consequence, the enemy trainer's dialog will
; always be sampled from the female array.
;	ld hl, wBT_OTName + NAME_LENGTH_JAPANESE - 1
;endc
;	ld a, [hl]
;	dec a
;	ld e, a
;	ld d, 0
;	ld hl, BTTrainerClassGenders
;	add hl, de
;	ld a, [hl]
;	and a
;	jr nz, .female
;	; generate a random number between 0 and 24
;	ldh a, [hRandomAdd]
;	and $1f
;	cp 25
;	jr c, .okay0
;	sub 25
;
;.okay0
;	ld hl, BTMaleTrainerTexts
;	jr .proceed
;
;.female
;	; generate a random number between 0 and 14
;	ldh a, [hRandomAdd]
;	and $f
;	cp 15
;	jr c, .okay1
;	sub 15
;
;.okay1
;	ld hl, BTFemaleTrainerTexts
;
;.proceed
;	ld b, 0
;	dec c
;	jr nz, .restore
;	ld [wBT_TrainerTextIndex], a
;	jr .okay2
;
;.restore
;	ld a, [wBT_TrainerTextIndex]
;
;.okay2
;	push af
;	add hl, bc
;	add hl, bc
;	ld a, [hli]
;	ld c, a
;	ld a, [hl]
;	ld h, a
;	ld l, c
;	pop af
;	ld c, a
;	ld b, 0
;	add hl, bc
;	add hl, bc
;	ld a, [hli]
;	ld c, a
;	ld a, [hl]
;	ld l, c
;	ld h, a
;	bccoord 1, 14
;	pop af
;	ldh [rSVBK], a
;	call PlaceHLTextAtBC
;	ret

    ld a, $05
    call GetSRAMBank;$2f9d
    ld a, c
    cp $01
    jr nz, jr_047_400f

    call Call_047_4033
    jr jr_047_4016

jr_047_400f:
    call Call_047_4033
    and a
    jr z, jr_047_401d

    dec a

jr_047_4016:
    and a
    jr z, jr_047_401d

    dec a
    add hl, de
    jr jr_047_4016

jr_047_401d:
    ld de, $c688
    ld bc, $000c
    call CopyBytes;$2ff2
    call CloseSRAM;$2fad
    ld de, $c5b9
    ld bc, $c688
    call PrintEZChatBattleMessage;Call_047_40b3
    ret

; get address of easy chat data
Call_047_4033:
    dec a
    sla a
    sla a
    ld c, a
    sla a
    add c
    ld c, a
    ld b, $00
    ld de, -BATTLE_TOWER_STRUCT_LENGTH
    ld hl, s5_aa8e + BATTLE_TOWER_STRUCT_LENGTH * (BATTLETOWER_STREAK_LENGTH - 1) + $bc;$affe easy chat data for trainer
    add hl, bc
    ld a, [sNrOfBeatenBattleTowerTrainers];$aa3f
    ret
