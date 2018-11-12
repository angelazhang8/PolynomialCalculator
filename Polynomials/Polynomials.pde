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

  //======methods
  //adding
  Polynomial getSum(Polynomial p) {

    ArrayList<Term>tempPolyTerms = p.polyTerms; 
    ArrayList<Term>sum = new ArrayList <Term>();

    //look at the similar coefficients and add those together
    for (int i = 0; i < this.polyTerms.size(); i++) {
      //go through all the terms in the polynomial and see if it matches the exponent and add coeffs
      for (int j = 0; j < tempPolyTerms.size(); j++) {

        if (this.polyTerms.get(i).exponent == tempPolyTerms.get(j).exponent) {//if they can be added

          //add the new term to the sum arraylist
          sum.add( new Term(tempPolyTerms.get(j).coeff + this.polyTerms.get(i).coeff, tempPolyTerms.get(j).exponent)); 

          //take the term away from temp polynomial storage
          tempPolyTerms.remove(tempPolyTerms.get(j));
        } else {
          sum.add( new Term(this.polyTerms.get(i).coeff, this.polyTerms.get(i).exponent));
        }
      }
    }
    return new Polynomial(sum);
  }

  //subtracting
  void subtract() {
  }

  //multiplying
  void multiply() {
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
