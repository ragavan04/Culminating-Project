float playerWidth, playerHeight, playerX, playerY, speedX, speedY;
float turretWidth, turretHeight, turret1X, turret1Y, turret2X, turret2Y, turret3X, turret3Y, turret4X, turret4Y, turret5X, turret5Y;
int turret1Lives, turret2Lives, turret3Lives, turret4Lives, turret5Lives;
int turret1Status, turret2Status, turret3Status, turret4Status, turret5Status;
float bulletWidth, bulletHeight;
int mainTurretLives;
float wallWidth, wallHeight, wall1X, wall1Y, wall2X, wall2Y, wall3X, wall3Y, wall4X, wall4Y;
int playerLives;
float mainTurretX, mainTurretY, mainTurretSize;
int buttonWidth, buttonHeight, playButtonX, playButtonY;
int livesUpgradeX, livesUpgradeY, livesDisplayX, livesDisplayY, coinsDisplayX, coinsDisplayY;
int bulletsUpgradeX, bulletsUpgradeY;
int bulletsUpgradeFlag;
int shopButtonHeight, shopButtonWidth, shopButtonX, shopButtonY, shopButton2X, shopButton2Y;
int backButtonWidth, backButtonHeight, backButtonX, backButtonY; 
int coins;
int arraySize;
float coinSize;
float[] coinX, coinY, coinSX, coinSY;
PImage turretIMG, gameWallpaper, coin, planet, bullet, mainMenu, shop;
int turret, bulletSpeed;
int screen;

//arrrayList for turret bullets
ArrayList<Float> turretBulletX = new ArrayList<Float>();
ArrayList<Float> turretBulletY = new ArrayList<Float>();
ArrayList <Boolean> bulletState = new ArrayList<Boolean>();

//arrayList for turret Y positions
ArrayList <Float> turretYPositions = new ArrayList<Float>();

//arrayList for player bullets
ArrayList<Float> playerBulletX = new ArrayList<Float>();
ArrayList<Float> playerBulletY = new ArrayList<Float>();
ArrayList<Float> playerBulletSX = new ArrayList<Float>();
ArrayList<Float> playerBulletSY = new ArrayList<Float>();


//draw turret function
void drawTurret(float x, float y) {
  image(turretIMG, x, y, turretWidth, turretHeight);

  // add the turret Y positions to arrayList turretYpositions 
  turretYPositions.add(y);

  //populate the turretBulletX and turretBulletY with bullet positions
  turretBulletX.add(x + (16));
  turretBulletY.add(y + turretHeight);

  bulletState.add(false);
}

//shoot turret function
void shootTurret() {

  //selects a random turret to shoot from
  if (frameCount % 5 == 0) {
    turret = floor(random(0, 5));
    bulletState.set(turret, true);
  }

  for (int i=0; i < turretBulletX.size(); i++) { // loop over turretBulletX 
    if (bulletState.get(i) == true) { // check to see if the bulletState of the turret being shot from is true 
      image(bullet, turretBulletX.get(i), turretBulletY.get(i), bulletWidth, bulletHeight);
      turretBulletY.set(i, (turretBulletY.get(i) + bulletSpeed)); //add speed to bulletY to make it move forward
    }
  }

  //if the turretStatus is equal to 1, the turret has been destroyed, therefore move it off the screen
  if (turret1Status == 1) {
    turretBulletX.set(0, -100.0);
  }
  if (turret2Status == 1) {
    turretBulletX.set(1, -100.0);
  }
  if (turret3Status == 1) {
    turretBulletX.set(2, -100.0);
  }
  if (turret4Status == 1) {
    turretBulletX.set(3, -100.0);
  }
  if (turret5Status == 1) {
    turretBulletX.set(4, -100.0);
  }


  for (int i=0; i < turretBulletX.size(); i=i+1) { //loop over turretBulletX 
    if (turretBulletX.get(i) < 0 || turretBulletX.get(i) > width || turretBulletY.get(i) < 0 || turretBulletY.get(i) > height) { //if the bullet is off the screen remove it
      turretBulletY.set(i, turretYPositions.get(i) + turretHeight); //reset the bullet positon
      bulletState.set(i, false); //reset the bullet state to false
    }

    //player vs turret bullet collision
    if (playerX > turretBulletX.get(i) && playerX < turretBulletX.get(i) + bulletWidth && playerY > turretBulletY.get(i) && playerY < turretBulletY.get(i) + playerHeight) { //if the bullet hits the player
      playerLives = playerLives - 1; //decrement the players life
      turretBulletY.set(i, turretYPositions.get(i) + turretHeight); //reset the bullet postion
      bulletState.set(i, false); // set the bullet state back to false

      if (playerLives == 0) { //if the player life is zero the game is over 
        screen = 3;
      }
    }
  }
}

//draw wall function
void drawWall(float wallX, float wallY) {
  fill(#5D1FF0);
  rect(wallX, wallY, wallWidth, wallHeight);

  //player vs wall collision
  if (playerX > wallX && playerX < wallX + wallWidth && playerY >  wallY && playerY < wallY + wallHeight) { 
    playerX = playerX - speedX;
    playerY = playerY - speedY;
  }
}

//buttonMaker function
void buttonMaker(String text, int textSize, int x, int y, int textX, int textY) {
  fill(#ffffff);
  rect(x, y, buttonWidth, buttonHeight); 
  fill(#000000);
  textSize(textSize);
  text(text, x + textX, y + textY);
}


void setup() {
  size(860, 500);

  //player variables
  playerWidth = 20;
  playerHeight = 20;
  playerX = 400;
  playerY = 500;
  speedX = 0; 
  speedY = 0; 

  //player bullet variables
  playerBulletX.add(100.0);
  playerBulletY.add(100.0);
  playerBulletSX.add(5.0);
  playerBulletSY.add(3.0);

  //turret size
  turretWidth = 55;
  turretHeight = 60;

  //turret positions
  turret1X = 62;
  turret1Y = 43;
  turret2X = 480; 
  turret2Y = 193;
  turret3X = 753;
  turret3Y = 99; 
  turret4X = 604; 
  turret4Y = 53; 
  turret5X = 234; 
  turret5Y = 131;

  //turret lives
  turret1Lives = 3;
  turret2Lives = 3;
  turret3Lives = 3;
  turret4Lives = 3;
  turret5Lives = 3;

  //turret alive status, 0 is alive, 1 is dystroyed
  turret1Status = 0;
  turret2Status = 0;
  turret3Status = 0;
  turret4Status = 0;
  turret5Status = 0;

  //turret bullet size and speed
  bulletWidth = 25;
  bulletHeight = 25;
  bulletSpeed = 5;


  turret = floor(random(1, 5));

  //wall size
  wallWidth = 145;
  wallHeight = 10;

  //wall positions
  wall1X = 53;
  wall1Y = 387;
  wall2X = 298;
  wall2Y = 274;
  wall3X = 522;
  wall3Y = 437;
  wall4X = 703;
  wall4Y = 313;


  playerLives = 3;
  coins = 0;
  arraySize = 10;
  coinSize = 20;

  //coin array 
  coinX = new float[arraySize];
  coinY = new float[arraySize];
  coinSX = new float[arraySize];
  coinSY = new float[arraySize];

  //coin movement 
  for (int i=0; i < coinX.length; i = i+1) { //loop coinX
    coinX[i] = 640 + random(width); //determins the X position
    coinY[i] = random(height); //determins the Y position

    coinSX[i] = random(2) - 1; //gives the coin a random speed 
    coinSY[i] = random(2) - 1; //gives the coin a random speed
  }

  screen = 0;

  //main turret variables
  mainTurretX = 390; 
  mainTurretY = 70;
  mainTurretSize = 100;
  mainTurretLives = 5;

  //button variables
  buttonWidth = 200; 
  buttonHeight = 60;
  playButtonX = 320;
  playButtonY = 240;

  //back button shop
  backButtonWidth = 150;
  backButtonHeight = 50;
  backButtonX = 5;
  backButtonY = 5;

  //shop variables
  shopButtonX = 320;
  shopButtonY  = 320;

  //shop upgrades in store
  livesUpgradeX = 100;
  livesUpgradeY = 300;

  bulletsUpgradeX = 400;
  bulletsUpgradeY = 300;
  bulletsUpgradeFlag = 0;

  //lives left display
  livesDisplayX = 5;
  livesDisplayY = 5;

  //coins display 
  coinsDisplayX = 130;
  coinsDisplayY = 5;

  //shop button
  shopButtonWidth = 60;
  shopButtonHeight = 40;
  shopButton2X = 300; 
  shopButton2Y = 5;


  //load images
  turretIMG = loadImage("turret.png");
  gameWallpaper = loadImage("inGame.png");
  coin = loadImage("coin.png");
  planet = loadImage("planet.png");
  bullet = loadImage("bullet.png");
  mainMenu = loadImage("mainMenu.png");
  shop = loadImage("shop.jpg");
}

void draw() {

  //main menu screen
  if (screen == 0) {
    background(mainMenu);
    

    fill(#ffffff);
    textSize(35);
    text("Welcome to", 320, 80);
    textSize(50);
    text("ATTACK PLANET", 230, 140);
    
    buttonMaker("Play", 30, playButtonX, playButtonY, 70, 40);
    buttonMaker("Shop", 30, shopButtonX, shopButtonY, 70, 40);
  } 


  //in game screen
  if (screen == 1) {

    background(gameWallpaper);

    //player
    fill(#ffffff);
    rect(playerX, playerY, playerWidth, playerHeight);


    //player limiting to the screen
    if (playerX < 0) playerX = 0;
    else if (playerX > width) playerX = width;
    if (playerY < 300) playerY = 300;
    else if (playerY > height)playerY = height;

    //player speed
    playerX = playerX + speedX;
    playerY = playerY + speedY;

    //player bullets
    for (int i=0; i < playerBulletX.size(); i=i+1) { //loop for the size of bulletX
      fill(#E52A2A);

      if (bulletsUpgradeFlag == 0) {
        ellipse(playerBulletX.get(i), playerBulletY.get(i), 7, 7); //draws the bullet
      } else if (bulletsUpgradeFlag == 1) {
        ellipse(playerBulletX.get(i), playerBulletY.get(i), 15, 15); //draws the bullet with the bigger bullet upgrade
      }

      playerBulletX.set(i, playerBulletX.get(i) + playerBulletSX.get(i)); //bullet movement
      playerBulletY.set(i, playerBulletY.get(i) + playerBulletSY.get(i)); //bullet movement

      //bullet vs wall collision
      if (playerBulletX.get(i) > wall1X && playerBulletX.get(i) < wall1X + wallWidth && playerBulletY.get(i) >  wall1Y && playerBulletY.get(i) < wall1Y + wallHeight) {
        playerBulletX.set(i, -100.0);
      }
      if (playerBulletX.get(i) > wall2X && playerBulletX.get(i) < wall2X + wallWidth && playerBulletY.get(i) >  wall2Y && playerBulletY.get(i) < wall2Y + wallHeight) {
        playerBulletX.set(i, -100.0);
      }
      if (playerBulletX.get(i) > wall3X && playerBulletX.get(i) < wall3X + wallWidth && playerBulletY.get(i) >  wall3Y && playerBulletY.get(i) < wall3Y + wallHeight) {
        playerBulletX.set(i, -100.0);
      }
      if (playerBulletX.get(i) > wall4X && playerBulletX.get(i) < wall4X + wallWidth && playerBulletY.get(i) >  wall4Y && playerBulletY.get(i) < wall4Y + wallHeight) {
        playerBulletX.set(i, -100.0);
      }

      //bullet vs main turret collision
      if (playerBulletX.get(i) > mainTurretX && playerBulletX.get(i) < mainTurretX + mainTurretSize && playerBulletY.get(i) > mainTurretY && playerBulletY.get(i) < mainTurretY + mainTurretSize) {
        playerBulletX.set(i, -100.0); 
        mainTurretLives = mainTurretLives - 1;
        if (mainTurretLives == 0) {
          mainTurretX = -100;
          screen = 4;
        }
      }
    }


    //Garbage Collection 
    for (int i=0; i < playerBulletX.size(); i=i+1) {
      if (playerBulletX.get(i) < 0 || playerBulletX.get(i) > width || playerBulletY.get(i) < 0 || playerBulletY.get(i) > height) { //if there are random lasers that are not on the screen then remove them
        playerBulletX.remove(i);
        playerBulletY.remove(i);
        playerBulletSX.remove(i);
        playerBulletSY.remove(i);
      }
    }

    //drawing turrets
    drawTurret(turret1X, turret1Y);
    drawTurret(turret2X, turret2Y);
    drawTurret(turret3X, turret3Y);
    drawTurret(turret4X, turret4Y);
    drawTurret(turret5X, turret5Y);

    //shoot turret function call
    shootTurret();

    //turret bullet vs wall collision
    for (int i=0; i < turretBulletX.size(); i++) {
      if (turretBulletX.get(i) > wall1X && turretBulletX.get(i) < wall1X + wallWidth && turretBulletY.get(i) >  wall1Y && turretBulletY.get(i) < wall1Y + wallHeight) {
        turretBulletY.set(i, turretYPositions.get(i) + turretHeight);
        bulletState.set(i, false);
      }
      if (turretBulletX.get(i) > wall2X && turretBulletX.get(i) < wall2X + wallWidth && turretBulletY.get(i) >  wall2Y && turretBulletY.get(i) < wall2Y + wallHeight) {
        turretBulletY.set(i, turretYPositions.get(i) + turretHeight);
        bulletState.set(i, false);
      }
      if (turretBulletX.get(i) > wall3X && turretBulletX.get(i) < wall3X + wallWidth && turretBulletY.get(i) >  wall3Y && turretBulletY.get(i) < wall3Y + wallHeight) {
        turretBulletY.set(i, turretYPositions.get(i) + turretHeight);
        bulletState.set(i, false);
      }
      if (turretBulletX.get(i) > wall4X && turretBulletX.get(i) < wall4X + wallWidth && turretBulletY.get(i) >  wall4Y && turretBulletY.get(i) < wall4Y + wallHeight) {
        turretBulletY.set(i, turretYPositions.get(i) + turretHeight);
        bulletState.set(i, false);
      }
    }

    //player bullet vs turret collision
    for (int j=0; j < playerBulletX.size(); j=j+1) { 
      if (playerBulletX.get(j) > turret1X && playerBulletX.get(j) < turret1X + turretWidth && playerBulletY.get(j) > turret1Y && playerBulletY.get(j) < turret1Y + turretHeight && turret1Status == 0) { 
        turret1Lives = turret1Lives - 1; 
        playerBulletX.set(j, -100.0);
      }

      if (turret1Lives == 0.0) {
        turret1Y = -200;
        turret1Status = 1;
      }
    }

    for (int j=0; j < playerBulletX.size(); j=j+1) { 
      if (playerBulletX.get(j) > turret2X && playerBulletX.get(j) < turret2X + turretWidth && playerBulletY.get(j) > turret2Y && playerBulletY.get(j) < turret2Y + turretHeight) { 
        turret2Lives = turret2Lives - 1; 
        playerBulletX.set(j, -100.0);
      }

      if (turret2Lives == 0.0) {
        turret2Y = -200;
        turret2Status = 1;
      }
    }

    for (int j=0; j < playerBulletX.size(); j=j+1) { 
      if (playerBulletX.get(j) > turret3X && playerBulletX.get(j) < turret3X + turretWidth && playerBulletY.get(j) > turret3Y && playerBulletY.get(j) < turret3Y + turretHeight) { 
        turret3Lives = turret3Lives - 1; 
        playerBulletX.set(j, -100.0);
      }

      if (turret3Lives == 0.0) {
        turret3Y = -200;
        turret3Status = 1;
      }
    }

    for (int j=0; j < playerBulletX.size(); j=j+1) { 
      if (playerBulletX.get(j) > turret4X && playerBulletX.get(j) < turret4X + turretWidth && playerBulletY.get(j) > turret4Y && playerBulletY.get(j) < turret4Y + turretHeight) { 
        turret4Lives = turret4Lives - 1; 
        playerBulletX.set(j, -100.0);
      }

      if (turret4Lives == 0.0) {
        turret4Y = -200;
        turret4Status = 1;
      }
    }

    for (int j=0; j < playerBulletX.size(); j=j+1) { 
      if (playerBulletX.get(j) > turret5X && playerBulletX.get(j) < turret5X + turretWidth && playerBulletY.get(j) > turret5Y && playerBulletY.get(j) < turret5Y + turretHeight) { 
        turret5Lives = turret5Lives - 1; 
        playerBulletX.set(j, -100.0);
      }

      if (turret5Lives == 0.0) {
        turret5Y = -200;
        turret5Status = 1;
      }
    }


    //border between turrets and player, player cannot pass through
    fill(#AA1BE3);
    rect(5, 280, width, 4);

    //draw walls
    drawWall(wall1X, wall1Y);
    drawWall(wall2X, wall2Y);
    drawWall(wall3X, wall3Y);
    drawWall(wall4X, wall4Y);

    //coin movement 
    fill(#7111D3);
    for (int i=0; i < arraySize; i = i + 1) {
      coinX[i] = coinX[i] - coinSX[i];
      coinY[i] = coinY[i] - coinSY[i];
      if (coinX[i] < 0) coinX[i] = 640 + floor(random(width));
      if (coinY[i] < 0) coinY[i] = 480 + floor(random(width)); 
      fill(#E5E507);
      image(coin, coinX[i], coinY[i], coinSize, coinSize);

      //player vs coin collision
      if (dist(playerX, playerY, coinX[i], coinY[i]) < coinSize/2 + 5) {
        coins = coins + 3;
        coinX[i] = -100;
      }
    }



    //draw main turret
    fill(#1B07A7);
    image(planet, mainTurretX, mainTurretY, mainTurretSize, mainTurretSize);

    //number of lives display
    fill(#ffffff);
    rect(livesDisplayX, livesDisplayY, 100, 30);
    fill(#3C77DB);
    textSize(25);
    text("Lives: " + playerLives, livesDisplayX + 5, livesDisplayY + 22);

    // coin display
    fill(#ffffff);
    rect(coinsDisplayX, coinsDisplayY, 100, 30);
    fill(#3C77DB);
    textSize(20);
    text("Coins: " + coins, coinsDisplayX + 5, coinsDisplayY + 22);

    //shop button on game screen
    fill(#ffffff);
    rect(shopButton2X, shopButton2Y, shopButtonWidth, shopButtonHeight);
    textSize(20);
    fill(#000000);
    text("SHOP", shopButton2X + 5, shopButton2Y + 25);
  }


  //shop screen
  if (screen == 2) {
    background(shop);

    fill(#ffffff);
    textSize(40);
    text("SHOP", 400, 50);

    //back button
    fill(#ffffff);
    rect(backButtonX, backButtonY, backButtonWidth, backButtonHeight);
    fill(#000000);
    textSize(15);
    text("<-- Back Button", backButtonX + 5, backButtonY + 30);

    buttonMaker("Lives" + "\n" + "3 coins", 20, livesUpgradeX, livesUpgradeY, 9, 25); //lives upgrade
    buttonMaker("Bigger bullets" + "\n" + "3 coins", 20, bulletsUpgradeX, bulletsUpgradeY, 9, 25); //bigger button upgrade
  }

  //game over screen
  if (screen == 3) {
    background(#E5473F);


    fill(#ffffff);
    textSize(60);
    text("Game over", 280, 250);
  }

  //game won screen
  if (screen == 4) {
    background(#4CE53F);

    fill(#ffffff);
    textSize(60);
    text("Game Won", 280, 250);
  }
}



void keyPressed() {

  //player movement using arrow keys
  if (keyCode == UP) {
    speedY = -2;
  } else if (keyCode == DOWN) {
    speedY = 2;
  } else if (keyCode == RIGHT) {
    speedX = 2;
  } else if (keyCode == LEFT) {
    speedX = - 2;
  }
}


void mousePressed() {

  if (playerBulletX.size() < 2) { //To control how many you are allowed to fire at once, game balancing and all that
    float speedx; 
    float speedy; 

    speedx = 10 * (mouseX - playerX) / dist(mouseX, mouseY, playerX, playerY); 
    speedy = 10 * (mouseY - playerY) / dist(mouseX, mouseY, playerX, playerY); 

    playerBulletX.add(playerX);
    playerBulletY.add(playerY);

    playerBulletSX.add(speedx);
    playerBulletSY.add(speedy);
  }

  if (mouseX > playButtonX && mouseX < playButtonX + buttonWidth && mouseY > playButtonY && mouseY < playButtonY + buttonHeight && screen == 0) { //play button 
    screen = 1;
  }

  if (mouseX > shopButtonX && mouseX < shopButtonX + buttonWidth && mouseY > shopButtonY && mouseY < shopButtonY + buttonHeight && screen == 0) { //shop button 
    screen = 2;
  }

  if (mouseX > shopButton2X && mouseX < shopButton2X + shopButtonWidth && mouseY > shopButton2Y && mouseY < shopButton2Y + shopButtonHeight && screen == 1) {//second shop button
    screen = 2;
  }

  if (mouseX > backButtonX && mouseX < backButtonX + backButtonWidth && mouseY > backButtonY && mouseY < backButtonY + backButtonHeight && screen == 2) { //backButton button
    screen = 1;
  }

  if (mouseX > livesUpgradeX && mouseX < livesUpgradeX + buttonWidth && mouseY > livesUpgradeY && mouseY < livesUpgradeY + buttonHeight && screen == 2 && coins == 3) { //lives upgrade button 
    playerLives = playerLives + 3;
    coins  = coins - 3;
    screen = 1;
  }

  if (mouseX > bulletsUpgradeX && mouseX < bulletsUpgradeX + buttonWidth && mouseY > bulletsUpgradeY && mouseY < bulletsUpgradeY + buttonHeight && screen == 2 && coins == 3) { //lives upgrade button 
    bulletsUpgradeFlag = 1;
    coins = coins - 3;
    screen = 1;
  }
}
