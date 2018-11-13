import java.util.Arrays; 
String u1 = "7x^3+-x";
String u2 = "x^3+5x^2+-x";
String u3 = "4x^7+3x^2+-x+1";
String u4 = "7x^2+5x+-4";

void setup() {
  //size(600, 600);
  //background(0);
  
  Polynomial p1 = new Polynomial(u1);
  
  Polynomial p2 = new Polynomial(u2);
  Polynomial p5 = new Polynomial(u3);
  Polynomial p6 = new Polynomial(u4);
  
  print("polynomial 1: ");
  p1.printPolynomial();
  print("polynomial 2: ");
  p2.printPolynomial();
  
  //Polynomial p3 = p1.getSum(p2);
 
  Polynomial p4 = p1.getDifference(p2);

  print("difference: ");
  p4.printPolynomial();
  

}

void draw() {
}
