; rst vectors (called through the rst instruction)

SECTION "rst0", ROM0[$0000]
	di
	jp Start

SECTION "rst8", ROM0[$0008]
FarCall::
	jp FarCall_hl

SECTION "rst10", ROM0[$0010]
Bankswitch::
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret

SECTION "rst18", ROM0[$0018]
	rst $38

SECTION "rst20", ROM0[$0020]
	rst $38

SECTION "rst28", ROM0[$0028]
JumpTable::
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
; SECTION "rst30", ROM0[$0030]
	ld l, a
	pop de
	jp hl

SECTION "rst38", ROM0[$0038]
	rst $38


; Game Boy hardware interrupts

SECTION "vblank", ROM0[$0040]
	jp VBlank

SECTION "lcd", ROM0[$0048]
	jp LCD

SECTION "timer", ROM0[$0050]
	jp MobileTimer

SECTION "serial", ROM0[$0058]
	jp Serial

SECTION "joypad", ROM0[$0060]
	jp Joypad


SECTION "Header", ROM0[$0100]

Start::
; Nintendo requires all Game Boy ROMs to begin with a nop ($00) and a jp ($C3)
; to the starting address.
	nop
	jp _Start
; analogue pocket logo
    db   $01,$10,$CE,$EF,$00,$00,$44,$AA 
    db   $00,$74,$00,$18,$11,$95,$00,$34 
    db   $00,$1A,$00,$D5,$00,$22,$00,$69 
    db   $6F,$F6,$F7,$73,$09,$90,$E1,$10 
    db   $44,$40,$9A,$90,$D5,$D0,$44,$30 
    db   $A9,$21,$5D,$48,$22,$E0,$F8,$60
; The Game Boy cartridge header data is patched over by rgbfix.
; This makes sure it doesn't get used for anything else.
	ds $0150 - @, $00
