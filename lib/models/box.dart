class Box {
  int value = 0;
  int? step;

  Box();
  Box.value(this.value);

  bool movable(Box nextBox, int step) {
    if (value == 0 && nextBox.value == 0) {
      return false;
    }

    if (nextBox.value == 0) {
      return true;
    } else if (nextBox.value == value && nextBox.step != step) {
      return true;
    }

    return false;
  }

  void move(Box nextBox, int step) {
    if (nextBox.value == 0) {
      nextBox.value = value;
      value = 0;
    } else if (nextBox.value == value && nextBox.step != step) {
      nextBox.value += value;
      nextBox.step = step;
      value = 0;
    }
  }
}
