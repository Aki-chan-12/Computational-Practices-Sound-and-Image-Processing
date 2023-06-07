PImage img;
int pointSize = 40;

int x, y;
float alf;

ArrayList<Ball> Balls;

void setup() {
  size(558, 673);
  background(242, 235, 190);
  img = loadImage("gerchard_richter.jpg");

  noStroke();
  fill(0);

  Balls = new ArrayList<Ball>();
  Balls.add(new Ball(100, 100, 40, 5, 2));
  Balls.add(new Ball(10, 100, 60, -3, 5));
  Balls.add(new Ball(40, 340, 12, 8, 3));
  Balls.add(new Ball(150, 400, 35, 5, 1));
}

void draw() {
  pushMatrix(); // Добавленная строка: сохранение состояния матрицы

  for (int i = 0; i < 1500; i++) {  
    x = int(random(img.width));
    y = int(random(img.height));

    int loc = x + y * img.width;

    loadPixels();
    float r = red(img.pixels[loc]);
    float g = green(img.pixels[loc]);
    float b = blue(img.pixels[loc]);
    fill(r, g, b, 100);
    noStroke();
    ellipse(x, y, pointSize, pointSize);
  }

  popMatrix(); // Добавленная строка: восстановление состояния матрицы

  color c1 = color(219, 168, 52);
  fill(c1);
  noStroke();
  triangle(240, 220, 500, 150, 560, 380);

  color c2 = color(175, 55, 41);
  fill(c2);
  noStroke();
  square(150, 250, 240);

  color c3 = color(89, 114, 147);
  fill(c3);
  noStroke();
  circle(390, 280, 150);

  color c4 = color(51, 44, 19);
  fill(c4);
  stroke(51, 44, 19);
  line(279, 1, 310, 672);
  line(279, 1, 260, 672);

  alf -= 50;
  float r = 100;
  x = 200 + round(r * cos(PI * alf / 180));
  y = 200 + round(r * sin(PI * alf / 180));
  fill(214, 198, 190);
  noStroke();
  ellipse(x, y, 30, 30);

  alf -= 50;
  x = 150 + round(r * cos(PI * alf / 180));
  y = 150 + round(r * sin(PI * alf / 180));
  fill(168, 177, 208);
  noStroke();
  ellipse(x, y, 50, 50);

  alf -= 50;
  x = 500 + round(r * cos(PI * alf / 180));
  y = 500 + round(r * sin(PI * alf / 180));
  fill(113, 92, 104);
  noStroke();
  ellipse(x, y, 50, 50);

  for (int i = Balls.size() - 1; i >= 0; i--) {
    Ball myBall = Balls.get(i);
    myBall.run();
  }
}
