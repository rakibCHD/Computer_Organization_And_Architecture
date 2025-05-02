.model small
.stack 100h

.data
    prompt1 db "Enter first number: $"
    prompt2 db "Enter second number: $"
    prompt3 db "Choose operation (1=Add, 2=Sub, 3=Mul, 4=Div): $"
    result db "Result: $"
    newline db 0Ah, 0Dh, "$"
    num1 db 0
    num2 db 0
    choice db 0
    res db 0

.code
main:
    ; Initialize Data Segment
    mov ax, @data
    mov ds, ax

    ; Display prompt for first number
    lea dx, prompt1
    mov ah, 09h
    int 21h
    call GetInput

    ; Store first number in num1
    mov al, num1
    mov bl, al

    ; Display prompt for second number
    lea dx, prompt2
    mov ah, 09h
    int 21h
    call GetInput

    ; Store second number in num2
    mov al, num1
    mov cl, al

    ; Display operation selection prompt
    lea dx, prompt3
    mov ah, 09h
    int 21h
    call GetChoice

    ; Based on the user's choice, perform the operation
    mov al, choice
    cmp al, '1' ; Add
    je Add
    cmp al, '2' ; Subtract
    je Sub
    cmp al, '3' ; Multiply
    je Mul
    cmp al, '4' ; Divide
    je Div

    jmp main

Add:
    ; Add numbers
    mov al, bl
    add al, cl
    mov res, al
    call PrintResult
    jmp main

Sub:
    ; Subtract numbers
    mov al, bl
    sub al, cl
    mov res, al
    call PrintResult
    jmp main

Mul:
    ; Multiply numbers
    mov al, bl
    mul cl
    mov res, al
    call PrintResult
    jmp main

Div:
    ; Divide numbers
    mov al, bl
    div cl
    mov res, al
    call PrintResult
    jmp main

GetInput:
    ; Get the input from user
    mov ah, 01h
    int 21h
    sub al, '0'
    mov num1, al
    ret

GetChoice:
    ; Get the user's choice of operation
    mov ah, 01h
    int 21h
    mov choice, al
    ret

PrintResult:
    ; Print the result
    lea dx, result
    mov ah, 09h
    int 21h

    ; Convert result to ASCII and print
    mov al, res
    add al, '0'
    mov dl, al
    mov ah, 02h
    int 21h

    ; Print newline
    lea dx, newline
    mov ah, 09h
    int 21h
    ret

end main
