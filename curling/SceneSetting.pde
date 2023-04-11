void SceneSetting(){
  image(startBackgroundImg, width/2, height/2);
  image(settingBackgroundImg,width/2,height/2);
  
  if(184.83 < mouseX && mouseX < 184.83+739.34 && 1020.85 < mouseY && mouseY < 1020.85+147.87)
  {
    if(touchStart)
    {
    }
    
    if(touchFinish)
    {
      scene = 0;
      touchFinish = false;
    }
  }
}
