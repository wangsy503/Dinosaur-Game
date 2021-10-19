.section .text
.globl gameStart
.type gameStart, @function
gameStart:
	# YOUR CODE HERE
	add a0, x0, 0xFFFF
	jal LCD_Clear