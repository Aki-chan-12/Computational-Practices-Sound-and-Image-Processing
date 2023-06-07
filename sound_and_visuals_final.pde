import ddf.minim.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioOutput audioOut;
Oscil oscillator;

ArrayList<Particle> particles;
ArrayList<Sparkle> sparkles;
int numParticles = 200;
int numSparkles = 50;

boolean isSoundOn = true;
float volume = 0.5f;
float volumeIncrement = 0.1f;

Button increaseButton;
Button decreaseButton;

void setup() {
  size(800, 400);

  minim = new Minim(this);
  audioOut = minim.getLineOut();

  oscillator = new Oscil(440, volume, Waves.SINE);
  oscillator.patch(audioOut);

  particles = new ArrayList<Particle>();
  sparkles = new ArrayList<Sparkle>();

  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle(width/2, height/2));
  }

  for (int i = 0; i < numSparkles; i++) {
    sparkles.add(new Sparkle(width/2, height/2));
  }
  
  increaseButton = new Button(20, 20, 60, 60, "▲");
  decreaseButton = new Button(20, 100, 60, 60, "▼");
  
  increaseButton.setColour(color(255, 165, 0));
  decreaseButton.setColour(color(255, 165, 0));
  
  increaseButton.startSize = int(increaseButton.width);
  increaseButton.endSize = int(increaseButton.width);
  increaseButton.startAlpha = 255;
  increaseButton.endAlpha = 255;
  
  decreaseButton.startSize = int(decreaseButton.width);
  decreaseButton.endSize = int(decreaseButton.width);
  decreaseButton.startAlpha = 255;
  decreaseButton.endAlpha = 255;
}

void draw() {
  background(0);

  for (Particle p : particles) {
    p.update(isSoundOn);
    p.display();
  }
  
  for (Sparkle s : sparkles) {
    s.update(isSoundOn);
    s.display();
  }
  
  increaseButton.display();
  decreaseButton.display();
}

void mouseClicked() {
  if (increaseButton.isMouseInside()) {
    volume += volumeIncrement;
    volume = constrain(volume, 0.0f, 1.0f);
    oscillator.setAmplitude(volume);
    
    increaseButton.animateColour(color(255, 0, 0));
    increaseButton.animateSize(increaseButton.width * 1.2, increaseButton.height);
    increaseButton.animateAlpha(255);
  } else if (decreaseButton.isMouseInside()) {
    volume -= volumeIncrement;
    volume = constrain(volume, 0.0f, 1.0f);
    oscillator.setAmplitude(volume);
    
    decreaseButton.animateColour(color(255, 0, 0));
    decreaseButton.animateSize(decreaseButton.width * 1.2, decreaseButton.height);
    decreaseButton.animateAlpha(255);
  }
}

class Particle {
  float x, y;
  float size;
  float speedX, speedY;
  float colorR, colorG, colorB;

  Particle(float x, float y) {
    this.x = x;
    this.y = y;
    size = random(5, 15);
    speedX = random(-2, 2);
    speedY = random(-2, 2);
    colorR = random(200, 255);
    colorG = random(100, 150);
    colorB = random(0, 50);
  }

  void update(boolean isSoundOn) {
    if (isSoundOn) {
      x += speedX * volume;
      y += speedY * volume;
    } else {
      x += speedX;
      y += speedY;
    }

    if (x < 0 || x > width) {
      speedX *= -1;
    }
    if (y < 0 || y > height) {
      speedY *= -1;
    }
  }

  void display() {
    noStroke();
    fill(colorR, colorG, colorB);
    ellipse(x, y, size, size);
  }
}

class Sparkle {
  float x, y;
  float size;
  float speed;
  float colorR, colorG, colorB;
  float angle;

  Sparkle(float x, float y) {
    this.x = x;
    this.y = y;
    size = random(1, 5);
    speed = random(1, 5);
    colorR = random(200, 255);
    colorG = random(200, 255);
    colorB = random(200, 255);
    angle = random(TWO_PI);
  }

  void update(boolean isSoundOn) {
    if (isSoundOn) {
      float vx = cos(angle) * speed * volume;
      float vy = sin(angle) * speed * volume;
      x += vx;
      y += vy;
    } else {
      float vx = cos(angle) * speed;
      float vy = sin(angle) * speed;
      x += vx;
      y += vy;
    }
    
    speed *= 0.99;

    if (speed < 0.1) {
      speed = 0;
    }
  }

  void display() {
    noStroke();
    fill(colorR, colorG, colorB);
    ellipse(x, y, size, size);
  }
}

class Button {
  float x, y;
  float width, height;
  String label;
  int colour;
  float startSize, endSize;
  float startAlpha, endAlpha;

  Button(float x, float y, float width, float height, String label) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.label = label;
    this.colour = color(255, 165, 0);
    this.startSize = width;
    this.endSize = width;
    this.startAlpha = 255;
    this.endAlpha = 255;
  }

  void setColour(int colour) {
    this.colour = colour;
  }

  void animateColour(int targetColour) {
    this.colour = targetColour;
  }

  void animateSize(float targetWidth, float targetHeight) {
    this.startSize = width;
    this.endSize = targetWidth;
  }

  void animateAlpha(int targetAlpha) {
    this.startAlpha = 255;
    this.endAlpha = targetAlpha;
  }

  void display() {
    float size = lerp(startSize, endSize, 0.1);
    float alpha = lerp(startAlpha, endAlpha, 0.1);

    push();
    translate(x + width / 2, y + height / 2);
    scale(size / width, size / height);
    translate(-width / 2, -height / 2);

    fill(colour, alpha);
    rect(0, 0, width, height);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(size / 2);
    text(label, 0, 0, width, height);

    pop();
  }

  boolean isMouseInside() {
    return mouseX >= x && mouseX <= x + width && mouseY >= y && mouseY <= y + height;
  }
}
