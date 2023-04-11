//Bluetooth関係のインポート-----------------
import android.content.Intent;
import android.os.Bundle;
import ketai.net.bluetooth.*;
import ketai.ui.*;
import ketai.net.*;
//--------------------------------------------


//データ読み込み専用
int valOfStoneRedBig;

PImage startBackgroundImg, settingHoverImg, playHoverImg;
PImage howToPlayBackgroundImg, backToHomeFromHowToPlayImg, backToHomeFromHowToPlayHoverImg;
PImage settingBackgroundImg;
PImage gameBackgroundImg, firstTextImg, secondTextImg, leftArrowImg, rightArrowImg, stoneLightLv1Img, stoneLightLv2Img, stoneRedBigImg, stoneYellowImg, stoneRedImg, backToHomeFromGameImg, backToHomeFromGameHoverImg, tx_stone, range;
PImage gameoverBackgroundImg, backtohome2_hover, retry_hover;

//画面遷移のための変数
int scene = 0;

//スコアを帆残しておくための変数
int score = 0;

//黄色のストーン8コのx,y座標を入れるための配列
Stone stonesYellow[] = new Stone[8];
//赤いストーンのクラス
Stone stoneRed;
//普通のストーンのクラス
class Stone {
  //ストーンを表示させるかの判定
  boolean appear = true;
  //座標
  float x = 0;
  float y = 0;
  //半径
  int r = 35;
  //座標の増減
  float d_x = 0;
  float d_y = 0;
  //当たったストーンかの判定
  boolean hit = false;
  //画像
  PImage img;
  Stone(int r, PImage img) {
    this.r = r;
    this.img = img;
  }
}

//画面遷移したときに黄色のストーンの座標をやり直すための変数
boolean tryRandom = true;
//ストーンが止まっていることを確認するためのストーンの回転角を一度保存しておく変数
float stopValOfStoneRedBig = 0;
//実際のストーンが半回転したことを判定するための変数 0=回転していない 1=回転している 2=回転した後止まった
int judgeValOfStoneRedBig = 0;
//実際のストーンが動き出したらゲームのストーンの位置を定位置まで持っていくための変数
int AddYOfstoneBigRed = 0;
//実際のストーンが最後に止まった角度を保存するための変数
int finalStopValOfStoneRedBig = 0;
//ストーンが何回投げられたかを数える変数
int countThrowStone = 0;
//現在の経過時間を入れる変数
int nowTime;
//ストーンの回転角と時間の保存が一度だけかの判断
boolean judgeStopValOfStoneRedBig = true;

//最初の矢印を表示させる変数
boolean judgeLeftArrow = true;
boolean judgeRightArrow = true;

//ストーンを光らせるための変数
boolean judgeStoneLightLv1 = false;
boolean judgeStoneLightLv2 = false;

//画面に指が触れたことを感知する変数
boolean touchStart = false;
//画面から指が離れたことを感知する変数
boolean touchFinish = false;

//bluetooth関連----------------------------------------------------------------
PFont fontMy;
boolean bReleased = true; //no permament sending when finger is tap
KetaiBluetooth bt;
boolean isConfiguring = true;
String info = "";
KetaiList klist;
ArrayList devicesDiscovered = new ArrayList();

void onCreate(Bundle savedInstanceState) {
 super.onCreate(savedInstanceState);
 bt = new KetaiBluetooth(this);
}

void onActivityResult(int requestCode, int resultCode, Intent data) {
 bt.onActivityResult(requestCode, resultCode, data);
}
//--------------------------------------------------------------------------------

void setup() {
  fullScreen();
  imageMode(CENTER);
  
  //画像の読み込み-------------------------------------------------------------------------
  //Start画面の画像読み込み
  startBackgroundImg = loadImage("Start_back.png");
  settingHoverImg = loadImage("Start_set_hover.png");
  playHoverImg = loadImage("Start_howtoplay_hover.png");

  //HowToPlay画面の画像読み込み
  howToPlayBackgroundImg = loadImage("Howtoplay_back.png");
  backToHomeFromHowToPlayImg = loadImage("Howtoplay_titleback.png");
  backToHomeFromHowToPlayHoverImg = loadImage("Howtoplay_tilteback_hover.png");

  //Setting画面の画像読み込み
  settingBackgroundImg = loadImage("Set_back.png");

  //Game画面の画像読み込み
  gameBackgroundImg =loadImage("Game_back.png");
  stoneRedBigImg = loadImage("Game_stone_red_big.png");
  firstTextImg = loadImage("Game_first_text.png");
  secondTextImg = loadImage("Game_second_text.png");
  leftArrowImg = loadImage("Game_arrow_left.png");
  rightArrowImg = loadImage("Game_arrow_right.png");
  stoneLightLv1Img = loadImage("Game_stone_light_effect_lv1.png");
  stoneLightLv2Img = loadImage("Game_stone_light_effect_lv2.png");
  stoneYellowImg = loadImage("Game_stone_yellow.png");
  stoneRedImg = loadImage("Game_stone_red_small.png");
  backToHomeFromGameImg = loadImage("Game_titleback.png");
  backToHomeFromGameHoverImg = loadImage("Game_titleback_hover.png");
  range = loadImage("Game_range.png");

  //Gameover画面の画像読み込み
  gameoverBackgroundImg = loadImage("Gameover_back.png");
  backtohome2_hover = loadImage("Gmaeover_titleback_hover.png");
  retry_hover = loadImage("Gameover_try_hover.png");
  //------------------------------------------------------------------------------------

  //黄色いストーンの配列を初期化
  for (int i = 0; i < 8; i++) {
    stonesYellow[i] = new Stone(stoneYellowImg.width/2, stoneYellowImg);
  }
  stoneRed = new Stone(stoneRedImg.width/2, stoneRedImg);
  
  
//bluetooth関連------------------------------
 //start listening for BT connections
 bt.start();
 //at app start select device…
 isConfiguring = true;
 //font size
 fontMy = createFont("SansSerif", 40);
 textFont(fontMy);
//---------------------------------------------
}


void draw() {
  //bluetooth関連-----------------------------------------------
  //at app start select device
  if (isConfiguring)
  {
    klist = new KetaiList(this, bt.getPairedDeviceNames());
    isConfiguring = false;
  }
  else
  {
  //------------------------------------------------------------
    //ホーム画面
    if (scene == 0) {
      SceneStart();
      //ホーム画面に戻ってきたときに黄色のストーンをランダムに決められるようにする
      tryRandom = true;
      
    //ゲーム画面
    } else if (scene == 1) {
      SceneGame();
      
    //ゲームオーバー画面
    } else if (scene == 2) {
      SceneGameover();
      
    //遊び方画面
    } else if (scene == 3) {
      SceneHowToPlay();
      
    //設定画面
    } else if (scene == 4) {
      SceneSetting();
    }
  }
}

//bluetooth通信の実装のため---------------------------------------
void onKetaiListSelection(KetaiList klist) {
 String selection = klist.getSelection();
 bt.connectToDeviceByName(selection);
 //dispose of list for now
 klist = null;
}

//バイナリで受け取ったデータの変換
void onBluetoothDataEvent(String who, byte[] data) {
 if (isConfiguring)return;
 //received
 info = new String(data);
 valOfStoneRedBig = int(info);
 //clean if string to long
 if(info.length() > 150)info = "";
}
//-----------------------------------------------------------------

//円形の衝突判定
boolean isCollisionStone(Stone s1, Stone s2)
{
  float dx, dy, dr;
  dx = s1.x-s2.x;
  dy = s1.y-s2.y;
  //2つの円形の各々の中心との距離
  dr = sqrt(sq(dx) + sq(dy));
  
  //println("s1.x:" + s1.x + " s1.y:" + s1.y + " s2.x:" + s2.x + " s2.y:" + s2.y + " s1.r:" + s1.r + " s2.r:" + s2.r + " dr:" + dr);
  
  if(s1.r+s2.r >= dr)
  {
    return true;
  }else{
    return false;
  }
}

//タップの動作------------------
void touchStarted()
{
  touchStart = true;
  touchFinish = false;
  println("Start");
}

void touchMoved()
{
  println("Pushhing");
}

void touchEnded()
{
  touchFinish = true;
  touchStart = false;
  println("Finish");
}
//-------------------------------
