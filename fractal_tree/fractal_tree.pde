// Deklarerer variabler der skal bruges igennem koden
float angle, trunkHeight;
float originOffsetX = 0;
float originOffsetY = 0;
float movementSpeed = 100;
float angleBias;
Slider[] sliders;
Button[] buttons;

// Bliver kørt lige når programmet starter
// Stroke gør så linjer der bliver tegnet af 1px
// store og sorte
void setup() {
  background(0);
  
  fullScreen();
  stroke(255);

  // Laver et array med alle sliders for at gøre koden for overskuelig længere nede
  sliders = new Slider[] {
     new Slider( width * 0.15f, height / 20f, width * 0.35f, height / 30f, 0, PI, PI / 4, "dark", "below", "Vinkel (Radianer)" ),
     new Slider( width * 0.585f, height / 20f, width * 0.35f, height / 30f, height / 30f, height * 3, height / 4, "dark", "below", "Stamme-højde (Pixels)" ),
     new Slider( width * 0.15f, height * 0.15f, width * 0.35f, height / 30f, -PI, PI, 0, "dark", "below", "Vinkel-bias (Radianer mod højre)")
  };
  
  // Laver et array men mine knapper
  buttons = new Button[] {
    new Button( width * 0.85f, height * 0.7f, width / 30, width / 30, false, null ), 
    new Button( width * 0.85f + width / 30, height * 0.7f + width / 30, width / 30, width / 30, false, null ), 
    new Button( width * 0.85f, height * 0.7f + ( width / 30 * 2), width / 30, width / 30, false, null ), 
    new Button( width * 0.85f - width / 30, height * 0.7f + width / 30, width / 30, width / 30, false, null ),
    new Button( width * 0.78f - width / 30, height * 0.15f, width / 30, width / 30, true, "Reset" ),
    new Button( 0, 0, width / 30, width / 30, true, "Luk" )
  };
    
  // Gemmer værdien for hver slider i deres variable
  angle = sliders[0].currentValue;
  trunkHeight = sliders[1].currentValue;
  angleBias = sliders[2].currentValue;
}

// Bliver kørt med en target framerate på 60
void draw() {
  
  // Laver baggrunden for at forhindre i et tingene fra sidste frame klumper sig sammen
  background(0);

  // Looper igennem sliders og knapper og tegner dem
  for( int i = 0; i < sliders.length; i++ ) {
    sliders[i].show();
  }
  
  for ( int i = 0; i < buttons.length; i++ ) {
    buttons[i].show();
  }
  
  // Funktion der står længere nede i koden
  checkButtons();
  
  // Rykker origo ned i midten af skærmen + et offset som kommer fra pilene man bruger
  // til at rykke kamera rundt
  translate( width / 2f + originOffsetX, height + originOffsetY );
  
  // Gemmer værdierne for slidersne i deres variable (skal gøres hver frame)
  angle = sliders[0].currentValue;
  trunkHeight = sliders[1].currentValue;
  angleBias = sliders[2].currentValue;
  
  // Kalder den rekursive funktion der laver træet
  branch( trunkHeight, 1 );
}

void branch( float len, int iteration ) {
  
  // Laver en lodret gren fra origin til -len (y-aksen peger nedad)
  // og rykker origo hen til enden af grenen
  stroke(255);
  line( 0, 0, 0, -len );
  translate( 0, -len );
  
  // Laver kun nye grene hvis længden af grenen er større end 1
  // push() gemmer den nuværende origo og pop() gør så man ryger tilbage
  // til det origo. Funktion roterer canvas til højrer, kalder sigselv branch()
  // bruger pop() til at vende tilbage, drejere til venstre og kalder branch() igen
  // Iteration parameteren bliver ikke brugt til noget men kan være dejlig at have i fremtiden
  if ( len > 1 ) {
    push();
    rotate( angle + angleBias );
    branch( len * 0.67f, iteration + 1 );
    pop();
    
    push();
    rotate( -angle + angleBias );
    branch( len * 0.67f, iteration + 1 );
    pop();
  }
}

// Kalder mouseDown() funktion for alle sliders og knapper
void mousePressed() {
  for( int i = 0; i < sliders.length; i++ ) {
    sliders[i].mouseDown();
  }
  for ( int i = 0; i < buttons.length; i++ ) {
    buttons[i].mouseDown();
  }
}

// Kalder mouseUp() funtion for alle sliders og knapper
void mouseReleased() {
  for( int i = 0; i < sliders.length; i++ ) {
    sliders[i].mouseUp();
  }
  
  for ( int i = 0; i < buttons.length; i++ ) {
    buttons[i].mouseUp();
  }
}

// Tjekker hvilke knapper der blive koldt nede og ændrer
// originOffsetX/originOffsetY hvilket bliver brugt at skubbe
// origo før træet bliver tegnet
// De to sidste knapper bliver brugt til at resette alle værdier
// og til at lukke programmet henholdsvis
void checkButtons() {
  if ( buttons[0].mouseHolding ) {
    originOffsetY += movementSpeed;
  } if ( buttons[1].mouseHolding ) {
    originOffsetX -= movementSpeed;
  } if( buttons[2].mouseHolding ) {
    if ( originOffsetY > 0 ) {
      originOffsetY -= movementSpeed;
    } else {
      originOffsetY = 0;
    }
  } if ( buttons[3].mouseHolding ) {
    originOffsetX += movementSpeed;
  } if ( buttons[4].mouseHolding ) {
    sliders[0].currentValue = PI / 4;
    sliders[1].currentValue = height / 4;
    sliders[2].currentValue = 0;
    originOffsetX = 0;
    originOffsetY = 0;
  } if ( buttons[5].mouseHolding ) {
    exit();
  }
}

// Gemmer et billede skærmen som et screenshot. Bare
// en lille ekstra detajle
void keyPressed() {
  if ( key == 'f' ) {
    saveFrame( "screenshot-###########.png" );
  }
}
