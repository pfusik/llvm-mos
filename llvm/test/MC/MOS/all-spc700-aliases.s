; RUN: llvm-mc -assemble --print-imm-hex --show-encoding -triple mos -motorola-integers --mcpu=mosspc700 < %s | FileCheck %s

 	nop                         ; CHECK: encoding: [0x00]
 	bpl $ea                     ; CHECK: encoding: [0x10,0xea]
 	clp                         ; CHECK: encoding: [0x20]
 	bmi $ea                     ; CHECK: encoding: [0x30,0xea]
 	sep                         ; CHECK: encoding: [0x40]
 	bvc $ea                     ; CHECK: encoding: [0x50,0xea]
 	clc                         ; CHECK: encoding: [0x60]
 	bvs $ea                     ; CHECK: encoding: [0x70,0xea]
 	sec                         ; CHECK: encoding: [0x80]
 	bcc $ea                     ; CHECK: encoding: [0x90,0xea]
 	cli                         ; CHECK: encoding: [0xa0]
 	bcs $ea                     ; CHECK: encoding: [0xb0,0xea]
 	sei                         ; CHECK: encoding: [0xc0]
 	bne $ea                     ; CHECK: encoding: [0xd0,0xea]
 	clv                         ; CHECK: encoding: [0xe0]
 	beq $ea                     ; CHECK: encoding: [0xf0,0xea]
	smb 0, $ea                  ; CHECK: encoding: [0x02,0xea]
	rmb 0, $ea                  ; CHECK: encoding: [0x12,0xea]
	smb 1, $ea                  ; CHECK: encoding: [0x22,0xea]
	rmb 1, $ea                  ; CHECK: encoding: [0x32,0xea]
	smb 2, $ea                  ; CHECK: encoding: [0x42,0xea]
	rmb 2, $ea                  ; CHECK: encoding: [0x52,0xea]
	smb 3, $ea                  ; CHECK: encoding: [0x62,0xea]
	rmb 3, $ea                  ; CHECK: encoding: [0x72,0xea]
	smb 4, $ea                  ; CHECK: encoding: [0x82,0xea]
	rmb 4, $ea                  ; CHECK: encoding: [0x92,0xea]
	smb 5, $ea                  ; CHECK: encoding: [0xa2,0xea]
	rmb 5, $ea                  ; CHECK: encoding: [0xb2,0xea]
	smb 6, $ea                  ; CHECK: encoding: [0xc2,0xea]
	rmb 6, $ea                  ; CHECK: encoding: [0xd2,0xea]
	smb 7, $ea                  ; CHECK: encoding: [0xe2,0xea]
	rmb 7, $ea                  ; CHECK: encoding: [0xf2,0xea]
	bbs 0, $ea, $ea             ; CHECK: encoding: [0x03,0xea,0xea]
	bbr 0, $ea, $ea             ; CHECK: encoding: [0x13,0xea,0xea]
	bbs 1, $ea, $ea             ; CHECK: encoding: [0x23,0xea,0xea]
	bbr 1, $ea, $ea             ; CHECK: encoding: [0x33,0xea,0xea]
	bbs 2, $ea, $ea             ; CHECK: encoding: [0x43,0xea,0xea]
	bbr 2, $ea, $ea             ; CHECK: encoding: [0x53,0xea,0xea]
	bbs 3, $ea, $ea             ; CHECK: encoding: [0x63,0xea,0xea]
	bbr 3, $ea, $ea             ; CHECK: encoding: [0x73,0xea,0xea]
	bbs 4, $ea, $ea             ; CHECK: encoding: [0x83,0xea,0xea]
	bbr 4, $ea, $ea             ; CHECK: encoding: [0x93,0xea,0xea]
	bbs 5, $ea, $ea             ; CHECK: encoding: [0xa3,0xea,0xea]
	bbr 5, $ea, $ea             ; CHECK: encoding: [0xb3,0xea,0xea]
	bbs 6, $ea, $ea             ; CHECK: encoding: [0xc3,0xea,0xea]
	bbr 6, $ea, $ea             ; CHECK: encoding: [0xd3,0xea,0xea]
	bbs 7, $ea, $ea             ; CHECK: encoding: [0xe3,0xea,0xea]
	bbr 7, $ea, $ea             ; CHECK: encoding: [0xf3,0xea,0xea]
	ora $ea                     ; CHECK: encoding: [0x04,0xea]
	ora $ea, x                  ; CHECK: encoding: [0x14,0xea]
	and $ea                     ; CHECK: encoding: [0x24,0xea]
	and $ea, x                  ; CHECK: encoding: [0x34,0xea]
	eor $ea                     ; CHECK: encoding: [0x44,0xea]
	eor $ea, x                  ; CHECK: encoding: [0x54,0xea]
	cmp $ea                     ; CHECK: encoding: [0x64,0xea]
	cmp $ea, x                  ; CHECK: encoding: [0x74,0xea]
	adc $ea                     ; CHECK: encoding: [0x84,0xea]
	adc $ea, x                  ; CHECK: encoding: [0x94,0xea]
	sbc $ea                     ; CHECK: encoding: [0xa4,0xea]
	sbc $ea, x                  ; CHECK: encoding: [0xb4,0xea]
	sta $ea                     ; CHECK: encoding: [0xc4,0xea]
	sta $ea, x                  ; CHECK: encoding: [0xd4,0xea]
	lda $ea                     ; CHECK: encoding: [0xe4,0xea]
	lda $ea, x                  ; CHECK: encoding: [0xf4,0xea]
	ora $eaea                   ; CHECK: encoding: [0x05,0xea,0xea]
	ora $eaea, x                ; CHECK: encoding: [0x15,0xea,0xea]
	and $eaea                   ; CHECK: encoding: [0x25,0xea,0xea]
	and $eaea, x                ; CHECK: encoding: [0x35,0xea,0xea]
	eor $eaea                   ; CHECK: encoding: [0x45,0xea,0xea]
	eor $eaea, x                ; CHECK: encoding: [0x55,0xea,0xea]
	cmp $eaea                   ; CHECK: encoding: [0x65,0xea,0xea]
	cmp $eaea, x                ; CHECK: encoding: [0x75,0xea,0xea]
	adc $eaea                   ; CHECK: encoding: [0x85,0xea,0xea]
	adc $eaea, x                ; CHECK: encoding: [0x95,0xea,0xea]
	sbc $eaea                   ; CHECK: encoding: [0xa5,0xea,0xea]
	sbc $eaea, x                ; CHECK: encoding: [0xb5,0xea,0xea]
	sta $eaea                   ; CHECK: encoding: [0xc5,0xea,0xea]
	sta $eaea, x                ; CHECK: encoding: [0xd5,0xea,0xea]
	lda $eaea                   ; CHECK: encoding: [0xe5,0xea,0xea]
	lda $eaea, x                ; CHECK: encoding: [0xf5,0xea,0xea]
	ora (x)                     ; CHECK: encoding: [0x06]
	ora $eaea, y                ; CHECK: encoding: [0x16,0xea,0xea]
	and (x)                     ; CHECK: encoding: [0x26]
	and $eaea, y                ; CHECK: encoding: [0x36,0xea,0xea]
	eor (x)                     ; CHECK: encoding: [0x46]
	eor $eaea, y                ; CHECK: encoding: [0x56,0xea,0xea]
	cmp (x)                     ; CHECK: encoding: [0x66]
	cmp $eaea, y                ; CHECK: encoding: [0x76,0xea,0xea]
	adc (x)                     ; CHECK: encoding: [0x86]
	adc $eaea, y                ; CHECK: encoding: [0x96,0xea,0xea]
	sbc (x)                     ; CHECK: encoding: [0xa6]
	sbc $eaea, y                ; CHECK: encoding: [0xb6,0xea,0xea]
	sta (x)                     ; CHECK: encoding: [0xc6]
	sta $eaea, y                ; CHECK: encoding: [0xd6,0xea,0xea]
	lda (x)                     ; CHECK: encoding: [0xe6]
	lda $eaea, y                ; CHECK: encoding: [0xf6,0xea,0xea]
	ora ($ea, x)                ; CHECK: encoding: [0x07,0xea]
	ora ($ea), y                ; CHECK: encoding: [0x17,0xea]
	and ($ea, x)                ; CHECK: encoding: [0x27,0xea]
	and ($ea), y                ; CHECK: encoding: [0x37,0xea]
	eor ($ea, x)                ; CHECK: encoding: [0x47,0xea]
	eor ($ea), y                ; CHECK: encoding: [0x57,0xea]
	cmp ($ea, x)                ; CHECK: encoding: [0x67,0xea]
	cmp ($ea), y                ; CHECK: encoding: [0x77,0xea]
	adc ($ea, x)                ; CHECK: encoding: [0x87,0xea]
	adc ($ea), y                ; CHECK: encoding: [0x97,0xea]
	sbc ($ea, x)                ; CHECK: encoding: [0xa7,0xea]
	sbc ($ea), y                ; CHECK: encoding: [0xb7,0xea]
	sta ($ea, x)                ; CHECK: encoding: [0xc7,0xea]
	sta ($ea), y                ; CHECK: encoding: [0xd7,0xea]
	lda ($ea, x)                ; CHECK: encoding: [0xe7,0xea]
	lda ($ea), y                ; CHECK: encoding: [0xf7,0xea]
	ora #$ea                    ; CHECK: encoding: [0x08,0xea]
	and #$ea                    ; CHECK: encoding: [0x28,0xea]
	eor #$ea                    ; CHECK: encoding: [0x48,0xea]
	cmp #$ea                    ; CHECK: encoding: [0x68,0xea]
	adc #$ea                    ; CHECK: encoding: [0x88,0xea]
	sbc #$ea                    ; CHECK: encoding: [0xa8,0xea]
	cpx #$ea                    ; CHECK: encoding: [0xc8,0xea]
	stx $ea                     ; CHECK: encoding: [0xd8,0xea]
	lda #$ea                    ; CHECK: encoding: [0xe8,0xea]
	ldx $ea                     ; CHECK: encoding: [0xf8,0xea]
	stx $eaea                   ; CHECK: encoding: [0xc9,0xea,0xea]
	stx $ea, y                  ; CHECK: encoding: [0xd9,0xea]
	ldx $eaea                   ; CHECK: encoding: [0xe9,0xea,0xea]
	ldx $ea, y                  ; CHECK: encoding: [0xf9,0xea]
	asl $ea,x                   ; CHECK: encoding: [0x1b,0xea]
	rol $ea,x                   ; CHECK: encoding: [0x3b,0xea]
	lsr $ea,x                   ; CHECK: encoding: [0x5b,0xea]
	ror $ea,x                   ; CHECK: encoding: [0x7b,0xea]
	dec $ea,x                   ; CHECK: encoding: [0x9b,0xea]
	inc $ea,x                   ; CHECK: encoding: [0xbb,0xea]
	sty $ea                     ; CHECK: encoding: [0xcb,0xea]
	sty $ea, x                  ; CHECK: encoding: [0xdb,0xea]
	ldy $ea                     ; CHECK: encoding: [0xeb,0xea]
	ldy $ea, x                  ; CHECK: encoding: [0xfb,0xea]
	asl                         ; CHECK: encoding: [0x1c]
	rol                         ; CHECK: encoding: [0x3c]
	lsr                         ; CHECK: encoding: [0x5c]
	ror                         ; CHECK: encoding: [0x7c]
	dec                         ; CHECK: encoding: [0x9c]
	inc                         ; CHECK: encoding: [0xbc]
	sty $eaea                   ; CHECK: encoding: [0xcc,0xea,0xea]
	dey                         ; CHECK: encoding: [0xdc]
	ldy $eaea                   ; CHECK: encoding: [0xec,0xea,0xea]
	iny                         ; CHECK: encoding: [0xfc]
	php                         ; CHECK: encoding: [0x0d]
	dex                         ; CHECK: encoding: [0x1d]
	pha                         ; CHECK: encoding: [0x2d]
	inx                         ; CHECK: encoding: [0x3d]
	phx                         ; CHECK: encoding: [0x4d]
	tax                         ; CHECK: encoding: [0x5d]
	phy                         ; CHECK: encoding: [0x6d]
	txa                         ; CHECK: encoding: [0x7d]
	ldy #$ea                    ; CHECK: encoding: [0x8d,0xea]
	tsx                         ; CHECK: encoding: [0x9d]
	cpy #$ea                    ; CHECK: encoding: [0xad,0xea]
	txs                         ; CHECK: encoding: [0xbd]
	ldx #$ea                    ; CHECK: encoding: [0xcd,0xea]
	tya                         ; CHECK: encoding: [0xdd]
	tay                         ; CHECK: encoding: [0xfd]
	tsb $eaea                   ; CHECK: encoding: [0x0e,0xea,0xea]
	cpx $eaea                   ; CHECK: encoding: [0x1e,0xea,0xea]
	cpx $ea                     ; CHECK: encoding: [0x3e,0xea]
	trb $eaea                   ; CHECK: encoding: [0x4e,0xea,0xea]
	cpy $eaea                   ; CHECK: encoding: [0x5e,0xea,0xea]
	cpy $ea                     ; CHECK: encoding: [0x7e,0xea]
	plp                         ; CHECK: encoding: [0x8e]
	div                         ; CHECK: encoding: [0x9e]
	pla                         ; CHECK: encoding: [0xae]
	das                         ; CHECK: encoding: [0xbe]
	plx                         ; CHECK: encoding: [0xce]
	ply                         ; CHECK: encoding: [0xee]
	brk                         ; CHECK: encoding: [0x0f]
	jmp ($eaea, x)              ; CHECK: encoding: [0x1f,0xea,0xea]
	bra $ea                     ; CHECK: encoding: [0x2f,0xea]
	jsr $eaea                   ; CHECK: encoding: [0x3f,0xea,0xea]
	jmp $eaea                   ; CHECK: encoding: [0x5f,0xea,0xea]
	rts                         ; CHECK: encoding: [0x6f]
	rti                         ; CHECK: encoding: [0x7f]
	xcn                         ; CHECK: encoding: [0x9f]
	mul                         ; CHECK: encoding: [0xcf]
	daa                         ; CHECK: encoding: [0xdf]
	wai                         ; CHECK: encoding: [0xef]
	stp                         ; CHECK: encoding: [0xff]
