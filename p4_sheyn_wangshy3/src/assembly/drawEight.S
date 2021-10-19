.section .text
.globl drawEight
.type drawEight, @function
drawEight:
	# The above lines declares a function that can be accessed from C code.
	# When you're implementing your own function, you make a new file in
	# this folder, copy the above 4 lines, and replace all
	# "your_function_name" to your function's name.

	# Then you can add code after the label on line 4.

	# The rest of things work the same as in Venus, except that the directive
	# ".asciiz" is removed. Use ".string" instead.

	# Also, please make sure that each assembly function has a filename with 
	# extension name ".S", not ".s". Otherwise it will not be recognized
	# by the riscv-nuclei-elf-as and will throw an error.

	# You're free to remove this function after you've read the above.

	# ------ store --------
	addi sp, sp, -16
	sw s1, 0(sp)
	sw s2, 4(sp)
	sw ra, 8(sp)
    mv s1, a0
	mv s2, a1
	# -------- function ---------

    addi a0, s1, 0   # startPoint horizon
    addi a1, s2, 0 # startPoint vertical
    addi a2, s1, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s1, 0   # startPoint horizon
    addi a1, s2, 15 # startPoint vertical
    addi a2, s1, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s1, 0   # startPoint horizon
    addi a1, s2, 30 # startPoint vertical
    addi a2, s1, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s1, 0   # startPoint horizon
    addi a1, s2, 5 # startPoint vertical
    addi a2, s1, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s1, 15   # startPoint horizon
    addi a1, s2, 5 # startPoint vertical
    addi a2, s1, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s1, 0   # startPoint horizon
    addi a1, s2, 20 # startPoint vertical
    addi a2, s1, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s1, 15   # startPoint horizon
    addi a1, s2, 20 # startPoint vertical
    addi a2, s1, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s2, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

	
	# ------- release ---------
	lw s1, 0(sp)
	lw s2, 4(sp)
	lw ra, 8(sp)
	addi sp, sp, 16
	ret