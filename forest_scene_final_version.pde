PImage[] leafImages; // Массив для хранения изображений листов
PImage forestBackground; // Изображение фонового изображения

int numLeaves = 400;       // Количество листьев на сцене
Leaf[] leaves = new Leaf[numLeaves];   // Массив для хранения всех листьев
float groundPosition; // Позиция земли или целевой области

void setup() {
  size(1000, 800);   // Измените размер холста по вашему усмотрению

  // Загрузка изображений листов из файлов PNG
  leafImages = new PImage[7]; // Создаем массив с размером 7
  leafImages[0] = loadImage("Leaf_1.PNG");
  leafImages[1] = loadImage("Leaf_2.PNG");
  leafImages[2] = loadImage("Leaf_3.PNG");
  leafImages[3] = loadImage("Leaf_4.PNG");
  leafImages[4] = loadImage("Leaf_5.PNG");
  leafImages[5] = loadImage("Leaf_6.PNG");
  leafImages[6] = loadImage("Leaf_7.PNG");
  
  forestBackground = loadImage("forest_background.PNG"); // Загружаем изображение фонового изображения
  
  groundPosition = height - 20; // Устанавливаем позицию земли или целевой области
  
  // Инициализируем все листья
  for (int i = 0; i < numLeaves; i++) {
    leaves[i] = new Leaf();
  }
}

void draw() {
  // Отображение фонового изображения
  image(forestBackground, 0, 0, width, height);
  
  // Обновляем и отображаем каждый лист
  for (int i = 0; i < numLeaves; i++) {
    leaves[i].update();
    leaves[i].display();
  }
}

void mouseClicked() {
  // При клике мыши создаем сильный порыв ветра
  for (int i = 0; i < numLeaves; i++) {
    // Устанавливаем случайное направление порыва ветра
    leaves[i].wind = PVector.random2D().mult(0.5); // Измените значение 0.5 на свое усмотрение, чтобы увеличить или уменьшить силу порыва

    // Добавьте дополнительные эффекты, такие как изменение скорости листьев или их направления, если требуется
  }
}

// Класс Leaf (Лист)
class Leaf {
  PVector position;    // Позиция листа
  PVector velocity;    // Скорость листа
  PVector acceleration;   // Ускорение листа
  PVector wind;    // Вектор ветра
  float size;    // Размер листа
  float angle;   // Угол поворота листа

  boolean isGrounded; // Флаг, показывающий, достиг ли лист земли
  int imageIndex; // Индекс изображения листа

  Leaf() {
    position = new PVector(random(width), random(-500, -50)); // Инициализируем позицию листа случайным образом в пределах ширины холста
    velocity = new PVector(0, 0); // Изначально устанавливаем скорость равной 0
    acceleration = new PVector(0, 0.03); // Устанавливаем ускорение гравитации (вектор, направленный вниз)
    wind = new PVector(random(-0.1, 0.1), 0); // Случайно задаем горизонтальную силу ветра

    size = random(10, 40);  // Случайно задаем размер листа
    angle = random(TWO_PI); // Случайно задаем угол поворота листа

    isGrounded = false; // Изначально считаем, что лист не достиг земли
    imageIndex = int(random(leafImages.length)); // Выбираем случайное изображение листа из массива
  }

  void update() {
    velocity.add(acceleration); // Применяем ускорение к скорости листа
    position.add(velocity); // Обновляем позицию листа на основе скорости

    // Проверяем, достиг ли лист земли
    if (position.y + size >= groundPosition) {
      // Лист достиг земли
      position.y = groundPosition - size; // Устанавливаем позицию листа на земле
      velocity.y = 0; // Устанавливаем скорость равной 0 для симуляции установки листа на землю
      isGrounded = true; // Устанавливаем флаг, что лист достиг земли
    } else {
      isGrounded = false; // Сбрасываем флаг, если лист не достиг земли
    }

    // Применяем влияние ветра
    velocity.add(wind);

    // Сбрасываем свойства листа и перемещаем его в случайное место, если он покинул видимую область
    if (position.y > height + 50) {
      position.x = random(width);
      position.y = random(-500, -50);
      size = random(10, 40);
      angle = random(TWO_PI);
      velocity = new PVector(0, 0); // Обнуляем скорость листа
      isGrounded = false; // Сбрасываем флаг, если лист покинул видимую область
      imageIndex = int(random(leafImages.length)); // Выбираем случайное изображение листа из массива
    }
  }

  void display() {
    pushMatrix();
    translate(position.x, position.y);
    rotate(angle);

    // Отображение изображения листа в зависимости от значения imageIndex
    image(leafImages[imageIndex], 0, 0, size * 2, size * 4);

    popMatrix();
  }
}
