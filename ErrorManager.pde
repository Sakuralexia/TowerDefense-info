class ErrorManager {
  String errorMessage = "";
  int errorMessageTimer = 0;

  void setErrorMessage(String message, int duration) {
    errorMessage = message;
    errorMessageTimer = duration;
  }

  void update() {
    if (errorMessageTimer > 0) {
      errorMessageTimer--;
    }
  }

  void showErrorMessage() {
    if (errorMessageTimer > 0) {
      fill(255, 0, 0);
      textSize(16);
      textAlign(CENTER, TOP);
      text(errorMessage, width / 2, 10);
    }
  }
}
