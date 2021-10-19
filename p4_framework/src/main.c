#include "lcd/lcd.h"
#include <string.h>
#include "utils.h"
#include <stdlib.h>

#include "game.h"

void gameStart();
void gameOver();

void Inp_init(void)
{
    gpio_init(GPIOA, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, GPIO_PIN_8);
}

void Adc_init(void) 
{
    rcu_periph_clock_enable(RCU_GPIOA);
    gpio_init(GPIOA, GPIO_MODE_AIN, GPIO_OSPEED_50MHZ, GPIO_PIN_0|GPIO_PIN_1);
    RCU_CFG0|=(0b10<<14)|(1<<28);
    rcu_periph_clock_enable(RCU_ADC0);
    ADC_CTL1(ADC0)|=ADC_CTL1_ADCON;
}

void IO_init(void)
{
    Inp_init(); // inport init
    Adc_init(); // A/D init
    Lcd_Init(); // LCD init
}

int main(void)
{
    IO_init();         // init OLED

    LCD_Clear(WHITE);
    BACK_COLOR=WHITE;

    while(!Get_BOOT0())
    {
        delay_1ms(50);
        if(Get_BOOT0()) break;
    }
    int maxscore=0;
    int score=0;
    while(1){
        int groundArray[][3] = {{0,72,10},{30,78,12},{60,66,5},{90,76,20},{120,70,12}};
        int cactusArray[][2] = {{0,0},{60,0}};
        int count=0;
        int dinosaurFoot=0;
        int posVertical = 0;
        int speed = 0;
        int die = 0;
        score=0;
        while(1){
            drawCactus(cactusArray);
            drawDinosaur(&speed, &posVertical, dinosaurFoot);
            drawGround(groundArray);
            die = checkDie(posVertical, cactusArray);
            if (die){
                break;
            }
            count = count%6;
            dinosaurFoot = count>=3 ? 1:0;
            delay_1ms(20);
            count++;
            if (count==1)
                score+=1;
            drawScoreBoard(score,maxscore);
            maxscore = maxscore>score ? maxscore:score;
        }

        drawGameOver(posVertical);
        
        delay_1ms(1000);
        while(!Get_BOOT0())
        {
            delay_1ms(50);
            if(Get_BOOT0()) break;
        }
        LCD_Clear(WHITE);
    }


    LCD_Clear(BLACK);


}
