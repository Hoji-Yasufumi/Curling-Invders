void SceneGame()
{
  //黄色のストーンの座標をランダムで決める
  StoneYellowRandom();
  
  image(gameBackgroundImg, width/2, height/2+50);
  image(backToHomeFromGameImg, backToHomeFromGameHoverImg.width/2+50, height-100);
  
  if (backToHomeFromGameHoverImg.width/2+50-backToHomeFromGameHoverImg.width/2 < mouseX && mouseX < backToHomeFromGameHoverImg.width/2+50+backToHomeFromGameHoverImg.width/2 && height-100-backToHomeFromGameHoverImg.height/2 < mouseY && mouseY < height-100+backToHomeFromGameHoverImg.height/2)
  {
    image(backToHomeFromGameHoverImg, backToHomeFromGameHoverImg.width/2+50, height-100);
    if (mousePressed == true)
    {
      scene = 0;
    }
  }
  
  //取得したデータの確認
  fill(0);
  textSize(30);
  text(valOfStoneRedBig,50,50);
  text(countThrowStone,50,100);
  text(score,50,150);

  //ランダムでハウスの上に黄色のストーンを表示
  for (int i = 0; i < 8; i++)
  {
     if(stonesYellow[i].appear)image(stoneYellowImg, stonesYellow[i].x, stonesYellow[i].y);
     //println("stonesYellow[" + i + "].x:" + stonesYellow[i].x + "stonesYellow[" + i + "].y:" + stonesYellow[i].y);
  }
  
  //judgeValOfStoneRedBig == 0のときは実際のストーンが左右に回転するまでの処理
  if (judgeValOfStoneRedBig == 0)
  {
    
    //矢印とストーンの光と最初のテキストの表示
    if(judgeLeftArrow) image(leftArrowImg, width/2-100,height/2+600);
    if(judgeRightArrow) image(rightArrowImg, width/2+100,height/2+600);
    if(judgeStoneLightLv1) image(stoneLightLv1Img, width/2, height/2+700);
    if(judgeStoneLightLv2) image(stoneLightLv2Img, width/2, height/2+700);
    image(firstTextImg, width/2, height/2+200);
    
    //赤ストーン大を表示
    pushMatrix();
    translate(width/2, height/2+700);
    rotate(radians(valOfStoneRedBig));
    image(stoneRedBigImg, 0, 0);
    popMatrix();
    
    //ストーンの回転が90°または270°になったら矢印を消してストーンをLv1に光らせる
    if (80 <= valOfStoneRedBig && valOfStoneRedBig <= 100)
    {
      judgeRightArrow = false;
      judgeStoneLightLv1 = true;
    }
    if (260 <= valOfStoneRedBig && valOfStoneRedBig <= 280)
    {
      judgeLeftArrow = false;
      judgeStoneLightLv1 = true;
    }
    //どちらの矢印も消えたら、ストーンをLv2に光らせる
    if(judgeRightArrow == false && judgeLeftArrow == false)
    {
      judgeStoneLightLv2 = true;
      judgeStoneLightLv1 = false;
      judgeValOfStoneRedBig = 1;
    }
    
    
   }
   
   //judgeValOfStoneRedBig == 1のときはストーンが2s止まっているかどうかを判定する処理
   else if (judgeValOfStoneRedBig == 1)
   {
     //ストーンの光と次のテキストの表示
     if(judgeStoneLightLv2) image(stoneLightLv2Img, width/2, height/2+700);
     image(secondTextImg, width/2, height/2+200);
     
     //赤ストーン大を表示
     pushMatrix();
     translate(width/2, height/2+700);
     rotate(radians(valOfStoneRedBig));
     image(stoneRedBigImg, 0, 0);
     popMatrix();
     
     
     if(judgeStopValOfStoneRedBig)
     {
     //ストーンの回転角と時間を一度保存しておく
     stopValOfStoneRedBig = valOfStoneRedBig;
     nowTime = millis();
     judgeStopValOfStoneRedBig = false;
     }
     
     //1度経過時間を記録した2s後の処理
     if (nowTime+2000 < millis())
     {
       judgeStopValOfStoneRedBig = true;
       if(valOfStoneRedBig-2 < stopValOfStoneRedBig && stopValOfStoneRedBig < valOfStoneRedBig+2)
       {
         finalStopValOfStoneRedBig = valOfStoneRedBig;
         judgeValOfStoneRedBig = 2;
       }
     }
   }
   
   //judgeValOfStoneRedBig == 2のときはゲームのストーンがハウスの中心までいくための処理
   else if(judgeValOfStoneRedBig == 2)
   {
     
     //赤ストーン大を表示
     pushMatrix();
     translate(width/2, height/2+700-AddYOfstoneBigRed);
     rotate(radians(finalStopValOfStoneRedBig));
     image(stoneRedBigImg, 0, 0);
     popMatrix();
     
     //ストーンを移動させる
     AddYOfstoneBigRed+=10;
     
     if(height/2+700-AddYOfstoneBigRed < 516) judgeValOfStoneRedBig = 3;
   }
   
   //judgeValOfStoneRedBig == 3のときは赤い小ストーンを角度に応じて出す処理
   else if(judgeValOfStoneRedBig == 3)
   {
     
     //赤ストーン大を表示
     pushMatrix();
     translate(width/2, 516);
     rotate(radians(finalStopValOfStoneRedBig));
     image(stoneRedBigImg, 0, 0);
     rotate(radians(-finalStopValOfStoneRedBig));
     
     //赤ストーンの挙動--------------------------------------------------------------
     if(0 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 90)
     {
       stoneRed.d_x = 10 * sin(radians(finalStopValOfStoneRedBig));
       stoneRed.d_y = -10 * cos(radians(finalStopValOfStoneRedBig));
     }
     
     if(90 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 180)
     {
       stoneRed.d_x = 10 * cos(radians(finalStopValOfStoneRedBig-90));
       stoneRed.d_y = 10 * sin(radians(finalStopValOfStoneRedBig-90));
     }
     
     if(180 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 270)
     {
       stoneRed.d_x = -10 * sin(radians(finalStopValOfStoneRedBig-180));
       stoneRed.d_y = 10 * cos(radians(finalStopValOfStoneRedBig-180));
     }
     
     if(270 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 360)
     {
       stoneRed.d_x = -10 * cos(radians(finalStopValOfStoneRedBig-270));
       stoneRed.d_y = -10 * sin(radians(finalStopValOfStoneRedBig-270));
     }
     
     //当たったら赤ストーンの速度を落とす
     for (int i = 0; i < 8; i++)
     { 
       println(stonesYellow[i].hit);
       if(stonesYellow[i].hit == true)
       {
         if(0 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 90)
         {
           stoneRed.d_x = 5 * sin(radians(finalStopValOfStoneRedBig));
           stoneRed.d_y = -5 * cos(radians(finalStopValOfStoneRedBig));
         }
         
         if(90 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 180)
         {
           stoneRed.d_x = 5 * cos(radians(finalStopValOfStoneRedBig-90));
           stoneRed.d_y = 5 * sin(radians(finalStopValOfStoneRedBig-90));
         }
         
         if(180 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 270)
         {
           stoneRed.d_x = -5 * sin(radians(finalStopValOfStoneRedBig-180));
           stoneRed.d_y = 5 * cos(radians(finalStopValOfStoneRedBig-180));
         }
         
         if(270 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 360)
         {
           stoneRed.d_x = -5 * cos(radians(finalStopValOfStoneRedBig-270));
           stoneRed.d_y = -5 * sin(radians(finalStopValOfStoneRedBig-270));
         }
       }
     }
     //------------------------------------------------------------------------------
     
     image(stoneRedImg, stoneRed.x+=stoneRed.d_x, stoneRed.y+=stoneRed.d_y);
     //println("stoneRed.x:" + stoneRed.x + " stoneRed.y:" + stoneRed.y);
     
     //黄色のストーンと当たっているかの判定
     for (int i = 0; i < 8; i++) {
       //座標点をずらしているため、衝突するときだけstonesYellowの座標をずらす-------
       float saveX = 0;
       float saveY = 0;
       
       saveX = stonesYellow[i].x;
       saveY = stonesYellow[i].y;
       
       stonesYellow[i].x = stonesYellow[i].x-width/2;
       stonesYellow[i].y = stonesYellow[i].y-516;
       //-------------------------------------------------------------------------
       
       //println("stone" + i);
       //println("stoneRed.x:" + stoneRed.x + " stoneRed.y:" + stoneRed.y);
       if (isCollisionStone(stoneRed, stonesYellow[i]))
       {
         //println("Hit");
         stonesYellow[i].hit = true;
       }
       //println(isCollisionStone(stone_red, stonesYellow[i]));
      
       //ずらしたstonesYellowの座標を戻す
       stonesYellow[i].x = saveX;
       stonesYellow[i].y = saveY;
    }
    
    //当たった黄色いストーンの移動---------------------------------------------------------------
    for (int i = 0; i < 8; i++)
    {
      if(stonesYellow[i].hit)
      {
        if(0 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 90)
        {
          stonesYellow[i].d_x = 10 * sin(radians(finalStopValOfStoneRedBig));
          stonesYellow[i].d_y = -10 * cos(radians(finalStopValOfStoneRedBig));
        }
       
        if(90 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 180)
        {
          stonesYellow[i].d_x = 10 * cos(radians(finalStopValOfStoneRedBig-90));
          stonesYellow[i].d_y = 10 * sin(radians(finalStopValOfStoneRedBig-90));
        }
       
        if(180 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 270)
        {
          stonesYellow[i].d_x = -10 * sin(radians(finalStopValOfStoneRedBig-180));
          stonesYellow[i].d_y = 10 * cos(radians(finalStopValOfStoneRedBig-180));
        }
       
        if(270 <= finalStopValOfStoneRedBig && finalStopValOfStoneRedBig < 360)
        {
          stonesYellow[i].d_x = -10 * cos(radians(finalStopValOfStoneRedBig-270));
          stonesYellow[i].d_y = -10 * sin(radians(finalStopValOfStoneRedBig-270));
        }
        
        stonesYellow[i].x+=stonesYellow[i].d_x;
        stonesYellow[i].y+=stonesYellow[i].d_y;
      }
    }
    //----------------------------------------------------------------------------------------------
    
    //赤ストーンをどこまで滑らすかを実行
    if (stoneRed.x < -500 || 500 < stoneRed.x || stoneRed.y < -500 || 500 < stoneRed.y)
    {
      stoneRed.x = 0;
      stoneRed.y = 0;
      judgeLeftArrow = true;
      judgeRightArrow = true;
      judgeStoneLightLv1 = false;
      judgeStoneLightLv2 = false;
      countThrowStone +=1;
      
      
      //赤ストーンが消えたら当たっていた黄色ストーンも消す
      for (int i = 0; i < 8; i++)
      {
        if(stonesYellow[i].hit)
        {
          score+=125;
          stonesYellow[i].appear = false;
          stonesYellow[i].hit = false;
        }
      }
      AddYOfstoneBigRed = 0;
      judgeValOfStoneRedBig = 0;
    }
    
    popMatrix();
    
   }
   
   //ストーンを8回投げたらゲームオーバーする
   if(countThrowStone == 8)
   {
     
     //赤ストーンが消えたら当たっていた黄色ストーンも消す
     for (int i = 0; i < 8; i++)
     {
       if(stonesYellow[i].appear == false)
       {
         stonesYellow[i].appear = true;
       }
     }
     
     scene = 2;
   }
   
   //全ての黄色ストーンを場外に出したらゲームオーバーする
   if(score == 1000)
   {
     //赤ストーンが消えたら当たっていた黄色ストーンも消す
     for (int i = 0; i < 8; i++)
     {
       if(stonesYellow[i].appear == false)
       {
         stonesYellow[i].appear = true;
       }
     }
     
     scene = 2;
   }
   
   
   //デバック------------------------------------------------
   if(0 < mouseX && mouseX < 100 && 0 < mouseY && mouseY < 100)
   {
     if (touchIsStarted)
      {
        if(touchStart){
          scene = 2;
          touchFinish = false;
        }
      }
   }
}
