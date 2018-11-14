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

  Polynomial getDifference(Polynomial other) {

    ArrayList<Term> otherTerms = other.polyTerms; 
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
    //this 3x^5+2x^3+2x^2     +1
    //othe 4x^5     +4x^2+3x^1+2

    //subtracting
    //Polynomial getDifference(Polynomial p) {

    //  ArrayList<Term>tempPolyTerms = p.polyTerms; 
    //  ArrayList<Term>difference = new ArrayList <Term>();
    //  //look at the similar coefficients and add those together
    //  for (int i = 0; i < this.polyTerms.size(); i++) {
    //    //go through all the terms in the polynomial and see if it matches the exponent and add coeffs
    //    boolean subtractableTermSecondPolynomial = false; //checks to see if the term with the same exponent is in the second polynomial

    //    for (int j = 0; j < tempPolyTerms.size(); j++) {
    //      if (this.polyTerms.get(i).exponent == tempPolyTerms.get(j).exponent) {//if they can be added
    //        //add the new term to the sum arraylist
    //        subtractableTermSecondPolynomial = true;
    //        difference.add( new Term(this.polyTerms.get(i).coeff - tempPolyTerms.get(j).coeff, this.polyTerms.get(j).exponent)); 
    //        println(i, j, subtractableTermSecondPolynomial);
    //        //take the term away from temp polynomial storage
    //        tempPolyTerms.remove(tempPolyTerms.get(j));
    //      } else {
    //        subtractableTermSecondPolynomial = false;
    //      }
    //    } 
    //    if (!subtractableTermSecondPolynomial) {
    //      difference.add( new Term(this.polyTerms.get(i).coeff, this.polyTerms.get(i).exponent));
    //    }
    //  }
    //  for (int i = 0; i < tempPolyTerms.size(); i++) {
    //    difference.add(new Term( tempPolyTerms.get(i).coeff*-1, tempPolyTerms.get(i).exponent ) );
    //  }
    //  return new Polynomial(difference);
    //}

    //multiplying
    Polynomial multiply(Polynomial p) {
      ArrayList<Term>product = new ArrayList <Term>();
      //take the first term and multiply it to the first, second, then add

      for (Term i : polyTerms) {
        for (Term j : p.polyTerms ) {
          //multiply
          product.add(new Term (i.coeff*j.coeff, i.exponent + j.exponent));
        }
      }
      return new Polynomial(product );
    }

    //dividing
    void dividing() {
    }

    //
    //Polynomial collectLikeTerms() {
    //  ArrayList<Term>tempPolyTerms = this.polyTerms;
    //  ArrayList<Term>returnPolynomial = new ArrayList<Term>();

    //  //a for loop to check for the all the terms in sequential order
    //  for (int i = 0; i < polyTerms.size(); i++) {
    //    int coeff = tempPolyTerms.get(i).coeff;
    //    for (int j = tempPolyTerms.size(); j > 0 ; j--) {
    //      if (tempPolyTerms.get(i).exponent == tempPolyTerms.get(j).exponent) {
    //        coeff += tempPolyTerms.get(j).coeff;
    //        tempPolyTerms.remove(tempPolyTerms.get(j));
    //      }
    //    }
    //    returnPolynomial.add(new Term(coeff, tempPolyTerms.get(i).exponent));
    //    tempPolyTerms.remove(tempPolyTerms.get(i));
    //  }
    //  return (new Polynomial (returnPolynomial));
    //}
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
