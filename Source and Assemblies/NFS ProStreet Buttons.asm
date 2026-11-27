#To be inserted at 80537B78
; KPADRead
; r4 holds extType
; r7 holds wiimote bitfield (output)
; r8 holds wiimote+nunchuk bitfield (input)
; r9 holds classic bitfield

  cmpwi r4, 0x1
  beq- NUNCHUK_REMAP
  cmpwi r4, 0x2
  beq- CLASSIC_REMAP
  mr r6, r7            ; extType == 0: standalone Wii Remote, pass through untouched
  b RETURN

NUNCHUK_REMAP:
  li r6, 0x0
    WIIMOTE_HOME:
      andi. r0, r7, 0x8000
      beq- WIIMOTE_UP
      ori r6, r6, 0x8000    ; home
    WIIMOTE_UP:
      andi. r0, r7, 0x8
      beq- WIIMOTE_DOWN
      ori r6, r6, 0x2       ; up (v) / left (h)
    WIIMOTE_DOWN:
      andi. r0, r7, 0x4
      beq- WIIMOTE_LEFT
      ori r6, r6, 0x1       ; down (v) / right (h)
    WIIMOTE_LEFT:
      andi. r0, r7, 0x1
      beq- WIIMOTE_RIGHT
      ori r6, r6, 0x8       ; left (v) / down (h)
    WIIMOTE_RIGHT:
      andi. r0, r7, 0x2
      beq- WIIMOTE_A
      ori r6, r6, 0x4       ; right (v) / up (h)
    WIIMOTE_A:
      andi. r0, r7, 0x800
      beq- WIIMOTE_B
      ori r6, r6, 0x200     ; 1
    WIIMOTE_B:
      andi. r0, r7, 0x400
      beq- WIIMOTE_1
      ori r6, r6, 0x100     ; 2
    WIIMOTE_1:
      andi. r0, r7, 0x200
      beq- WIIMOTE_2
      ori r6, r6, 0x8    ; up
    WIIMOTE_2:
      andi. r0, r7, 0x100
      beq- WIIMOTE_PLUS
      ori r6, r6, 0x4    ; down
    WIIMOTE_PLUS:
      andi. r0, r7, 0x10
      beq- WIIMOTE_MINUS
      ori r6, r6, 0x10      ; plus
    WIIMOTE_MINUS:
      andi. r0, r7, 0x1000
      beq- NUNCHUK_C
      ori r6, r6, 0x1000    ; minus
    NUNCHUK_C:
      andi. r0, r7, 0x4000
      beq- NUNCHUK_Z
      ori r6, r6, 0x400     ; b
    NUNCHUK_Z:
      andi. r0, r7, 0x2000
      beq- WIIMOTE_DONE
      ori r6, r6, 0x800     ; A
    WIIMOTE_DONE:
      mr r7, r6
      b RETURN

CLASSIC_REMAP:
  li r6, 0x0
  li r4, 0x0            ; i'm a wiimote
    CLASSIC_HOME:
      andi. r0, r9, 0x800
      beq- CLASSIC_UP
      ori r6, r6, 0x8000    ; home
    CLASSIC_UP:
      andi. r0, r9, 0x1
      beq- CLASSIC_DOWN
      ori r6, r6, 0x2
    CLASSIC_DOWN:
      andi. r0, r9, 0x4000
      beq- CLASSIC_LEFT
      ori r6, r6, 0x1
    CLASSIC_LEFT:
      andi. r0, r9, 0x2
      beq- CLASSIC_RIGHT
      ori r6, r6, 0x8
    CLASSIC_RIGHT:
      andi. r0, r9, 0x8000
      beq- CLASSIC_A
      ori r6, r6, 0x4
    CLASSIC_A:
      andi. r0, r9, 0x10
      beq- CLASSIC_B
      ori r6, r6, 0x100     ; 2
    CLASSIC_B:
      andi. r0, r9, 0x40
      beq- CLASSIC_X
      ori r6, r6, 0x200     ; 1
    CLASSIC_X:
      andi. r0, r9, 0x8
      beq- CLASSIC_Y
      ori r6, r6, 0x800     ; a
    CLASSIC_Y:
      andi. r0, r9, 0x20
      beq- CLASSIC_L
      ori r6, r6, 0x400     ; b
    CLASSIC_L:
      andi. r0, r9, 0x2000
      beq- CLASSIC_R
      ori r6, r6, 0x200     ; 1
    CLASSIC_R:
      andi. r0, r9, 0x200
      beq- CLASSIC_ZL
      ori r6, r6, 0x100     ; 2
    CLASSIC_ZL:
      andi. r0, r9, 0x80
      beq- CLASSIC_ZR
      ori r6, r6, 0x2       ; up
    CLASSIC_ZR:
      andi. r0, r9, 0x4
      beq- CLASSIC_PLUS
      ori r6, r6, 0x1       ; down
    CLASSIC_PLUS:
      andi. r0, r9, 0x400
      beq- CLASSIC_MINUS
      ori r6, r6, 0x10      ; plus
    CLASSIC_MINUS:
      andi. r0, r9, 0x1000
      beq- CLASSIC_DONE
      ori r6, r6, 0x1000    ; minus
    CLASSIC_DONE:
      mr r7, r6

RETURN:
  andi. r0, r6, 0x9FFF