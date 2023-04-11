void StoneYellowRandom(){
  //黄色のストーンの座標をランダムで決める
  if(tryRandom == true){
      for(int i = 0; i < 8; i++){
        float x = random(width/2-300,width/2+300);
        
        //x軸がハウスの赤い部分と被っていた場合もう一度x軸をランダムに振り直す
        while(width/2-150 < x && x < width/2+150){
          x = random(width/2-300,width/2+300);
        }
        
        stonesYellow[i].x = x;
        
        float y = random(516-300, 516+300);
        
        //y軸がハウスの赤い部分と被っていた場合もう一度y軸をランダムに振り直す
        while(516-150 < y && y < 516+150){
          y = random(516-300, 516+300);
        }
        
        stonesYellow[i].y = y;
      }
      
      
      //黄色いストーン同士が被っていた時の対処
      for(int i = 0; i < 8; i++)
      {
        //一度変数xにx軸の座標を入れる
        float x = stonesYellow[i].x;
        //一度変数yにy軸の座標を入れる
        float y = stonesYellow[i].y;
        
        for(int j = 0; j < 8; j++)
        {
          if(i != j)
          {
            while(isCollisionStone(stonesYellow[i],stonesYellow[j]))
            {
              //もう一度座標をランダムで振り直す
              x = random(width/2-300,width/2+300);
              y = random(516-300, 516+300);
              
              while(width/2-150 < x && x < width/2+150)
              {
                //もう一度座標をランダムで振り直す
                x = random(width/2-300,width/2+300);
              }
              
              while(516-150 < y && y < 516+150)
              {
                //もう一度座標をランダムで振り直す
                y = random(516-300, 516+300);
              }
              
              stonesYellow[i].x = x;
              stonesYellow[i].y = y;
              
              println("stonesYellow[" + i + "].x: " + stonesYellow[i].x + " stonesYellow[" + i + "].y: " + stonesYellow[i].y + " stonesYellow[" + j + "].x: " + stonesYellow[j].x + " stonesYellow[" + j + "].y]: " + stonesYellow[j].y);
            }
            //全てのストーンと被ってなかったら参照した配列の番地に再び入れる
            //stonesYellow[i].x = x;
            //stonesYellow[i].y = y;
          }
        }
      }
        
        /*
        //一度変数xにx軸の座標を入れる
        float x = stonesYellow[i].x;
        //一度変数yにy軸の座標を入れる
        float y = stonesYellow[i].y;
        
        //すべてのストーンの座標と被っていないか比較する
        for(int j = 0; j < 8; j++){
          //x軸とy軸が他のストーンと被っているときwhile文を回し、もう一度座標を振り直す。
          while(x-40 < stonesYellow[j].x+40 && stonesYellow[j].x-40 < x+40 && y-40 < stonesYellow[j].y+40 && stonesYellow[j].y-40 < y+40){
            //もう一度座標をランダムで振り直す
            x = random(width/2-300,width/2+300);
            y = random(516-300, 516+300);
            
            //ランダムで振り直したときにハウスの赤い部分と被っているストーンが出ないようにする
            while(width/2-150 < x && x < width/2+150 && 516-150 < y && y < 516+150){
              x = random(width/2-300,width/2+300);
              y = random(516-300, 516+300);
            }
            print("overlap");
          }
          //全てのストーンと被ってなかったら参照した配列の番地に再び入れる
          stonesYellow[i].x = x;
          stonesYellow[i].y = y;
        }
        */
        
      }
      
      
      //ゲーム画面で1度黄色のストーンをランダムに決めたことを判定する
      tryRandom = false;
    }
