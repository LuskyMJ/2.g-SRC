class Button { //<>//
  // Deklarerer variable der skal bruges
  private float x, y, buttonWidth, buttonHeight;
  private boolean isText;
  private String text;
  public boolean mouseHolding;
  
  // Constructoren der initializer alle variable der skal bruges når et Button objekt bliver lavet
  Button( float x, float y, float buttonHeight, float buttonWidth, boolean isText, String text ) {
    this.x = x;
    this.y = y;
    this.buttonWidth = buttonWidth;
    this.buttonHeight = buttonHeight;
    this.mouseHolding = false;
    this.text = text;
    this.isText = isText;
  }
  
  // Tegner knappen
  void show() {
    
    // Ændrer farve alt efter om knapper blive trykket på eller ej
    if ( !mouseHolding ) {
      fill( 255 );
    } else {
      fill( 100 );
    }
    
    // Tegner knappen
    rect( x, y, buttonWidth, buttonHeight, buttonWidth / 10 );
    
    // Tegner text på knappen hvis den er sat til at gøre det
    if ( isText ) {
      textAlign( CENTER, CENTER );
      fill( 0 );
      text( text, x + buttonWidth / 2, y + buttonHeight / 2 );
    }
  }
  
  // Sætte mouseHolding til "true" hvis knappen bliver trykket på
  void mouseDown() {
    if ( ( mouseY <= y + buttonHeight ) && ( mouseY >= y ) ) {
      if ( ( mouseX >= x ) && ( mouseX <= x + buttonWidth ) ) {
        mouseHolding = true;
      }   
    }
  }
  
  void mouseUp() {
    mouseHolding = false;
  }
}
