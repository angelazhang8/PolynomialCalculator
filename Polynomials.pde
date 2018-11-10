class Polynomial {
  String p;
  //add positive in front of negatives for string
  Term[] polyTerms;

  Polynomial (String p) {
    //create an array of terms
    String [] terms = split(p, "+");
    this.polyTerms= new Term[terms.length];

    for (int i = 0; i < terms.length; i++) {//make the array of terms
      //if we take the terms from the string we split
      this.polyTerms[i] = new Term(terms[i]);

      //or if we take the coefficients directly from the GUI
      //polyTerms[i] = new Term(something, something);
    }
  }

  Polynomial (Term [] polyTerms) {
    this.polyTerms = polyTerms;
  }

  Polynomial ( ArrayList< Term> p) {
    Term [] polyTerms = new Term[p.size()];
    this.polyTerms = p.toArray(polyTerms);
  }

  void printPolynomial () {
    for (int i = 0; i < this.polyTerms.length; i++) {

      this.polyTerms[i].printTerm();
    }
    println();
  }

  //======methods
  //adding
  Polynomial getSum(Polynomial p) {
    ArrayList<Term>tempPolyTerms = new ArrayList<Term>(Arrays.asList(p.polyTerms));

    //Term [] tempPolyTerms = p.polyTerms; 
    ArrayList<Term>sum = new ArrayList <Term>();

    //look at the similar coefficients and add those together
    for (int i = 0; i < this.polyTerms.length; i++) {
      //go through all the terms in the polynomial and see if it matches the exponent and add coeffs
      for (int j = 0; j < tempPolyTerms.size(); j++) {

        if (this.polyTerms[i].exponent == tempPolyTerms.get(j).exponent) {//if they can be added

          //add the new term to the sum arraylist
          sum.add( new Term(tempPolyTerms.get(j).coeff + this.polyTerms[i].coeff, tempPolyTerms.get(j).exponent)); 

          //take the term away from temp polynomial storage
          tempPolyTerms.remove(tempPolyTerms.get(j));
        } else {
          sum.add( new Term(this.polyTerms[i].coeff, this.polyTerms[i].exponent));
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
