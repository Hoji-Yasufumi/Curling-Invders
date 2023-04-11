void SceneHowToPlay(){
  image(startBackgroundImg, width/2, height/2);
  image(howToPlayBackgroundImg,width/2,height/2);
  
  if(180 < mouseX && mouseX < 180+721.15 && 2013.33 < mouseY && mouseY < 2013.33+145.42)
  {
    if(touchStart)
    {
      //image(backToHomeFromHowToPlayHoverImg, 180+721.15/2, 2013.33+145.42/2);
    }
    
    if(touchFinish)
    {
      scene = 0;
      touchFinish = false;
    }
  }
}
