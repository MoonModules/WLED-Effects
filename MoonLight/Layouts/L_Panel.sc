uint8_t width = 16;
uint8_t height = 16;
uint8_t pin = 16;

void setup() {
  addControl(&width, "width", "range", 1, 32);
  addControl(&height, "height", "range", 1, 32);
  addControl(&pin, "pin", "pin", 1, 48);
}

void onLayout() {
  for (int x = 0; x<width; x++)
    for (int y=0; y<height; y++)
      addLight(x,(x%2)?y:height - 1 - y,0);

  addPin(pin);
}
