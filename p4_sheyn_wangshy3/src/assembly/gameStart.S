.section .text
.globl gameStart
.type gameStart, @function




gameStart:

    # save highest score
    mv s0, a0

    # ---------- draw 1st bit ----------
    li s2, 1000
    divu s1, s0, s2 # bitNumber = score/1000
    li s3, 25 # start point x
    li s4, 35 # start point y
    jal drawCharacter

    mul s1, s1, s2 # subNumber = bitNumber*1000
    sub s0, s0, s1 # score = score - subNumber


    # ---------- draw 2nd bit ----------
    li s2, 100
    divu s1, s0, s2 # bitNumber = score/100
    li s3, 55 # start point x
    li s4, 35 # start point y
    jal drawCharacter

    
    mul s1, s1, s2 # subNumber = bitNumber*100
    sub s0, s0, s1 # score = score - subNumber

    # ---------- draw 3rd bit ----------
    li s2, 10
    divu s1, s0, s2 # bitNumber = score/10
    li s3, 85 # start point x
    li s4, 35 # start point y
    jal drawCharacter

    mul s1, s1, s2 # subNumber = bitNumber*10
    sub s0, s0, s1 # score = score - subNumber

    # ---------- draw 4st bit ----------
    li s2, 1
    divu s1, s0, s2 # bitNumber = score/1
    li s3, 115 # start point x
    li s4, 35 # start point y
    jal drawCharacter

    mul s1, s1, s2 # subNumber = bitNumber*1
    sub s0, s0, s1 # score = score - subNumber



drawCharacter:
    mv s1, s1 # save bitNum
    li t0, 0
    beq s1, t0, drawZero
    li t0, 1
    beq s1, t0, drawOne
    li t0, 2
    beq s1, t0, drawTwo
    li t0, 3
    beq s1, t0, drawThree
    li t0, 4
    beq s1, t0, drawFour
    li t0, 5
    beq s1, t0, drawFive
    li t0, 6
    beq s1, t0, drawSix
    li t0, 7
    beq s1, t0, drawSeven
    li t0, 8
    beq s1, t0, drawEight
    li t0, 9
    beq s1, t0, drawNine

drawZero:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill
    
    addi a0, s3, 5   # startPoint horizon
    addi a1, s4, 5  # startPoint vertical
    addi a2, s3, 14     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 5   # startPoint horizon
    addi a1, s4, 20  # startPoint vertical
    addi a2, s3, 14     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    ret

drawOne:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 12     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 7   # startPoint horizon
    addi a1, s4, 5  # startPoint vertical
    addi a2, s3, 12     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30  # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawTwo:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawThree:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawFour:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 14     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawFive:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill 

drawSix:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawSeven:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 14     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawEight:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

drawNine:
    mv a0, s3   # startPoint horizon
    mv a1, s4   # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0xFFFF   # color = white
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 0 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 4     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 15 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 19     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 30 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 34     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 0   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 4     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 5 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 14     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill

    addi a0, s3, 15   # startPoint horizon
    addi a1, s4, 20 # startPoint vertical
    addi a2, s3, 19     # endPoint_horizon = startPoint_horizon
    addi a3, s4, 29     # endPoint_vertical = startPoint_vertical
    li a4, 0x0   # color = black
    jal LCD_Fill
    