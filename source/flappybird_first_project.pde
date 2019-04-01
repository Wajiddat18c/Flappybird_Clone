// Wajid Ahmad
// "Flappy Bird"

PImage backImg =loadImage("http://i.imgur.com/cXaR0vS.png");
PImage birdImg =loadImage("http://i.imgur.com/mw0ai3K.png");
PImage wallImg =loadImage("http://i.imgur.com/4SUsUuc.png");
PImage startImg=loadImage("http://i.imgur.com/U6KEwxe.png");
int gamestate = 1;
int x = -200;
int y = 0;
int score = 0;
int highscore = 0;
int hastighed = 0;
int[] wallX = new int[2];
int[] wallY = new int[2];
void setup() {
  //sætter skærmens størrelse
  size (600, 800);
  // sætter font på tekst.
  fill(0);
  textSize(40);
}

void draw() { //draw kørrer programmet 60 gange pr sek.
  if (gamestate == 0) {
    imageMode(CORNER);
    image(backImg, x, 0);
    image(backImg, x+backImg.width, 0);
    //baggrund kører
    x -= 6;
    //fuglen får vægt
    hastighed += 1;
    y += hastighed;
    //baggrund kører uendeligt
    if (x == 1800) x = 0;
    //laver en forløkke der laver vægge.
    for (int i = 0; i < 2; i++) {
      imageMode(CENTER);
      //laver et mellemrum mellem de to vægge på 200 pixel.
      image(wallImg, wallX[i], wallY[i] - (wallImg.height/2+100));
      image(wallImg, wallX[i], wallY[i] + (wallImg.height/2+100));
      //hvis wallX[i] er midre end 0 så laver den en random væg på Y-pos.
      if (wallX[i] < 0) {
        wallY[i] = (int)random(200, height-200);
        wallX[i] = width;
      }
      //hvis fuglen flyver gennem en væg bliver score + 1.
      if (wallX[i] == width/2) {
        score++;
        //max er ligesom i java Math.max
        highscore = max (score, highscore);
      }
      if (y > height || y < 0 || (abs(width/2 - wallX[i]) < 25 && abs(y-wallY[i])> 100)) {
        gamestate = 1;
      }
      wallX[i] -= 6;
    }
    //laver fuglen i midden af skærmen.
    image(birdImg, width/2, y);
    //viser din nuværende score.
    text("" + score, width/2-15, 700);
  } else {
    //når vi taber.
    imageMode(CENTER);
    image(startImg, width/2, height/2);
    text("High Score: " + highscore, width/2, 700);
    text("Lavet af: Wajid Ahmad", 0, 800);
  }
}
void mousePressed() { //sker noget når du trykker på særmen.
  //hvergang der bliver trykket vil fuglen flyve
  hastighed = -17;
  // gamestate starter med at være 1 og derfor laver vi væggene selv. 
  if (gamestate == 1) {
    wallX[0] = 600;
    wallY[0] = height/2;
    wallX[1] = 900;
    wallY[1] = 600;
    // fuglen starter på x, y( i midden af skærmen).
    x = 0;
    y = height / 2;
    //resætter scoren.
    score = 0;
    //sætter gamestate til 0 og spillet starter.
    gamestate = 0;
  }
}
