void SceneGameover(){
  image(gameBackgroundImg, width/2, height/2);
  image(gameoverBackgroundImg, width/2, height/2);
  fill(#606060);
  textSize(184.8);
  text(score, 250, 1400);
  textSize(92.4);
  text("pt", 750, 1390);
  
  //ホーム画面に移動
  if(99 < mouseX && mouseX < 99+577.49 && 2061.77 < mouseY && mouseY < 2061.77+211.11)
  {
    if(touchStart)
    {
    }
    
    if(touchFinish)
    {
      touchFinish = false;
      tryRandom = true;
      countThrowStone = 0;
      score = 0;
      scene = 0;
    }
  }
  
  //ゲーム画面に移動
  if(730 < mouseX && mouseX < 730+222.43 && 2081.84 < mouseY && mouseY < 2081.84+222.59)
  {
    if(touchStart)
    {
    }
    
    if(touchFinish)
    {
      touchFinish = false;
      tryRandom = true;
      StoneYellowRandom();
      countThrowStone = 0;
      score = 0;
      scene = 1;
    }
  }
}
