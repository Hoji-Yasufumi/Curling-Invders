//ストーンを押した後に、上にスライドできるようにするための変数
int click = 0;

void SceneStart(){
  
  image(startBackgroundImg, width/2, height/2);
  
  /*
  //マウスを押しているとき
  if(mousePressed == true){
    
    //元の画像以外の場所をクリックしても反応しないようにする。
    //一度も画像を押していなくて、マウスが画像の上にあるとき
    if(click == 0){
      //元の画像上にマウスがあるとき
      if(393 < mouseX && mouseX< 1080-393.7 && 1131.29 < mouseY && mouseY < 2400-1131.29){
        image(startBackground,width/2,height/2); 
        image(setting,341+setting.width/2,778+setting.height/2);
        image(arrow,width/2,271+arrow.height/2);
        image(play,293+play.width/2,779+play.height/2);
        image(stone, width/2, mouseY-56);
        
        //一度画像をクリックしたらclick=1にする
        click = 1;
        
        //画像が下に行かないようにする
        if(478 < mouseY+56){
          image(startBackground,width/2,height/2); 
          image(setting,341+setting.width/2,778+setting.height/2);
          image(arrow,width/2,271+arrow.height/2);
          image(play,293+play.width/2,779+play.height/2);
          image(stone, width/2, 478-112+stone.height/2);
        }
      }
    }
    
    //画像を押していて、マウスが画像の外に出たとき
    if(click == 1){
      if(139 < mouseX && mouseX< 251 && mouseY < 478){
        image(startBackground,width/2,height/2); 
        image(setting,341+setting.width/2,778+setting.height/2);
        image(play,293+play.width/2,779+play.height/2);
        
        //矢印を薄くしていく
        tint(255, -70 + mouseY);
        image(arrow,width/2,271+arrow.height/2);
        tint(255, 255);
        
        //ストーン表示
        image(stone, width/2, mouseY-56+stone.height/2);
        
        //画像が下に行かないようにする
        if(478 < mouseY+56){
          image(startBackground,width/2,height/2); 
          image(setting,341+setting.width/2,778+setting.height/2);
          image(arrow,width/2,271+arrow.height/2);
          image(play,293+play.width/2,779+play.height/2);
          image(stone, width/2, 478-112+stone.height/2);
        }
        
        
        
        //ボタンを押していて、かつマウスがハウスの真ん中に来たときにシーン変更
        if(13 < mouseY && mouseY < 13+51){
          
          //ゲーム画面に移行
          scene = 1;
        }
      }
    }
  }else{
    //マウスを一度も押していない状態へするためにclick=0とする
    click = 0;
  }
  */
  
  //ゲーム画面へ遷移する
  if(width/2-150 < mouseX && mouseX < width/2+150 && height/2-150 < mouseY && mouseY < height/2+150)
  {
    if(touchStart)
    {
      
    }
    
    if(touchFinish)
    {
      scene = 1;
      touchFinish = false;
    }
  }
  
  //遊び方の画面へ変更
  if(737 < mouseX && mouseX < 737+126 && 2106.42 < mouseY && mouseY < 2106.42+165.56)
  {
    if(touchStart)
    {
      image(playHoverImg,737+playHoverImg.width/2, 2106.42+30.42);
    }
    
    if(touchFinish)
    {
        scene = 3;
        touchFinish = false;
    }
  }
  
  //設定の画面へ変更
  if(925 < mouseX && mouseX < 925+96.08 && 2103 < mouseY && mouseY < 2103+169.26)
  {
    if(touchStart)
    {
      image(settingHoverImg,925+settingHoverImg.width/2, 2103+33);
    }
    
    if(touchFinish)
    {
        scene = 4;
        touchFinish = false;
    }
  }
}
