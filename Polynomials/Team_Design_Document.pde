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
  Polynomial p3 = new Polynomial(u3);
  Polynomial p4 = new Polynomial(u4);

  Polynomial sum = p1.getSum(p2);
  Polynomial difference = p1.getDifference(p2);
  Polynomial product = p1.multiply(p2);


  print("first polynomial: ");
  p1.printPolynomial();

  print("second polynomial: ");
  p2.printPolynomial();

  print("sum: ");
  sum.printPolynomial();

  print("difference: ");
  difference.printPolynomial();

  print("multiply: ");
  product.printPolynomial();
  ArrayList<Polynomial> quotientAndRemainder = p1.divide(p2);

  print("quotient: ");
  quotientAndRemainder.get(0).printPolynomial();

  print("remainder: ");
  quotientAndRemainder.get(1).printPolynomial();

  print("Roots: ");
  ArrayList<Rational> roots = p1.findRoots();
  if (roots.size() == 0)
    print("This polynomial has no roots");
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
}

void draw() {
}
