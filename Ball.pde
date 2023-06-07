import java.util.Random;

class Ball {
  float x;
  float y;
  float speedX;
  float speedY;
  float size;

  Random generator;
  float sd;
  float mean;
  float Rate = 10;
  int status = 0;

  float num;
  float r;
  float g;
  float b;

  Ball(float X, float Y, float SIZE, float SPEEDX, float SPEEDY) {
    x = X;
    y = Y;
    size = SIZE;
    speedX = SPEEDX;
    speedY = SPEEDY;
    generator = new Random();
    sd = 60;
    mean = 127.5;
  }

  void run() {
    setColour();
    display();
    move();
    bounce();
    gravity();
  }

  void setColour() {
    status++;
    if (status > Rate) {
      num = (float) generator.nextGaussian();
      r = sd * num + mean;
      num = (float) generator.nextGaussian();
      g = sd * num + mean;
      num = (float) generator.nextGaussian();
      b = sd * num + mean;

      fill(r, g, b);
      status = 0;
    }
  }

  void gravity() {
    speedY += 0.2;
  }

  void bounce() {
    if (x > width || x < 0) {
      speedX = speedX * -1;
    }
    if (y > height || y < 0) {
      speedY = speedY * -1;
    }
  }

  void move() {
    x += speedX;
    y += speedY;
  }

  void display() {
    ellipse(x, y, size, size);
  }
}
