global _start
section .data
mas dd 2,1,3,5,1
count dd 5
a dd 0
space dd 0
p dd 32
b dd 0
section .text
_start:

mov esi, mas
mov ebp, [count]
dec ebp
mov eax, [esi]
mov ebx, [esi]
mov ecx, esi
mov edx, esi

min:
cmp ebp, 0
je upebp
add esi, 4
dec ebp
cmp eax, [esi]
jg swap
jmp min

swap:

mov eax, [esi]
mov ecx, esi
jmp min

upebp:
mov ebp, [count]
dec ebp
xor esi, esi
mov esi, mas
mov edi, 0

max:
cmp ebp, 0
je xorall
add esi, 4
dec ebp
cmp ebx, [esi]
jl swap1
jmp max

swap1:

mov eax, [esi]
mov edx, esi
jmp max

xorall:
cmp ecx, edx
jg preout
mov [ecx], edi
add ecx, 4
jmp xorall

preout:
xor eax, eax
xor ebx, ebx
xor ecx, ecx
xor edx, edx
xor ebp, ebp
xor edi, edi
mov esi, mas
mov ebp, [count]
dec ebp

repeat:
xor ebx, ebx
cmp edi, ebp
jg end
mov eax, [esi+4*edi]
cmp eax, 0
je inward1

forzero:
cmp eax, 0
je output

inward1:
mov edx, 0
mov ecx, 10
div ecx
push edx
inc ebx
mov [space], ebx
jmp forzero

output:
mov ebx, [space]
cmp ebx, 0
je endoutput
pop ecx
add ecx, 48
mov [a], ecx
mov eax, 4
mov ebx, 1
mov ecx, a
mov edx, 1
int 0x80
mov ebx, [space]
dec ebx
mov [space], ebx
jmp output

endoutput:
mov eax, 4
mov ebx, 1
mov ecx, p
mov edx, 1
int 0x80
inc edi
jmp repeat

end:
mov eax, 1
int 0x80
