;
; Author: Mikolaj Jeziorny
; Url: https://github.com/oxess
;
; Koda na zajecia wyswietlajacy szachownice
; w podanym rozmiarze
;

.model small
.stack 16h

.model small

; (*printf)(%s, m) {
    print macro m
        push dx

        mov ah, 9
        mov dx, offset m

        int 21h

        pop dx
    endm
; }

; (*sscanf)(%d, n) {
    scan macro n
        mov ah, 1

        int 21h

        mov n, al
    endm
; }

.DATA
	txt_x db "x$"
	txt_y db "o$"
	ln db 13, 10, '$'

	col_s dw 5
	row_s dw 5
	
.CODE
.startup

    ; dx - flaga 

    mov dx, 1

	mov ax, @data
	mov ds, ax

    read_size:

    ; scan col_s
    ; scan row_s

    ; while( cx --> 0 ) {
        mov cx, [col_s]
        mainLoop:

            push cx

            ; while( cx --> 0 ) {
                mov cx, [row_s]
                insiteLoop:

                ; if( dx % 0 == 0 ) {

                    push dx

                    mov ax, dx
                    mov dx, 0
                    mov bx, 2

                    div bx
                    cmp dx, 0
                    pop dx

                    jz show_y

                    print txt_x

                    jmp end_if

                ;} else {
                    show_y:

                    print txt_y

                    end_if:
                ;}

                ; dx++
                inc dx

                loop insiteLoop
            ;}

            ; break line
            ; print( %s,
                push dx
                mov ah, 9
                lea dx, ln
                int 21h
                pop dx
            ;)

            inc dx
            pop cx

        loop mainLoop
    ; }
	
	
	call exit

;
; EXIT
;	call exit
;
exit proc
	mov ah, 4ch
	mov al, 0
	int 21h
endp

end
