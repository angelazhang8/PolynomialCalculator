class Term {
  int coeff;
  int exponent;
  String term;
  Term(String term
    ) {
    this.term = term;
    //As one string
    //check if there is x
    if (this.term.indexOf("x") != -1) {
      //check if there is anything before x
      if (this.term.indexOf("x") == 0) {
        this.coeff = 1;
      } else if (this.term.substring(0, 1).equals("-")) {
        this.coeff = -1;
      } else {
        this.coeff = int(this.term.substring(0, this.term.indexOf("x")));
      }

      if (this.term.indexOf("^") != -1) {
        this.exponent = int(term.substring(this.term.indexOf("^") +1, this.term.length()) );
      } else {
        this.exponent = 1;
      }
    } else {
      this.coeff = int(term); //you just get your constant 
      this.exponent = 0; //exponent for x or whichever variable
    }
  }

  Term(int coeff, int exponent) {
    //just as coefficients
    this.coeff = coeff;
    this.exponent = exponent;
  }

  void printTerm() {
    print("+" + this.coeff + "x^" + this.exponent);
  }
}
