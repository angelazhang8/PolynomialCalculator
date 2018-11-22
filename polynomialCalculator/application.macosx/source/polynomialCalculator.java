import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.Arrays; 
import g4p_controls.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class polynomialCalculator extends PApplet {

  


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

public void testingStuff() { //testing the test cases (not relevant for running the program)
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

public String printRootsToScreen () { //returns the String text for the label

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


public void setup() { //creates the sketch window for the graph initially
  
  background(255);
  createGUI();
  noLoop(); //we don't want draw to be continously called because it will overwrite the graph
}


public float roundAny(float x, int d) {  //suppose x = 6.86927 and d = 2
  float y = x * pow(10, d);       //y = 686.927
  float z = round(y);            //z = 687
  return z / pow(10, d);          //6.87
}

public void draw() {
  background(255);
  //the method that graphs the polynomial on the sketch window
  //the graph appears once redraw is called in the GUI
  //at first the polynomial is set to y=
  polynomialToBeDrawn.graphPolynomial();
}

class Polynomial {
  String p;
  ArrayList<Term>polyTerms = new ArrayList <Term>();
  final float ACCURACY = 0.00000000001f;  // accuracy when finding approx. roots

  Polynomial (String p) {
    this.polyTerms = new ArrayList<Term>(); //these are all the terms in the polynomial
    int sign = 1; //negative/positive sign
    int coeff = 0; //coefficient of the term
    int exponent = 0; //exponent of the term
    
    //these variables help with string manipulation
    int curI = 0; //the current index 
    int xI = 0; // x index
    int endI = 0; //ending index
    
    if (p.charAt(0) == '-') {//if there is a negative in front of the leading coefficient
      sign = -1; 
      curI += 1; //increase current index
    }
    //"-2x^3-2x^2+2x+4"
    
    while (curI != p.length()) { //while you haven't reached the end
      xI = p.indexOf("x", curI); //find where the x index is in the string
      if (xI == -1) { 
        // no 'x', this is the constant term
        coeff = sign * PApplet.parseInt(p.substring(curI, p.length()));
        this.polyTerms.add(new Term(coeff, 0)); //add a term as just the coefficient with no exponent
        return;
      }
      if (curI == xI) { 
        coeff = sign * 1; //it has no coefficient
      } else {
        coeff = sign * PApplet.parseInt(p.substring(curI, xI)); 
      }

      // find end index of this term since a +/- signifies the beginning of a new term
      int plusIndex = p.indexOf("+", xI);
      int minusIndex = p.indexOf("-", xI);
      
      if (plusIndex == -1 && minusIndex == -1) {
        // no '+' or '-' after 'x', this is the last term
        if (xI + 1 != p.length() && p.charAt(xI + 1) == '^')
          exponent = PApplet.parseInt(p.substring(xI + 2, p.length()));
        else
          exponent = 1;
        this.polyTerms.add(new Term(coeff, exponent));
        return;
      }

      if (plusIndex == -1 || (minusIndex != -1 && plusIndex > minusIndex)) {
        // first sign seen is '-', next term's sign is '-'
        sign = -1;
        endI = minusIndex;
      } else {
        // first sign seen is '+', next term's sign is '+'
        sign = 1;
        endI = plusIndex;
      }
      if (xI + 1 != p.length() && p.charAt(xI + 1) == '^') //if there is an exponent
        exponent = PApplet.parseInt(p.substring(xI + 2, endI));
      else
        exponent = 1;
      this.polyTerms.add(new Term(coeff, exponent));
      curI = endI + 1;
    }
  }

  Polynomial (ArrayList<Term> a) { //second constructor
    this.polyTerms = a;
  }

  public void printPolynomial () { //prints the polynomial to console, used primarily for testing
    int i = 0;
    if (this.polyTerms.size() == 0)
      return;
    if (this.polyTerms.get(i).coeff == 1) {
      if (this.polyTerms.get(i).exponent == 0)
        print("1");
      else 
      print("");
    } else if (this.polyTerms.get(i).coeff == -1)
      print("-");
    else 
    print(this.polyTerms.get(i).coeff);

    if (this.polyTerms.get(i).exponent == 0)  
      print("");
    else if (this.polyTerms.get(i).exponent == 1)  
      print("x");
    else 
    print("x^" + this.polyTerms.get(i).exponent);

    for (i = 1; i < this.polyTerms.size(); i++) {    
      if (this.polyTerms.get(i).coeff == 1) {
        if (this.polyTerms.get(i).exponent == 0)
          print("+1");
        else 
        print("+");
      } else if (this.polyTerms.get(i).coeff == -1)
        print("-");
      else if (this.polyTerms.get(i).coeff > 0)
        print("+" + this.polyTerms.get(i).coeff);
      else 
      print(this.polyTerms.get(i).coeff);

      if (this.polyTerms.get(i).exponent == 0)  
        print("");
      else if (this.polyTerms.get(i).exponent == 1)  
        print("x");
      else 
      print("x^" + this.polyTerms.get(i).exponent);
    }
  }

  public String printPolynomialtoGUIScreen () { //returns a string to be displayed on the label in GUI
    String yourAnswer = "";
    int i = 0;
    if (this.polyTerms.size() == 0)
      return "";
    if (this.polyTerms.get(i).coeff == 1) {
      if (this.polyTerms.get(i).exponent == 0)
        yourAnswer+=("1");
      else 
      yourAnswer+=("");
    } else if (this.polyTerms.get(i).coeff == -1)
      yourAnswer+=("-");
    else 
    yourAnswer+=(this.polyTerms.get(i).coeff);

    if (this.polyTerms.get(i).exponent == 0)  
      yourAnswer+=("");
    else if (this.polyTerms.get(i).exponent == 1)  
      yourAnswer+=("x");
    else 
    yourAnswer+=("x^" + this.polyTerms.get(i).exponent);

    for (i = 1; i < this.polyTerms.size(); i++) {    
      if (this.polyTerms.get(i).coeff == 1) {
        if (this.polyTerms.get(i).exponent == 0)
          yourAnswer+=("+1");
        else 
        yourAnswer+=("+");
      } else if (this.polyTerms.get(i).coeff == -1)
        yourAnswer+=("-");
      else if (this.polyTerms.get(i).coeff > 0)
        yourAnswer+=("+" + this.polyTerms.get(i).coeff);
      else 
      yourAnswer+=(this.polyTerms.get(i).coeff);

      if (this.polyTerms.get(i).exponent == 0)  
        yourAnswer+=("");
      else if (this.polyTerms.get(i).exponent == 1)  
        yourAnswer+=("x");
      else 
      yourAnswer+=("x^" + this.polyTerms.get(i).exponent);
    }
    return yourAnswer;
  }

  //adding
  public Polynomial getSum(Polynomial other) {
    ArrayList<Term> minusOther = new ArrayList<Term>();
    for (Term i : other.polyTerms) {
      minusOther.add(new Term(-1*i.coeff, i.exponent)); //to subtract, you're adding the negated version of the second poylnomial
    }
    return this.getDifference(new Polynomial(minusOther));
  }
  
  public Polynomial getDifference(final Polynomial other) {
    final ArrayList<Term> otherTerms = other.polyTerms; 
    ArrayList<Term> difference = new ArrayList <Term>();
    
    if (otherTerms.size() == 0) { //copies an array of this.polyTerms, or else it'll overwrite the original
      for (Term i : this.polyTerms) {
        difference.add(new Term(i.coeff, i.exponent));
      }
      return new Polynomial(difference);
    }
    if (this.polyTerms.size() == 0) {//if the first polynomial is empty
      // negate other and return
      for (Term i : otherTerms) {
        difference.add(new Term(-1*i.coeff, i.exponent));
      }
      return new Polynomial(difference);
    }
    for (int i=0, j=0;; ) {
      if (this.polyTerms.get(i).exponent == other.polyTerms.get(j).exponent ) { //if they are able to be subtracted 
        int coeff = this.polyTerms.get(i).coeff - other.polyTerms.get(j).coeff;
        if (coeff != 0) {
          difference.add(new Term(coeff, other.polyTerms.get(j).exponent));
        }
        i++; //move both indexes along
        j++;
      } else if (this.polyTerms.get(i).exponent > other.polyTerms.get(j).exponent) {
        difference.add(this.polyTerms.get(i));
        i++; //move the index of 'this'
      } else {
        difference.add(new Term(other.polyTerms.get(j).coeff*-1, other.polyTerms.get(j).exponent));
        j++; //moves the index of 'other'
      }
      if (i == this.polyTerms.size()) { //if you have reached the end of 'this' subtract remaining terms from 'other'
        for (; j<otherTerms.size(); j++) {
          difference.add(new Term(other.polyTerms.get(j).coeff*-1, other.polyTerms.get(j).exponent));
        }
        break;
      }
      if (j == other.polyTerms.size()) { //vice versa here
        for (; i<this.polyTerms.size(); i++) {
          difference.add(this.polyTerms.get(i));
        }
        break;
      }
    }
    return new Polynomial(difference);
  }

  //multiplying
  public Polynomial multiply(Polynomial other) {
    ArrayList<Term> product = new ArrayList<Term>();
    for (Term i : this.polyTerms) {
      for (Term j : other.polyTerms) {
        int exponent = i.exponent + j.exponent;
        int coeff = i.coeff * j.coeff;
        
        for (int p=0; p<product.size(); p++) { //loop over the terms in product and see if you can simplify the 'product' 
          if (product.get(p).exponent == exponent) {
            product.get(p).coeff += coeff;
            break;
          } else if (product.get(p).exponent < exponent) { //add new term so that it is after the term with the exponent bigger than it
            product.add(p, new Term(coeff, exponent)); //you want the terms to be in descending order
            break;
          }
        }
        if (product.isEmpty()|| exponent < product.get(product.size()-1).exponent) {//special cases 
          product.add(product.size(), new Term(coeff, exponent));
        }
      }
    }
    for (int i = 0; i < product.size(); ) { //if coefficient is 0, remove term
      if (product.get(i).coeff == 0) {
        product.remove(i);
      } else {
        i++;
      }
    }
    return new Polynomial(product);
  }

  //dividing
  public ArrayList<Polynomial> divide(final Polynomial d) {
    final ArrayList<Term> divisor = d.polyTerms;
    ArrayList<Term> quotient = new ArrayList<Term>();
    ArrayList<Term> dividend = new ArrayList<Term>();
    for (Term i : this.polyTerms) {
      dividend.add(new Term(i.coeff, i. exponent));
    }
    if (this.polyTerms.size() == 0) {
      ArrayList<Polynomial> result = new ArrayList<Polynomial>();
      result.add(new Polynomial (quotient));
      result.add(new Polynomial (dividend));
      return(result);
    }

    while (true) {
      int exponDiff = dividend.get(0).exponent - divisor.get(0).exponent;
      if (exponDiff < 0) break; //if the exponent of the divisor is larger, then you can't divide
      if (dividend.get(0).coeff % divisor.get(0).coeff != 0) { //can't divide the coeffs, so you give up
        break;
      } 
      int coeffMult = dividend.get(0).coeff / divisor.get(0).coeff;
      quotient.add(new Term(coeffMult, exponDiff)); //first division of the first term 
      
      ArrayList<Term> temp = new ArrayList<Term>();
      for (Term i : divisor) {
        temp.add(new Term(i.coeff*coeffMult, i.exponent+exponDiff));
      }
      dividend = ((new Polynomial(dividend)).getDifference(new Polynomial(temp))).polyTerms; 
      //get the new dividend by subtracting the divisor * quotient term from the original dividend
      if (dividend.size() == 0)
        break;
    }

    ArrayList<Polynomial> result = new ArrayList<Polynomial>();
    result.add(new Polynomial (quotient));
    result.add(new Polynomial (dividend));
    return(result);
  }
  
  public Polynomial findDerivative() {
    ArrayList<Term>derivativeTerms= new ArrayList<Term>(); 
    for (Term i : this.polyTerms) {
      if (i.exponent == 0) 
        continue;
      int newCoeff = (i.coeff*i.exponent); //following differentiation rules
      int newExp = i.exponent-1;
      derivativeTerms.add(new Term(newCoeff, newExp));
    }
    return (new Polynomial(derivativeTerms));
  }


  //graphing
  public void graphPolynomial() {

    float xIncrement = 0.1f;

    int numpoints = PApplet.parseInt((xMax-xMin)/xIncrement)+ 1;   // calculate number of points

    float [] xValues = new float [numpoints]; 
    float [] yValues = new float [numpoints]; 

    for ( int i=0; i<numpoints; i++) {  // calulate x and y Values and put them into arrays
      float x = roundAny((xMin+(xIncrement*i)), 2); 

      float newYVal = 0;
      for (int j = 0; j < this.polyTerms.size(); j++) {
        float TermValue = this.polyTerms.get(j).coeff*pow(x, this.polyTerms.get(j).exponent); 
        newYVal += TermValue;
      }
      yValues[i] = newYVal;
      xValues[i] = x;

    }
    // transform points from actual value to screen coordinates
    int Factor = abs(xMax); 
    
    float [] ScreenX = new float [numpoints];
    float [] ScreenY = new float [numpoints];

    for (int i=0; i<numpoints; i++) {
      ScreenX[i] = (width/2)+(xValues[i]*Factor);
      ScreenY[i] = (width/2)-(yValues[i]*Factor);
    }

    for (int i=1; i<numpoints; i++) {
      line(ScreenX[i], ScreenY[i], ScreenX[i-1], ScreenY[i-1]);
      fill(0);
    }
    line((width/2), 0, (width/2), width);
    fill(0);
    line(0, (width/2), width, (width/2)); 
    fill(0);
    
    for(int i= xMin; i<(xMax-xMin)+1; i++){
      int x = (width/2)+(i*Factor);
      line(x,((width/2)-5),x,((width/2)+10));
      text(i, x, ((width/2)+20)); 
      textAlign(CENTER); 
      line(((width/2)-5),x,((width/2)+5),x);
      text(-i, ((width/2)+20),x); 
      textAlign(CENTER); 
      fill(0);
    }
  }
    
  public float getYforX(float x) { //function used in finding roots to find the y value for x 
    float result = 0;
    for (Term i : this.polyTerms) {
      result +=pow(x, i.exponent)*i.coeff;
    }
    return result;
  }

  public float findOneApproxRoot(float xBegin, float xEnd) {
    float n = 8; //the number of sections you've decided to search in within the larger range
    float increment = (xEnd - xBegin) / n;
    if (xBegin == xBegin + increment) {
      //println("x range: " + xBegin + " to " + xEnd + " is too small, increment=" + increment + ", return xBegin as approx. root");
      return xBegin;
    }
    float yValue = getYforX(xBegin);
    //println("x range: " + xBegin + " to " + xEnd + ", y is " + yValue + " to " + getYforX(xEnd));
    if (abs(yValue) < this.ACCURACY) {
      //println("find root=" + xBegin + " y=" + yValue);
      return xBegin;
    }
    for (int i = 1; i <= n; i++) {
      float xI = xBegin + i * increment;
      float yI = getYforX(xI);
      if (abs(yI) < this.ACCURACY) {
        //println("find root=" + xI + " y=" + yI);
        return xI;
      }
      if ((yI < 0 && yValue > 0) || (yI > 0 && yValue < 0)) {
        return findOneApproxRoot(xI - increment, xI); //recursive formula to find a more accurate root in a new range
      }
    }
    //println("ACCURARY is too small. No root between " + xBegin + " " + xEnd);
    return xBegin;
  }

  //root approximater
  public ArrayList<Float> findApproxRoots(float xBegin, float xEnd, int steps) {
    //essentially to approx, you need to find where the signs change from negative to positive  
    //and then "zoom" in on that section until you deem the accuracy is enough
    //the final root is rounded to 2 decimal places
    ArrayList<Float> result = new ArrayList<Float>();
    float increment = (xEnd - xBegin) / steps; 
    while (true) {
      float yValue = getYforX(xBegin);
      // find first non-root
      while (true) {
        if (xBegin > xEnd) 
          return result;
        if (abs(yValue) < this.ACCURACY) {
          result.add(roundAny(new Float(xBegin), 3)); //add the root, because it is accurate enough per standards
          xBegin += increment;
          yValue = getYforX(xBegin);
        } else {
          break;
        }
      }
      float xI = xBegin + increment;  
      while (true) {
        if (xI > xEnd)
          return result;
        float yI = getYforX(xI); //if the y value is close enough to 0
        if (abs(yI) < this.ACCURACY) { //so that you can tell if it is accurate enough
          xBegin = xI;
          break;
        }
        if ((yI < 0 && yValue > 0) || (yI > 0 && yValue < 0)) { //checks to see if there is a root in the range
          //println("yI sign changed between " + (xI - increment) + " and " + xI + ", y is " + getYforX(xI - increment) + " and " + yI);
          float root = findOneApproxRoot(xI - increment, xI); //zoom in closer to approx root
          result.add(roundAny(new Float(root), 3)); //round answer
          xBegin = xI; 
          break;
        }
        xI += increment;
      }
    }
  }

  //based on some sketchy theorem http://mathworld.wolfram.com/PolynomialRoots.html
  //example 1: x^3 - x - 6 //dn=1 d0=-6
  //example 2: x^3 + x     //dn=1 d0=0
  public ArrayList<Rational> findRationalRoots() {
    ArrayList<Term> p = this.polyTerms;
    ArrayList<Rational>result = new ArrayList<Rational>();
    int minExp = p.get(p.size()-1).exponent;
    if (minExp != 0) { //if d0 == 0
      result.add(new Rational(0, 1));
    }

    ArrayList<Integer> numerators, denominators;
    if (p.get(0).coeff < 0) { //finding factors of denominator
      denominators = findFactors(-1*p.get(0).coeff);
    } else {
      denominators = findFactors(p.get(0).coeff);
    }
    if (p.get(p.size()-1).coeff < 0) { //finding factors of numerator
      numerators = findFactors(-1 * p.get(p.size()-1).coeff);
    } else {
      numerators = findFactors(p.get(p.size()-1).coeff);
    }

    for (int n : numerators) { //finds all the rational roots and adds them to the result
      for (int d : denominators) {
        Rational possibleRoot = new Rational(n, d);
        if (isRoot(possibleRoot, minExp))
          result.add(possibleRoot);
        possibleRoot = new Rational(-n, d);
        if (isRoot(possibleRoot, minExp))
          result.add(possibleRoot);
      }
    }
    return result;
  }

  public boolean isRoot(Rational r, int minusExp) { //checks to see if the rational violates any rules
    Rational result = new Rational (0, 1);
    for (Term i : this.polyTerms) {
      if (i.exponent - minusExp > 0) {
        Rational t = new Rational (r.n, r.d);
        for (int j = 0; j < i.exponent - minusExp - 1; j++) {
          t.multiply(r);
        }
        t.multiply(new Rational(i.coeff, 1));
        result.add(t);
      } else {
        result.add(new Rational(i.coeff, 1));
      }
    }
    return result.n == 0;
  }

  //find factors of non-negative integer argument, used for finding rational roots
  public ArrayList<Integer>findFactors(int num) {
    ArrayList<Integer>result = new ArrayList<Integer>(); 
    for (int i = 1; i <= num; i++) {
      if (num%i == 0)
        result.add(i);
    }
    return (result);
  }
}

//used in finding the rational roots
//essentially, you're just trying to return a fraction
//pretty standard stuff

class Rational { 
  int n, d;
  Rational(int n, int d) {
    this.n = n;
    this.d = d;
    if (this.n == 0)
      this.d = 1;
  }
  public void add(Rational other) {
    int tempD = this.d * other.d;
    int tempN = this.n*other.d + this.d*other.n;
    int g = gcd(tempD, tempN);
    this.n = tempN/g;
    this.d = tempD/g;
    if (this.n == 0)
      this.d = 1;
  }

  public void multiply(Rational other) {
    int tempN = this.n*other.n;
    int tempD = this.d*other.d;
    int g = gcd(tempD, tempN);
    this.n = tempN/g;
    this.d = tempD/g;
    if (this.n == 0)
      this.d = 1;
  }

  public int gcd(int a, int b) {
    while (b != 0) {
      int r = a % b;
      a = b;
      b = r;
    }
    return a;
  }
}
class Term {
  int coeff;
  int exponent;
  String term;

  Term(String term) { //"-x^3+-3x^2+x+1"
    this.term = term;
    //As one string
    //check if there is x
    if (this.term.indexOf("x") != -1) {
      //check if there is anything before x
      if (this.term.indexOf("x") == 0) {
        this.coeff = 1;
      } else if (this.term.indexOf("-") == 0 && this.term.indexOf("x") == 1) {
        this.coeff = -1;
      }
    } else {        
      this.coeff = PApplet.parseInt(this.term.substring(0, this.term.indexOf("x")));
    }

    if (this.term.indexOf("^") != -1) {
      this.exponent = PApplet.parseInt(term.substring(this.term.indexOf("^") +1, this.term.length()) );
      this.exponent = 0;
    } else {
      this.coeff = PApplet.parseInt(term); //you just get your constant 
      this.exponent = 0; //exponent for x or whichever variable
    }
  }

  Term(int coeff, int exponent) { 
    this.coeff = coeff;
    this.exponent = exponent;
  }

  public void printTerm() {
    print("+" + this.coeff + "x^" + this.exponent);
  }
}
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
  int numDerivative = PApplet.parseInt((p8.polyTerms.get(0).exponent) * derivativeSliderNumber);
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
  derivativeSlider = new GSlider(window1, 238, 312, 158, 40, 10.0f);
  derivativeSlider.setLimits(0.0f, 0.0f, 1.0f);
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

  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "polynomialCalculator" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
