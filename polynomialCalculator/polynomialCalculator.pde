import java.util.Arrays; 
import g4p_controls.*;

String u1 = "7x^3+x";
String u2 = "x^3+5x^2+x";
String u3 = "9x^2+9x+2";
String u4 = "x^3-3x^2+2x";
String u5 = "-x^3-2x^2+2x+4";
String u6 = "6";
String u7 = "2";

int opt;

Polynomial p6, p7, p8;

Polynomial polynomialToBeDrawn = new Polynomial(u1);

void testingStuff() { 
  Polynomial p1 = new Polynomial(u1);
  Polynomial p2 = new Polynomial(u2);
  Polynomial p3 = new Polynomial(u3);
  Polynomial p4 = new Polynomial(u4);
  Polynomial p5 = new Polynomial(u5);
  Polynomial p8 = new Polynomial (u6);
  Polynomial p9 = new Polynomial (u7);


  Polynomial sum = p1.getSum(p2);
  Polynomial difference = p1.getDifference(p2);
  Polynomial product = p1.multiply(p2);
  p1.graphPolynomial();
  ArrayList<Polynomial> quotientAndRemainder = p1.divide(p2);
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
    else {
      int i = 0;
      if (roots.get(i).d == 1)
        print(roots.get(i).n);
      else
        print(roots.get(i).n+"/"+roots.get(i).d);
      i++;   
      for (; i <roots.size(); i++) {
        if (roots.get(i).d == 1)
          print(", "+roots.get(i).n);
        else
          print(", "+roots.get(i).n+"/"+roots.get(i).d);
      }
    }
    print("\nApprox. Roots: ");
    ArrayList<Float> approxRoots = p.findApproxRoots(-3, 3, 100);
    for (Float i : approxRoots) {
      print(i + " ");
    }
    println("\n");
  }
}

String printRootsToScreen (){
  String stringToBePrinted = "";
    stringToBePrinted+=("\nRational roots: ");
    ArrayList<Rational> roots = p8.findRationalRoots();
    if (roots.size() == 0)
      stringToBePrinted+=("This polynomial has no rational roots");
    else {
      int i = 0;
      if (roots.get(i).d == 1)
        stringToBePrinted+=(roots.get(i).n);
      else
        stringToBePrinted+=(roots.get(i).n+"/"+roots.get(i).d);
      i++;   
      for (; i <roots.size(); i++) {
        if (roots.get(i).d == 1)
          stringToBePrinted+=(", "+roots.get(i).n);
        else
          stringToBePrinted+=(", "+roots.get(i).n+"/"+roots.get(i).d);
      }
    }
    stringToBePrinted+=("\nApprox. Roots: ");
    ArrayList<Float> approxRoots = p8.findApproxRoots(-3, 3, 100);
    for (Float i : approxRoots) {
      stringToBePrinted+=(i + " ");
    }
    stringToBePrinted+=("\n");
    return stringToBePrinted;
  }


void setup() {
  size(600, 600);

  background(255);
  createGUI();
  noLoop();

  //customGUI();
}

void constructPolynomialsFromGUI() {

  Polynomial sum = p6.getSum(p7);
  Polynomial difference = p6.getDifference(p7);
  Polynomial product = p6.multiply(p7);
  p6.graphPolynomial();
  ArrayList<Polynomial> quotientAndRemainder = p6.divide(p7);

  print("first polynomial: ");
  p6.printPolynomial();
  print(", second polynomial: ");
  p7.printPolynomial();

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
  ArrayList<Polynomial> polynomials = new ArrayList<Polynomial>();
  polynomials.add(p6);
  polynomials.add(p7);
  for (Polynomial p : polynomials) {
    print("\nRational roots: ");
    ArrayList<Rational> roots = p.findRationalRoots();
    if (roots.size() == 0)
      print("This polynomial has no rational roots");
    else {
      int i = 0;
      if (roots.get(i).d == 1)
        print(roots.get(i).n);
      else
        print(roots.get(i).n+"/"+roots.get(i).d);
      i++;   
      for (; i <roots.size(); i++) {
        if (roots.get(i).d == 1)
          print(", "+roots.get(i).n);
        else
          print(", "+roots.get(i).n+"/"+roots.get(i).d);
      }
    }
    print("\nApprox. Roots: ");
    ArrayList<Float> approxRoots = p.findApproxRoots(-3, 3, 100);
    for (Float i : approxRoots) {
      print(i + " ");
    }
    println("\n");
  }
}


float roundAny(float x, int d) {  //suppose x = 6.86927 and d = 2
  float y = x * pow(10, d);       //y = 686.927
  float z = round(y);            //z = 687
  return z / pow(10, d);          //6.87
}

void draw() {
  //testingStuff();
  background(0, 255, 0);
  polynomialToBeDrawn.graphPolynomial();
}
