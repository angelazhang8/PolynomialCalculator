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
  Polynomial getSum(Polynomial other) {
    ArrayList<Term> minusOther = other.polyTerms;
    for (Term i : minusOther) {
      i.coeff *= -1;
    }
    return this.getDifference(new Polynomial(minusOther));
  }

  Polynomial getDifference(final Polynomial other) {

    final ArrayList<Term> otherTerms = other.polyTerms; 
    ArrayList<Term> difference = new ArrayList <Term>(); 

    for (int i=0, j=0;; ) {
      if (this.polyTerms.get(i).exponent == other.polyTerms.get(j).exponent ) {
        int coeff = this.polyTerms.get(i).coeff - other.polyTerms.get(j).coeff;
        if (coeff != 0) {
          difference.add(new Term(coeff, other.polyTerms.get(j).exponent));
        }
        i++;
        j++;
      } else if (this.polyTerms.get(i).exponent > other.polyTerms.get(j).exponent) {
        difference.add(this.polyTerms.get(i));
        i++;
      } else {
        difference.add(new Term(other.polyTerms.get(j).coeff*-1, other.polyTerms.get(j).exponent));
        j++;
      }
      if (i == this.polyTerms.size()) {
        for (; j<otherTerms.size(); j++) {
          difference.add(new Term(other.polyTerms.get(j).coeff*-1, other.polyTerms.get(j).exponent));
        }
        break;
      }
      if (j == other.polyTerms.size()) {
        for (; i<this.polyTerms.size(); i++) {
          difference.add(this.polyTerms.get(i));
        }
        break;
      }
    }
    return new Polynomial(difference);
  }

  //multiplying
  Polynomial multiply(Polynomial other) {
    ArrayList<Term> product = new ArrayList<Term>();
    for (Term i : this.polyTerms) {
      for (Term j : other.polyTerms) {
        int exponent = i.exponent + j.exponent;
        int coeff = i.coeff * j.coeff;
        for (int p=0; p<product.size(); p++) {
          if (product.get(p).exponent == exponent) {
            product.get(p).coeff += coeff;
            break;
          } else if (product.get(p).exponent < exponent) {
            product.add(p, new Term(coeff, exponent));
            break;
          }
        }
        if (product.isEmpty()|| exponent < product.get(product.size()-1).exponent) {
          product.add(product.size(), new Term(coeff, exponent));
        }
      }
    }
    for (int i = 0; i < product.size(); ) {
      if (product.get(i).coeff == 0) {
        product.remove(i);
      } else {
        i++;
      }
    }
    return new Polynomial(product);
  }

  //dividing

  ArrayList<Polynomial> divide(final Polynomial d) {
    final ArrayList<Term> divisor = d.polyTerms;
    ArrayList<Term> quotient = new ArrayList<Term>();
    ArrayList<Term> dividend = new ArrayList<Term>();
    for (Term i : this.polyTerms) {
      dividend.add(new Term(i.coeff, i. exponent));
    }
    while (true) {
      int exponDiff = dividend.get(0).exponent - divisor.get(0).exponent;
      if (exponDiff < 0) break;
      if (dividend.get(0).coeff % divisor.get(0).coeff != 0) { 
        break;
      } //can't divide the coeffs
      int coeffMult = dividend.get(0).coeff / divisor.get(0).coeff;
      quotient.add(new Term(coeffMult, exponDiff));  
      ArrayList<Term> temp = new ArrayList<Term>();
      for (Term i : divisor) {
        temp.add(new Term(i.coeff*coeffMult, i.exponent+exponDiff));
      }
      dividend = ((new Polynomial(dividend)).getDifference(new Polynomial(temp))).polyTerms;
    }

    ArrayList<Polynomial> result = new ArrayList<Polynomial>();
    result.add(new Polynomial (quotient));
    result.add(new Polynomial (dividend));
    return(result);
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
