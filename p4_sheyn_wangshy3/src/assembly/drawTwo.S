.section .text
.globl drawTwo
.type drawTwo, @function
drawTwo:
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

	# ------- release ---------
	lw s1, 0(sp)
	lw s2, 4(sp)
	lw ra, 8(sp)
	addi sp, sp, 16
	ret
