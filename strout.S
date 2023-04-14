	.global strout

	.text

; strout(char *s)
;
; Write a NUL-delimited string to the screen. The string must be 254
; characters or less (because we're using an 8-bit index).
strout:
	ldy #0
1:
	; pointer to string is passed in imaginary register RS1
	; (aka rc2 and rc3).
	lda (__rc2),y
	beq 2f
	jsr CHROUT
	iny

	; This is effectively "branch always" since we know that `iny`
	; will never set the Z flag (unless we wrap around to zero, in
	; which case falling through to the rts instructions is
	; probably the correct course of action in any case).
	bne 1b
2:
	rts

; NOTES:
;
; In the above code, labels 1: and 2: are "local labels" [1]. The expression
; `bne 2f` means "branch to the next definition of label 2" and "bne 1b"
; means "branch to the prior definition of label 1".
;
; [1]: https://sourceware.org/binutils/docs/as/Symbol-Names.html
