class Slider {
  
  // Deklarerer variable der skal bruges
  private float x, y, sliderWidth, sliderHeight, minValue, maxValue;
  private boolean sliderSelected = false;
  private String valuePlacement, title;
  public float currentValue;
  public String theme;

  // Constructoren der initializer alle variable der skal bruges når et Slider objekt bliver lavet
  Slider( float x, float y, float sliderWidth, float sliderHeight, float minValue, float maxValue, float defaultValue, String theme, String valuePlacement, String title) {
    this.x = x;
    this.y = y;
    this.sliderWidth = sliderWidth;
    this.sliderHeight = sliderHeight;
    this.minValue = minValue;
    this.maxValue = maxValue;
    this.currentValue = defaultValue;
    this.theme = theme;
    this.valuePlacement = valuePlacement;
    this.title = title;
  }

  // Tegner slideren og sørger for at værdien at slideren bliver opdateret
  void show() {
    noStroke();
    textSize( sliderWidth / 50f );
    
    // Kalder updateValue() hvis slideren er selected
    if ( sliderSelected ) {
      updateValue();
     }

    // Har lavet to simple themes der ikke rigtigt er brug for men se ret godt ud
    if ( theme == "dark" ) {
      fill( 113, 121, 126 );
      rect( x, y, sliderWidth, sliderHeight, sliderWidth / 20 );
      fill( 200 );
      rect( x, y, sliderPosition() - x, sliderHeight, sliderWidth / 20 );
    } else if ( theme == "light" ) {
      fill( 200 );
      rect( x, y, sliderWidth, sliderHeight, sliderWidth / 20 );
      fill( 255 );
      rect( x, y, sliderPosition() - x, sliderHeight, sliderWidth / 20 );
    }
    
    // Tegner sliderens titel og den nuværende værdi
    if ( valuePlacement == "below" ) {
      textAlign( CENTER, TOP );
      text( currentValue, sliderPosition(), y + sliderHeight );
      textAlign( CENTER, BOTTOM );
      text( title, x + sliderWidth / 2, y );
    } else if ( valuePlacement == "above" ) {
      textAlign( CENTER, BOTTOM );
      text( currentValue, sliderPosition(), y);
      textAlign( CENTER, TOP );
      text( title, x + sliderWidth / 2, y + sliderHeight );
    }
    
    // Tegner de mindste og størst værdien i enderne af slideren
    textAlign( RIGHT, CENTER );
    text( minValue, x, y + sliderHeight / 2 );
    textAlign( LEFT, CENTER );
    text( maxValue, x + sliderWidth, y + sliderHeight / 2 );
  }

  // Vælge slideren hvis musen er på den når knapper blive holdt nede
  void mouseDown() {
    if ( ( mouseY <= y + sliderHeight ) && ( mouseY >= y ) ) {
      if ( ( mouseX >= x ) && ( mouseX <= x + sliderWidth ) ) {
        sliderSelected = true;
      }
    }
  }
  
  void mouseUp() {
    sliderSelected = false;
  }
  
  // Funktion der finder position for den indre slider (den man rykker).
  // Den private fordi den kun skal bruges internt i klassen og ikke skal bruges
  // i den primære fil
  private float sliderPosition() {
    return x + ( (currentValue - minValue ) / ( maxValue - minValue ) * sliderWidth );
  }
  
  // Opdaterer værdien for slideren
  void updateValue() {
    if ( mouseX > x + sliderWidth ) {
      currentValue = maxValue;
    } else if ( mouseX < x ) {
      currentValue = minValue;
    } else {
      currentValue = ( mouseX - x ) / ( ( x + sliderWidth ) - x ) * ( maxValue - minValue ) + minValue;
    } 
  }
}
