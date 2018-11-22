import java.util.Arrays;  
import g4p_controls.*;

String u1 = "0"; //default to prevent the GUI from throwing errors
//test cases
String u2 = "x^3+5x^2+x";
String u3 = "9x^2+9x+2";
String u4 = "x^3-3x^2+2x";
String u5 = "-x^3-2x^2+2x+4";
String u6 = "6";
String u7 = "2";

int xMin = -20;  //declare minimum and maximum x values and find xIncrement from GUI
int xMax = 20;

int opt; //operation for the slider (add/subtract/multiply/divide)

Polynomial p6, p7, p8; //polynomial strings from the text fields in the GUI's

Polynomial polynomialToBeDrawn = new Polynomial(u1); //set the polynomial to be graphed and assign to this variable

void testingStuff() { //testing the test cases (not relevant for running the program)
  Polynomial p1 = new Polynomial(u1); //creating polynomials from strings
  Polynomial p2 = new Polynomial(u2);
  Polynomial p3 = new Polynomial(u3);
  Polynomial p4 = new Polynomial(u4);
  Polynomial p5 = new Polynomial(u5);

  //calling the methods for the polynomial class
  Polynomial sum = p1.getSum(p2);
  Polynomial difference = p1.getDifference(p2);
  Polynomial product = p1.multiply(p2);
  p1.graphPolynomial();

  ArrayList<Polynomial> quotientAndRemainder = p1.divide(p2); //make an arraylist to store the result of division
  print("first polynomial: ");
  p1.printPolynomial();
  print(", second polynomial: ");
  p2.printPolynomial();

  print("\nsum: ");
  sum.printPolynomial();

  print("\ndifference: ");
  difference.printPolynomial();

  print("\nmultiply: ");
  product.printPolynomial();

  print("\nquotient: ");
  quotientAndRemainder.get(0).printPolynomial();

  print(", remainder: ");
  quotientAndRemainder.get(1).printPolynomial();
  println("\n");

  //printing the results from the operations
  ArrayList<Polynomial> polynomials = new ArrayList<Polynomial>();
  polynomials.add(p3);
  polynomials.add(p4);
  polynomials.add(p5);
  for (Polynomial p : polynomials) {
    print("Polynomial: ");
    p.printPolynomial();
    print("\nRational roots: ");
    ArrayList<Rational> roots = p.findRationalRoots();
    if (roots.size() == 0)
      print("This polynomial has no rational roots");
    else { //gets the roots which are in rational form (a/b)
      int i = 0;
      if (roots.get(i).d == 1) //if the denom is 1
        print(roots.get(i).n);
      else
        print(roots.get(i).n+"/"+roots.get(i).d); //adds "/" if the denom is not 1
      i++;   
      for (; i <roots.size(); i++) {
        if (roots.get(i).d == 1)
          print(", "+roots.get(i).n);
        else
          print(", "+roots.get(i).n+"/"+roots.get(i).d);
      }
    }
    print("\nApprox. Roots: ");
    ArrayList<Float> approxRoots = p.findApproxRoots(xMin, xMax, 100); //approx root method is called
    for (Float i : approxRoots) {
      print(i + " ");
    }
    println("\n");
  }
}

String printRootsToScreen () { //returns the String text for the label

  String stringToBePrinted = ""; //initially sets the string to blank 
  stringToBePrinted += ("\nRational roots: "); //adds stuff that needs to be printed
  ArrayList<Rational> roots = p8.findRationalRoots();

  if (roots.size() == 0) //checks size of array
    stringToBePrinted+=("This polynomial has no rational roots");
  else {//same idea as above (testingStuff)
    int i = 0;
    if (roots.get(i).d == 1)
      stringToBePrinted += (roots.get(i).n);
    else
      stringToBePrinted += (roots.get(i).n+"/"+roots.get(i).d);
    i++;   
    for (; i <roots.size(); i++) {
      if (roots.get(i).d == 1)
        stringToBePrinted += (", "+roots.get(i).n);
      else
        stringToBePrinted += (", "+roots.get(i).n+"/"+roots.get(i).d);
    }
  }
  stringToBePrinted+=("\nApprox. Roots: ");
  ArrayList<Float> approxRoots = p8.findApproxRoots(xMin, xMax, 100);
  for (Float i : approxRoots) {
    stringToBePrinted+=(i + " ");
  }
  stringToBePrinted+=("\n");
  return stringToBePrinted; //returns a String, this function is called in the GUI
}


void setup() { //creates the sketch window for the graph initially
  size(600, 600);
  background(255);
  createGUI();
  noLoop(); //we don't want draw to be continously called because it will overwrite the graph
}


float roundAny(float x, int d) {  //suppose x = 6.86927 and d = 2
  float y = x * pow(10, d);       //y = 686.927
  float z = round(y);            //z = 687
  return z / pow(10, d);          //6.87
}

void draw() {
  background(255);
  //the method that graphs the polynomial on the sketch window
  //the graph appears once redraw is called in the GUI
  //at first the polynomial is set to y=
  polynomialToBeDrawn.graphPolynomial();
}
