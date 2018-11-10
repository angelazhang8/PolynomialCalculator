import java.util.Arrays; 
String u1 = "x^3+5x^2+-x";
String u2 = "7x^3+-x";

void setup() {
  //size(600, 600);
  //background(0);
  Polynomial p1 = new Polynomial(u1);
  Polynomial p2 = new Polynomial(u2);
  p1.printPolynomial();
  p2.printPolynomial();
  Polynomial p3 = p1.getSum(p2);
  p3.printPolynomial();
}

void draw() {
}
