#include "lcd/lcd.h"
#include <string.h>
#include "utils.h"
#include "imgs.h"


#define GRAVITY     -1
#define INITIAL_SPEED       6
#define DELTA_SPEED         2
#define MAX_SPEED           14
#define MAX_T               5
#define GROUND_MOVE_SPEED   2
#define GROUND_HEIGHT       10
#define DINOSAUR_HEIGHT     21
#define DINOSAUR_WIDTH      20
#define DINOSAUR_SIZE       420
#define DINO_BODY_WIDTH     14
#define DINO_BODY_HEIGHT    13
#define DINO_HEAD_WIDTH     10
#define DINO_HEAD_HEIGHT    8

#define CACTUS_ONE_HEIGHT   19
#define CACTUS_ONE_WIDTH    24
#define CACTUS_ONE_SIZE     456
#define CACTUS_TWO_HEIGHT   19
#define CACTUS_TWO_WIDTH    10
#define CACTUS_TWO_SIZE     190
#define CACTUS_THR_HEIGHT   24
#define CACTUS_THR_WIDTH    13
#define CACTUS_THR_SIZE     312

#define CLOUD_WIDTH         20
#define CLOUD_HEIGHT        5
#define CLOUD_MOVE_SPEED    1

#define LEFT_BLANK              15// blank area to the left of dinosaur


#define GROUND_ARRAY_LENGTH     5
#define GROUNG_CELL_LENGTH      3
#define CACTUS_ARRAY_LENGTH     2
#define CACTUS_CELL_LENGTH      2
#define CLOUD_ARRAY_LENGTH      2
#define CLOUD_CELL_LENGTH       2


void drawDinosaur();

void drawGround();
void drawCactus();
void drawCloud();
// void drawBird();


void drawScoreBoard(int,int);

int checkDie();
void drawGameOver(int);


// void LCD_Clear_Region();


/* ------- -------- */
void drawDinosaur(int *speed, int *posVertical, int foot, int *t){
    // what is Pic? 1 left; 0 right
    if (Get_BOOT0() && *posVertical == 0){
        *speed = INITIAL_SPEED;
        *t = 0;
    }
    else if (Get_BOOT0() && *t < MAX_T){
        *speed += DELTA_SPEED;
        *t += 1;
    }
    u16 startVertical = 80 - GROUND_HEIGHT - *posVertical - DINOSAUR_HEIGHT;
    if (*speed<0)
        LCD_Fill(LEFT_BLANK, startVertical, LEFT_BLANK + DINOSAUR_WIDTH -1, startVertical-(*speed)/2, WHITE);
    else
        LCD_Fill(LEFT_BLANK, startVertical+DINOSAUR_HEIGHT-(*speed)/2, LEFT_BLANK + DINOSAUR_WIDTH -1, startVertical+DINOSAUR_HEIGHT-1, WHITE);

    *posVertical += (*speed)/2;
    *speed += GRAVITY;
    if (*posVertical < 0){
        *posVertical = 0;
        *speed = 0;
    }

    startVertical = 80 - GROUND_HEIGHT - *posVertical - DINOSAUR_HEIGHT;
    LCD_Address_Set(LEFT_BLANK, startVertical, LEFT_BLANK + DINOSAUR_WIDTH -1, startVertical+DINOSAUR_HEIGHT-1);
    if (*posVertical != 0) {
        for(int i=0; i<DINOSAUR_SIZE; i++)
		    LCD_WR_DATA(Dinosaur[2][i]);
    }
    else {
        for(int i=0; i<DINOSAUR_SIZE; i++)
		    LCD_WR_DATA(Dinosaur[foot][i]);
    }
	
}

void drawGround(int groundArray[][3]){
    // x, y, length
    int addOne = 0;
    for (int i = 0; i < GROUND_ARRAY_LENGTH; i++){
        if (groundArray[i][0] == 0){
            if (groundArray[i][2] <= 0)
                addOne = 1;
            else
                groundArray[i][2] -= GROUND_MOVE_SPEED;
        }
        else
            groundArray[i][0] -= GROUND_MOVE_SPEED;

        if (groundArray[i][2] != 0){
            for(int j=0; j<GROUND_MOVE_SPEED; j++){
                if (groundArray[i][0]+groundArray[i][2]-1>=159)
                    LCD_DrawPoint(groundArray[i][0]-j, groundArray[i][1], BLACK);
                else{
                    LCD_DrawPoint(groundArray[i][0]-j, groundArray[i][1], BLACK);
                    LCD_DrawPoint(groundArray[i][0]+groundArray[i][2]-j,groundArray[i][1],WHITE);
                }
            }
        }
    }

    if (addOne){
        for (int i = 0; i < GROUND_ARRAY_LENGTH - 1; i++) {
            for (int j = 0; j < 3; j++)
                groundArray[i][j] = groundArray[i+1][j];
        }

        groundArray[GROUND_ARRAY_LENGTH-1][0] = 160;
        groundArray[GROUND_ARRAY_LENGTH-1][1] = 80 - GROUND_HEIGHT + rand()%(GROUND_HEIGHT-2); // UNFINISHED
        groundArray[GROUND_ARRAY_LENGTH-1][2] = 5 + rand()%12; // UNFINISHED
    }
    LCD_DrawLine(0, 80 - GROUND_HEIGHT, 159, 80 - GROUND_HEIGHT, BLACK);

}

void drawCactus(int cactusArray[][CACTUS_CELL_LENGTH]){
    // x, type
    int addOne = 0;
    for (int i = 0; i < CACTUS_ARRAY_LENGTH; i++){
        /* First, determine what type */
        int cactusHeight, cactusWidth, cactusSize, cactusType = cactusArray[i][1];
        int* cactusImg;
        if (cactusType == 0)
            addOne=1;
        else{
            switch (cactusType) {
                case 1 :
                    cactusHeight = CACTUS_ONE_HEIGHT;
                    cactusWidth = CACTUS_ONE_WIDTH;
                    cactusSize = CACTUS_ONE_SIZE;
                    cactusImg = Cactus_1;
                    break;
                case 2 :
                    cactusHeight = CACTUS_TWO_HEIGHT;
                    cactusWidth = CACTUS_TWO_WIDTH;
                    cactusSize = CACTUS_TWO_SIZE;
                    cactusImg = Cactus_2;
                    break;
                case 3 :
                    cactusHeight = CACTUS_THR_HEIGHT;
                    cactusWidth = CACTUS_THR_WIDTH;
                    cactusSize = CACTUS_THR_SIZE;
                    cactusImg = Cactus_3;
                    break;
            }
            /* Clear old cactus */
            u16 startHorizon = cactusArray[i][0] >= -GROUND_MOVE_SPEED ? cactusArray[i][0]+GROUND_MOVE_SPEED : 0;
            u16 endHorizon = cactusArray[i][0] + cactusWidth-1+GROUND_MOVE_SPEED<159 ? cactusArray[i][0] + cactusWidth-1+GROUND_MOVE_SPEED : 159;

            if (startHorizon >= 0 && endHorizon <= 159)
                LCD_Fill(endHorizon-GROUND_MOVE_SPEED+1, 80 - GROUND_HEIGHT - cactusHeight, endHorizon, 80 - GROUND_HEIGHT, WHITE);

            /* Calculate new position */

            
            if (cactusArray[i][0] <= -cactusWidth){
                 /* The first one totally leaves */
                addOne = 1;
            }
            else{
                /* Draw new cactus */
                startHorizon = cactusArray[i][0] >= 0 ? cactusArray[i][0] : 0;
                // startHorizon = cactusArray[i][0];
                endHorizon = cactusArray[i][0] + cactusWidth-1<159 ? cactusArray[i][0] + cactusWidth-1: 159;
                LCD_Address_Set(startHorizon, 79 - GROUND_HEIGHT - cactusHeight, endHorizon, 79 - GROUND_HEIGHT);
                if (cactusArray[i][0] < 0){
                    int w = endHorizon-startHorizon+1;
                    for(int i=0; i<w*cactusHeight; i++)
                        LCD_WR_DATA( cactusImg[(i/w)*cactusWidth+(i%w)+(cactusWidth-w)] );
                }
                else if (cactusArray[i][0] + cactusWidth-1 >= 159){
                    int w = endHorizon-startHorizon+1;
                    for(int i=0; i<w*cactusHeight; i++)
                        LCD_WR_DATA( cactusImg[(i/w)*cactusWidth+(i%w)] );
                }
                else{
                    for(int i=0; i<cactusSize; i++)
                        LCD_WR_DATA( cactusImg[i] );
                }
                cactusArray[i][0] -= GROUND_MOVE_SPEED;
            }   
        }
    }

    if (addOne && cactusArray[CACTUS_ARRAY_LENGTH-1][0]<80){
        if ((rand()%100)>=95){
            cactusArray[0][0] = cactusArray[CACTUS_ARRAY_LENGTH-1][0];
            cactusArray[0][1] = cactusArray[CACTUS_ARRAY_LENGTH-1][1];
            cactusArray[CACTUS_ARRAY_LENGTH-1][0] = 159;
            cactusArray[CACTUS_ARRAY_LENGTH-1][1] = 1+(rand()%3);
        }
    }
}


// void drawBird(); // UNFINISHED


void drawScoreBoard(int score, int maxscore){
    LCD_ShowString(100,  2, (u8 *)("Score:"), BLACK);
    LCD_ShowNum(120, 18, (u16)score, 4, BLACK);
}


int checkDie(int posVertical, int cactusArray[][CACTUS_CELL_LENGTH]){
    int die = 0;
    for (int i = 0; i < CACTUS_ARRAY_LENGTH; i++){
        /* First, determine what type */
        int cactusHeight, cactusWidth, cactusSize, cactusType = cactusArray[i][1];
        if (cactusType != 0){
            switch (cactusType) {
                case 1 :
                    cactusHeight = CACTUS_ONE_HEIGHT;
                    cactusWidth = CACTUS_ONE_WIDTH;
                    cactusSize = CACTUS_ONE_SIZE;
                    break;
                case 2 :
                    cactusHeight = CACTUS_TWO_HEIGHT;
                    cactusWidth = CACTUS_TWO_WIDTH;
                    cactusSize = CACTUS_TWO_SIZE;
                    break;
                case 3 :
                    cactusHeight = CACTUS_THR_HEIGHT;
                    cactusWidth = CACTUS_THR_WIDTH;
                    cactusSize = CACTUS_THR_SIZE;
                    break;
            }
            
            if (cactusArray[i][0]+cactusWidth >= LEFT_BLANK){
                if ( ( (posVertical+3<=cactusHeight) && (LEFT_BLANK+DINO_BODY_WIDTH>cactusArray[i][0]) ) ||
                    ( (posVertical+DINO_BODY_HEIGHT<=cactusHeight) && (LEFT_BLANK+DINOSAUR_WIDTH>cactusArray[i][0]) )){
                    return 1;
                }
            }   
        }
    }
    return die;
}

void drawClouds(int cloudArray[][2]){
    int addOne = 0;
    for (int i = 0; i < CACTUS_ARRAY_LENGTH; i++){
        /* First, determine what type */
        int cloudHeight, cloudWidth;
        
        cloudHeight = CLOUD_HEIGHT;
        cloudWidth = CLOUD_WIDTH;
        /* Clear old cactus */
        u16 startHorizon = cloudArray[i][0] >= -CLOUD_MOVE_SPEED ? cloudArray[i][0]+CLOUD_MOVE_SPEED : 0;
        u16 endHorizon = cloudArray[i][0] + cloudWidth-1+CLOUD_MOVE_SPEED<159 ? cloudArray[i][0] + cloudWidth-1+CLOUD_MOVE_SPEED : 159;

        if (startHorizon >= 0 && endHorizon <= 159)
            LCD_Fill(endHorizon-CLOUD_MOVE_SPEED+1, cloudArray[i][1], endHorizon, cloudArray[i][1] + cloudHeight-1, WHITE);

        /* Calculate new position */
 
        if (cloudArray[i][0] <= -cloudWidth){
                /* The first one totally leaves */
            addOne = 1;
        }
        else{
            startHorizon = cloudArray[i][0] >= 0 ? cloudArray[i][0] : 0;
            // startHorizon = cactusArray[i][0];
            endHorizon = cloudArray[i][0] + cloudWidth-1<159 ? cloudArray[i][0] + cloudWidth-1: 159;
            LCD_Address_Set(startHorizon, cloudArray[i][1], endHorizon, cloudArray[i][1] + cloudHeight-1);
            if (cloudArray[i][0] < 0){
                int w = endHorizon-startHorizon+1;
                for(int i=0; i<w*cloudHeight; i++)
                    LCD_WR_DATA( Cloud[(i/w)*cloudWidth+(i%w)+(cloudWidth-w)] );
            }
            else if (cloudArray[i][0] + cloudWidth-1 >= 159){
                int w = endHorizon-startHorizon+1;
                for(int i=0; i<w*cloudHeight; i++)
                    LCD_WR_DATA( Cloud[(i/w)*cloudWidth+(i%w)] );
            }
            else{
                for(int i=0; i<cloudHeight * cloudWidth; i++)
                    LCD_WR_DATA( Cloud[i] );
            }
            cloudArray[i][0] -= CLOUD_MOVE_SPEED;
        }   
        
    }

    if (addOne && cloudArray[CLOUD_ARRAY_LENGTH-1][0]<80){
        if ((rand()%100)>=95){
            cloudArray[0][0] = cloudArray[CLOUD_ARRAY_LENGTH-1][0];
            cloudArray[0][1] = cloudArray[CLOUD_ARRAY_LENGTH-1][1];
            cloudArray[CLOUD_ARRAY_LENGTH-1][0] = 159;
            cloudArray[CLOUD_ARRAY_LENGTH-1][1] = 5+(rand()%30);
        }
    }
}


void drawGameOver(int posVertical){
    u16 startVertical = 80 - GROUND_HEIGHT - posVertical - DINOSAUR_HEIGHT;
    LCD_Address_Set(LEFT_BLANK, startVertical, LEFT_BLANK + DINOSAUR_WIDTH -1, startVertical+DINOSAUR_HEIGHT-1);
    for(int i=0; i<DINOSAUR_SIZE; i++)
        LCD_WR_DATA(Dinosaur[3][i]);
}

void drawMaxScore(int maxScore){
    int i, bits[4];
    int posX[4] = {25, 55, 85, 115};
    bits[0] = maxScore/1000; maxScore -= bits[0]*1000;
    bits[1] = maxScore/100; maxScore -= bits[1]*100;
    bits[2] = maxScore/10; maxScore -= bits[2]*10;
    bits[3] = maxScore;
    LCD_Clear(BLACK);
    for (i=0; i<4; i++){
        switch (bits[i]){
            case 0:
                drawZero(posX[i], 35); break;
            case 1:
                drawOne(posX[i], 35); break;
            case 2:
                drawTwo(posX[i], 35); break;
            case 3:
                drawThree(posX[i], 35); break;
            case 4:
                drawFour(posX[i], 35); break;
            case 5:
                drawFive(posX[i], 35); break;
            case 6:
                drawSix(posX[i], 35); break;
            case 7:
                drawSeven(posX[i], 35); break;
            case 8:
                drawEight(posX[i], 35); break;
            case 9:
                drawNine(posX[i], 35); break;
            }
    }

    LCD_ShowString(30,  10, (u8 *)("HIGHEST SCORE"), BLACK);
}