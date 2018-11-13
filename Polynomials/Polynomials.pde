class Polynomial {
  String p;
  //add positive in front of negatives for string
  ArrayList<Term>polyTerms = new ArrayList <Term>();

  Polynomial (String p) {
    //create an array of terms from string after splitting
    String [] terms = split(p, "+");

    for (int i = 0; i < terms.length; i++) {//make the arraylist of terms
      //if we take the terms from the string we split
      this.polyTerms.add(new Term(terms[i]));

      //or if we take the coefficients directly from the GUI
      //polyTerms[i] = new Term(something, something);
    }
  }
  Polynomial (ArrayList<Term> a) {
    this.polyTerms = a;
  }

  void printPolynomial () {
    for (int i = 0; i < this.polyTerms.size(); i++) {
      this.polyTerms.get(i).printTerm();
    }

    println();
  }

  void simplify() {
    //if coefficient is +-1, then just omit it

    //if the first term's sign is a +, then remove

    //if the power for x is 0, then just omit it and leave a constant

    //if coefficient is 0, omit term
    for (Term i : this.polyTerms) {
      if (i.coeff == 0)
        polyTerms.remove(i);
    }
  }

  void displayPolynomial() {
    //get rid of - signs in front of terms, unless it's the first one, and just do subtraction
  }

  //======methods
  //adding
  Polynomial getSum(Polynomial p) {

    ArrayList<Term>tempPolyTerms = p.polyTerms; 
    ArrayList<Term>sum = new ArrayList <Term>();

    //look at the similar coefficients and add those together
    for (int i = 0; i < this.polyTerms.size(); i++) {
      //go through all the terms in the polynomial and see if it matches the exponent and add coeffs
      boolean summableTermSecondPolynomial = false; //checks to see if the term with the same exponent is in the second polynomial

      for (int j = 0; j < tempPolyTerms.size(); j++) {
        if (this.polyTerms.get(i).exponent == tempPolyTerms.get(j).exponent) {//if they can be added
          summableTermSecondPolynomial = true;
          //add the new term to the sum arraylist
  
          sum.add( new Term(tempPolyTerms.get(j).coeff + this.polyTerms.get(i).coeff, tempPolyTerms.get(j).exponent)); 

          //take the term away from temp polynomial storage
          tempPolyTerms.remove(tempPolyTerms.get(j));
        }
      } 
      if (!summableTermSecondPolynomial) {
        sum.add( new Term(this.polyTerms.get(i).coeff, this.polyTerms.get(i).exponent));
      }
    }

    for (int i = 0; i < tempPolyTerms.size(); i++) {
      sum.add(new Term( tempPolyTerms.get(i).coeff, tempPolyTerms.get(i).exponent ) );
    }
    return new Polynomial(sum);
  }

  //subtracting
  Polynomial getDifference(Polynomial p) {

    ArrayList<Term>tempPolyTerms = p.polyTerms; 
    ArrayList<Term>difference = new ArrayList <Term>();
    //look at the similar coefficients and add those together
    for (int i = 0; i < this.polyTerms.size(); i++) {
      //go through all the terms in the polynomial and see if it matches the exponent and add coeffs
      boolean subtractableTermSecondPolynomial = false; //checks to see if the term with the same exponent is in the second polynomial

      for (int j = 0; j < tempPolyTerms.size(); j++) {
        if (this.polyTerms.get(i).exponent == tempPolyTerms.get(j).exponent) {//if they can be added
          //add the new term to the sum arraylist
          subtractableTermSecondPolynomial = true;
          difference.add( new Term(this.polyTerms.get(i).coeff - tempPolyTerms.get(j).coeff, this.polyTerms.get(j).exponent)); 
          println(i, j, subtractableTermSecondPolynomial);
          //take the term away from temp polynomial storage
          tempPolyTerms.remove(tempPolyTerms.get(j));
          
        } else {
          subtractableTermSecondPolynomial = false;
        }
      } 
      if (!subtractableTermSecondPolynomial) {
        difference.add( new Term(this.polyTerms.get(i).coeff, this.polyTerms.get(i).exponent));
      }
    }
    for (int i = 0; i < tempPolyTerms.size(); i++) {
      difference.add(new Term( tempPolyTerms.get(i).coeff*-1, tempPolyTerms.get(i).exponent ) );
    }
    return new Polynomial(difference);
  }

  //multiplying
  Polynomial multiply(Polynomial p) {
    //take the first term and multiply it to the first, second, then add
    for (Term i : polyTerms) {
      for (Term j : p.polyTerms ) {
      
      
      }
    }
  return new Polynomial( );
  }

  //dividing
  void dividing() {
  }

  //graphing
  void graphPolynomial() {
  }

  //find roots
  void findRoots() {
    
  }

  //find derivative
  void findDerivative() {
  }
}
