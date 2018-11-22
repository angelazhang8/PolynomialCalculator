/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void win_draw4(PApplet appc, GWinData data) { //_CODE_:window1:484111:
  appc.background(255);
} //_CODE_:window1:484111:

public void polynomial1Change(GTextField source, GEvent event) { //_CODE_:polynomial1:269090:
  p6 = new Polynomial(polynomial1.getText());
} //_CODE_:polynomial1:269090:

public void polynomial2Change(GTextField source, GEvent event) { //_CODE_:polynomial2:709368:
  p7 = new Polynomial(polynomial2.getText());
} //_CODE_:polynomial2:709368:

public void graphPolynomialButtonChange(GButton source, GEvent event) { //_CODE_:graphPolynomialButton:432256:
  p8 = new Polynomial(polynomial3.getText());
  //window2.draw();
  polynomialToBeDrawn = p8;
  redraw();
} //_CODE_:graphPolynomialButton:432256:

public void findRootsButtonClicked(GButton source, GEvent event) { //_CODE_:findRootsButton:463413:
  p8 = new Polynomial (polynomial3.getText());
  String labelChange = printRootsToScreen();
  findRoots.setText(labelChange);
} //_CODE_:findRootsButton:463413:

public void operationChange(GDropList source, GEvent event) { //_CODE_:operation:261089:
  opt = (operation.getSelectedIndex());
} //_CODE_:operation:261089:

public void derivativeSliderChange(GSlider source, GEvent event) { //_CODE_:derivativeSlider:346920:
  float derivativeSliderNumber = derivativeSlider.getValueF();
  String label;
  Polynomial p8 = new Polynomial(polynomial3.getText());
  int numDerivative = int((p8.polyTerms.get(0).exponent) * derivativeSliderNumber);
  ArrayList<Term> derivativeTerms = new ArrayList<Term>(); //create your new derivative polynomial by first creating a arraylist of terms

  for (Term i : p8.polyTerms) { //make a copy of the current polynomial because we ware going to modify it when we
    derivativeTerms.add(new Term(i.coeff, i. exponent));
  }
  Polynomial derivative = new Polynomial(derivativeTerms);
  
  derivative = derivative.findDerivative();
  for (int i = 0; i < numDerivative; i++) {
    derivative = derivative.findDerivative();
  }
  if (derivativeSliderNumber ==   derivativeSlider.getEndLimit())
    label = "The " + (numDerivative+1) + " derivative is 0";
  else
    label = "The " + (numDerivative+1) + " derivative is " + derivative.printPolynomialtoGUIScreen();
  derivativeLabel.setText(label);
  
  
} //_CODE_:derivativeSlider:346920:

public void computeButtonClicked(GButton source, GEvent event) { //_CODE_:computeButton:411332:
  String yourAnswer;
  if (opt == 0)
    yourAnswer = p6.getSum(p7).printPolynomialtoGUIScreen();
  else if (opt == 1)
    yourAnswer = p6.getDifference(p7).printPolynomialtoGUIScreen();
  else if (opt == 2) {
    yourAnswer = p6.multiply(p7).printPolynomialtoGUIScreen();
  } else {

    p6.printPolynomial();
    p7.printPolynomial();
    ArrayList<Polynomial> quotientAndRemainder = p6.divide(p7);

    yourAnswer = "quotient: " + (quotientAndRemainder.get(0)).printPolynomialtoGUIScreen()+ "\n";
    yourAnswer += "remainder: " + (quotientAndRemainder.get(1)).printPolynomialtoGUIScreen();
  }
  polynomialDisplay.setText(yourAnswer);
} //_CODE_:computeButton:411332:

public void polynomial3Change(GTextField source, GEvent event) { //_CODE_:polynomial3:487841:
  
} //_CODE_:polynomial3:487841:

public void imgButton1_click1(GImageButton source, GEvent event) { //_CODE_:imgButton1:901869:
  println("imgButton1 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton1:901869:

public void imgButton2_click1(GImageButton source, GEvent event) { //_CODE_:imgButton2:692273:
  println("imgButton2 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton2:692273:

public void imgButton3_click1(GImageButton source, GEvent event) { //_CODE_:imgButton3:779450:
  println("imgButton3 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton3:779450:

public void imgButton4_click1(GImageButton source, GEvent event) { //_CODE_:imgButton4:316009:
  println("imgButton4 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton4:316009:

public void imgButton5_click1(GImageButton source, GEvent event) { //_CODE_:imgButton5:606457:
  println("imgButton5 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton5:606457:

public void imgButton6_click1(GImageButton source, GEvent event) { //_CODE_:imgButton6:318241:
  println("imgButton6 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton6:318241:

public void imgButton7_click1(GImageButton source, GEvent event) { //_CODE_:imgButton7:283357:
  println("imgButton7 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton7:283357:

public void imgButton8_click1(GImageButton source, GEvent event) { //_CODE_:imgButton8:441834:
  println("imgButton8 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton8:441834:

public void imgButton9_click1(GImageButton source, GEvent event) { //_CODE_:imgButton9:757887:
  println("imgButton9 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton9:757887:

public void imgButton10_click1(GImageButton source, GEvent event) { //_CODE_:imgButton10:241201:
  println("imgButton10 - GImageButton >> GEvent." + event + " @ " + millis());
} //_CODE_:imgButton10:241201:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setCursor(ARROW);
  surface.setTitle("Sketch Window");
  window1 = GWindow.getWindow(this, "coolest calculator ever", 0, 0, 750, 500, JAVA2D);
  window1.noLoop();
  window1.addDrawHandler(this, "win_draw4");
  polynomial1 = new GTextField(window1, 57, 157, 120, 30, G4P.SCROLLBARS_NONE);
  polynomial1.setText("0");
  polynomial1.setOpaque(true);
  polynomial1.addEventHandler(this, "polynomial1Change");
  polynomial2 = new GTextField(window1, 350, 152, 122, 30, G4P.SCROLLBARS_NONE);
  polynomial2.setText("0");
  polynomial2.setOpaque(true);
  polynomial2.addEventHandler(this, "polynomial2Change");
  graphPolynomialButton = new GButton(window1, 592, 278, 94, 41);
  graphPolynomialButton.setText("Graph polynomial");
  graphPolynomialButton.addEventHandler(this, "graphPolynomialButtonChange");
  findRootsButton = new GButton(window1, 450, 280, 80, 30);
  findRootsButton.setText("FInd roots");
  findRootsButton.addEventHandler(this, "findRootsButtonClicked");
  operation = new GDropList(window1, 219, 170, 93, 100, 4);
  operation.setItems(loadStrings("list_261089"), 0);
  operation.addEventHandler(this, "operationChange");
  polynomialDisplay = new GLabel(window1, 551, 132, 169, 67);
  polynomialDisplay.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  polynomialDisplay.setText("your answer");
  polynomialDisplay.setTextItalic();
  polynomialDisplay.setOpaque(false);
  derivativeSlider = new GSlider(window1, 238, 312, 158, 40, 10.0);
  derivativeSlider.setLimits(0.0, 0.0, 1.0);
  derivativeSlider.setNumberFormat(G4P.DECIMAL, 2);
  derivativeSlider.setOpaque(false);
  derivativeSlider.addEventHandler(this, "derivativeSliderChange");
  label2 = new GLabel(window1, 238, 265, 152, 53);
  label2.setText("Toggle the slidebar to fnd derivatives");
  label2.setOpaque(false);
  polynomial1Label = new GLabel(window1, 43, 114, 157, 35);
  polynomial1Label.setText("Enter your first polynomial");
  polynomial1Label.setOpaque(false);
  polynomial2Label = new GLabel(window1, 334, 106, 173, 39);
  polynomial2Label.setText("Enter your second polynomial");
  polynomial2Label.setOpaque(false);
  computeButton = new GButton(window1, 223, 117, 80, 30);
  computeButton.setText("Compute");
  computeButton.addEventHandler(this, "computeButtonClicked");
  polynomial3 = new GTextField(window1, 30, 342, 176, 30, G4P.SCROLLBARS_NONE);
  polynomial3.setText("0");
  polynomial3.setOpaque(true);
  polynomial3.addEventHandler(this, "polynomial3Change");
  label1 = new GLabel(window1, 28, 261, 178, 73);
  label1.setText("In the textbox below, enter a polynomial to find its roots/derivatives and graph");
  label1.setOpaque(false);
  imgButton1 = new GImageButton(window1, 322, 9, 396, 89, new String[] { "funcWiz.jpg", "funcWiz.jpg", "funcWiz.jpg" } );
  imgButton1.addEventHandler(this, "imgButton1_click1");
  findRoots = new GLabel(window1, 425, 329, 127, 61);
  findRoots.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  findRoots.setText("roots");
  findRoots.setTextItalic();
  findRoots.setOpaque(false);
  imgButton2 = new GImageButton(window1, 493, 153, 47, 26, new String[] { "equals_PNG35.png", "equals_PNG35.png", "equals_PNG35.png" } );
  imgButton2.addEventHandler(this, "imgButton2_click1");
  imgButton3 = new GImageButton(window1, 28, 191, 670, 68, new String[] { "images.png", "images.png", "images.png" } );
  imgButton3.addEventHandler(this, "imgButton3_click1");
  derivativeLabel = new GLabel(window1, 275, 361, 126, 53);
  derivativeLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  derivativeLabel.setText("derivative");
  derivativeLabel.setTextItalic();
  derivativeLabel.setOpaque(false);
  imgButton4 = new GImageButton(window1, 221, 367, 54, 113, new String[] { "GxQCc.png", "GxQCc.png", "GxQCc.png" } );
  imgButton4.addEventHandler(this, "imgButton4_click1");
  imgButton5 = new GImageButton(window1, 580, 337, 121, 127, new String[] { "89210.png", "89210.png", "89210.png" } );
  imgButton5.addEventHandler(this, "imgButton5_click1");
  imgButton6 = new GImageButton(window1, 421, 398, 149, 81, new String[] { "5a902357b15d5c051b36907f.png", "5a902357b15d5c051b36907f.png", "5a902357b15d5c051b36907f.png" } );
  imgButton6.addEventHandler(this, "imgButton6_click1");
  imgButton7 = new GImageButton(window1, 219, 18, 83, 79, new String[] { "add_subtract_multiply_and_divide_476625.png", "add_subtract_multiply_and_divide_476625.png", "add_subtract_multiply_and_divide_476625.png" } );
  imgButton7.addEventHandler(this, "imgButton7_click1");
  imgButton8 = new GImageButton(window1, 57, 379, 111, 110, new String[] { "Blogging-Wizard-Laptop-Graphic.png", "Blogging-Wizard-Laptop-Graphic.png", "Blogging-Wizard-Laptop-Graphic.png" } );
  imgButton8.addEventHandler(this, "imgButton8_click1");
  imgButton9 = new GImageButton(window1, 100, 27, 91, 83, new String[] { "wizard-1454385_640.png", "wizard-1454385_640.png", "wizard-1454385_640.png" } );
  imgButton9.addEventHandler(this, "imgButton9_click1");
  imgButton10 = new GImageButton(window1, 23, 13, 81, 95, new String[] { "wizard-trans.png", "wizard-trans.png", "wizard-trans.png" } );
  imgButton10.addEventHandler(this, "imgButton10_click1");
  window1.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow window1;
GTextField polynomial1; 
GTextField polynomial2; 
GButton graphPolynomialButton; 
GButton findRootsButton; 
GDropList operation; 
GLabel polynomialDisplay; 
GSlider derivativeSlider; 
GLabel label2; 
GLabel polynomial1Label; 
GLabel polynomial2Label; 
GButton computeButton; 
GTextField polynomial3; 
GLabel label1; 
GImageButton imgButton1; 
GLabel findRoots; 
GImageButton imgButton2; 
GImageButton imgButton3; 
GLabel derivativeLabel; 
GImageButton imgButton4; 
GImageButton imgButton5; 
GImageButton imgButton6; 
GImageButton imgButton7; 
GImageButton imgButton8; 
GImageButton imgButton9; 
GImageButton imgButton10; 
