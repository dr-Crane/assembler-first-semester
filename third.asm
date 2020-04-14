global _start 
section .bss 
x resb 1 
section .data 
m dd 0 
n dd 0 
a dd 0 
b dd 0 
o dd "Переполнение или неверные значения"
section .text 
_start: 

mov eax, 3 
mov ebx, 0 
mov ecx, x      ; вызов х
mov edx, 255 
int 0x80 

xor esi, esi 
xor edi, edi 
xor eax, eax 
mov esi, x  ;   esi присваиваем значение x

loop1: 
mov al, [esi+edi]  ; в младший регистр закидываем сумму регистров(esi адрес первой строки ,а edi адрес рассматриваемого элемента)
cmp al, 10  ;   сравниваем сумму с 10 тем самым проверяем закончилась ли строка
je next1    ; в случае конца строки - прыжок
mov eax, [m]  ; в eax закидываем значение m
mov ecx, 10     ; призваем 10 для того чтобы в дальнейшем умножить на него
mul ecx         ; умножение на 10
mov [m], eax    ; переписываем значение m
mov eax, [esi+edi] ; берём элемент строки
sub eax, 48     ; уменьшаем eax на 48 для того чтобы получить код
add eax, [m]; складываем
jo over
mov [m], eax    ;перзаписываем значение m 
add edi, 1     ; увеличиваем на единицу тем самым переходим к следующему числу
jmp loop1   ; безусловный переход

next1: 
inc edi 

loop2: 
mov al, [esi+edi] 
cmp al, 10 
je next2
mov eax, [n] 
mov ecx, 10 
mul ecx 
mov [n], eax 
mov eax, [esi+edi] 
sub eax, 48 
add eax, [n] 
jo over
mov [n], eax 
add edi, 1 
jmp loop2 

next2: 
mov al, [m] 
mov [b], al 
mov eax, [b] 
mov [m], eax 
mov al, [n] 
mov [b], al 
mov eax, [b] 
mov [n], eax 
mov eax, [m] 
mov ebx, [n] 
mov [m], eax 


xor eax, eax
xor ecx, ecx
xor ebx, ebx
xor edx, edx
xor esi, esi
xor edi, edi



mov eax, [m]
mov ecx, [m]
mov ebx, 1 
mov edx, 1 
mov esi, [n] 
cmp esi, 0 
jne first 
mov esi, 1 
add esi, 48 
mov [a], esi 
mov eax, 4 
mov ebx, 1 
mov ecx, a 
mov edx, 1 
int 0x80 
jmp finish2

first: 
cmp edx, [n] 
je finish1 

second: 
cmp ebx, [m] 
je next 
inc ebx 
add eax, ecx
js over
jmp second

next: 
mov ecx, eax 
inc edx 
mov ebx, 1 
jmp first 

finish1: 
mov esi, 0 

repeat: 
cmp eax, 0 
je output
mov edx, 0 
mov ecx, 10 
div ecx 
push edx 
inc esi
jmp repeat 

output: 
cmp esi, 0 
je finish2
pop ecx 
add ecx, 48
mov [a], ecx 
mov eax, 4 
mov ebx, 1 
mov ecx, a 
mov edx, 1 
int 0x80 
dec esi 
jmp output 

over:
mov eax, 4 
mov ebx, 1 
mov ecx, o
mov edx, 65
int 0x80 

finish2: 
mov eax, 1 
int 0x80
