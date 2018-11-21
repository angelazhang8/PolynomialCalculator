class Polynomial {
  String p;
  //add positive in front of negatives for string
  ArrayList<Term>polyTerms = new ArrayList <Term>();
  // accuracy when finding approx. roots
  final float ACCURACY = 0.00000000001;

  Polynomial (String p) {
    this.polyTerms = new ArrayList<Term>();
    int sign = 1;
    int coeff = 0;
    int exponent = 0;
    int curI = 0;
    int xI = 0;
    int endI = 0;
    if (p.charAt(0) == '-') {
      sign = -1;
      curI += 1;
    }//"-2x^3-2x^2+2x+4"
    while (curI != p.length()) {
      xI = p.indexOf("x", curI);
      if (xI == -1) {
        // no 'x', this is the last term and the constant term
        coeff = sign * int(p.substring(curI, p.length()));
        this.polyTerms.add(new Term(coeff, 0));
        return;
      }
      if (curI == xI) {
        coeff = sign * 1;
      } else {
        coeff = sign * int(p.substring(curI, xI));
      }

      // find end index of this term
      int plusIndex = p.indexOf("+", xI);
      int minusIndex = p.indexOf("-", xI);
      if (plusIndex == -1 && minusIndex == -1) {
        // no '+' or '-' after 'x', this is the last term
        if (xI + 1 != p.length() && p.charAt(xI + 1) == '^')
          exponent = int(p.substring(xI + 2, p.length()));
        else
          exponent = 1;
        this.polyTerms.add(new Term(coeff, exponent));
        return;
      }

      if (plusIndex == -1 || (minusIndex != -1 && plusIndex > minusIndex)) {
        // first seen '-', next term's sign is -
        sign = -1;
        endI = minusIndex;
      } else {
        // first seen '+', next term's sign is +
        sign = 1;
        endI = plusIndex;
      }
      if (xI + 1 != p.length() && p.charAt(xI + 1) == '^')
        exponent = int(p.substring(xI + 2, endI));
      else
        exponent = 1;
      this.polyTerms.add(new Term(coeff, exponent));
      curI = endI + 1;
    }
  }

  Polynomial (ArrayList<Term> a) {
    this.polyTerms = a;
  }

  void printPolynomial () {
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

  String printPolynomialtoGUIScreen () {
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

  //======methods
  //adding
  Polynomial getSum(Polynomial other) {
    ArrayList<Term> minusOther = new ArrayList<Term>();
    for (Term i : other.polyTerms) {
      minusOther.add(new Term(-1*i.coeff, i.exponent));
    }
    return this.getDifference(new Polynomial(minusOther));
  }

  Polynomial getDifference(final Polynomial other) {

    final ArrayList<Term> otherTerms = other.polyTerms; 
    ArrayList<Term> difference = new ArrayList <Term>(); 
    if (otherTerms.size() == 0) {
      for (Term i : this.polyTerms) {
        difference.add(new Term(i.coeff, i.exponent));
      }
      return new Polynomial(difference);
    }
    if (this.polyTerms.size() == 0) {
      // negate other and return
      for (Term i : otherTerms) {
        difference.add(new Term(-1*i.coeff, i.exponent));
      }
      return new Polynomial(difference);
    }
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
    if (this.polyTerms.size() == 0) {
      ArrayList<Polynomial> result = new ArrayList<Polynomial>();
      result.add(new Polynomial (quotient));
      result.add(new Polynomial (dividend));
      return(result);
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
      if (dividend.size() == 0)
        break;
    }

    ArrayList<Polynomial> result = new ArrayList<Polynomial>();
    result.add(new Polynomial (quotient));
    result.add(new Polynomial (dividend));
    return(result);
  }
  Polynomial findDerivative() {
    ArrayList<Term>derivativeTerms= new ArrayList<Term>(); 
    for (Term i : this.polyTerms) {
      if (i.exponent == 0)
        continue;
      int newCoeff = (i.coeff*i.exponent);
      int newExp = i.exponent-1;
      derivativeTerms.add(new Term(newCoeff, newExp));
    }

    return (new Polynomial(derivativeTerms));
  }


  //graphing
  void graphPolynomial() {
    int xMin = -20;  //declare minimum and maximum x values and find xIncrement from GUI
    int xMax = 20;
    float xIncrement = 0.1;

    int numpoints = int((xMax-xMin)/xIncrement)+ 1;   // calculate number of points

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
      //print(xValues[i]);
      //print("\t");
      //print(yValues[i]);
      //println("");
    }
    // transform points from actual value to screen coordinates
    float xFactor = 20;
    float yFactor = 20;

    float [] ScreenX = new float [numpoints];
    float [] ScreenY = new float [numpoints];

    for (int n=0; n<numpoints; n++) {
      ScreenX[n] = 300+(xValues[n]*xFactor);
      ScreenY[n] = 300-(yValues[n]*yFactor);
    }

    for (int i=1; i<numpoints; i++) {
      line(ScreenX[i], ScreenY[i], ScreenX[i-1], ScreenY[i-1]);
      fill(0);
    }
    line(300, 0, 300, 600);
    fill(0);
    line(0, 300, 600, 300); 
    fill(0);
  }

  float getYforX(float x) {
    float result = 0;
    for (Term i : this.polyTerms) {
      result +=pow(x, i.exponent)*i.coeff;
    }
    return result;
  }

  float findOneApproxRoot(float xBegin, float xEnd) {
    float n = 8;
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
        println("find root=" + xI + " y=" + yI);
        return xI;
      }
      if ((yI < 0 && yValue > 0) || (yI > 0 && yValue < 0)) {
        return findOneApproxRoot(xI - increment, xI);
      }
    }
    //println("ACCURARY is too small. No root between " + xBegin + " " + xEnd);
    return xBegin;
  }

  //root approximater
  ArrayList<Float> findApproxRoots(float xBegin, float xEnd, int steps) {
    ArrayList<Float> result = new ArrayList<Float>();
    float increment = (xEnd - xBegin) / steps;
    while (true) {
      float yValue = getYforX(xBegin);
      // find first non-root
      while (true) {
        if (xBegin > xEnd) 
          return result;
        if (abs(yValue) < this.ACCURACY) {
          result.add(roundAny(new Float(xBegin), 3));
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
        float yI = getYforX(xI);
        if (abs(yI) < this.ACCURACY) {
          xBegin = xI;
          break;
        }
        if ((yI < 0 && yValue > 0) || (yI > 0 && yValue < 0)) {
          println("yI sign changed between " + (xI - increment) + " and " + xI + ", y is " + getYforX(xI - increment) + " and " + yI);
          float root = findOneApproxRoot(xI - increment, xI);
          result.add(roundAny(new Float(root), 3));
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
  ArrayList<Rational> findRationalRoots() {
    ArrayList<Term> p = this.polyTerms;
    ArrayList<Rational>result = new ArrayList<Rational>();
    int minExp = p.get(p.size()-1).exponent;
    if (minExp != 0) { //if d0 == 0
      result.add(new Rational(0, 1));
    }

    ArrayList<Integer> numerators, denominators;
    if (p.get(0).coeff < 0) {
      denominators = findFactors(-1*p.get(0).coeff);
    } else {
      denominators = findFactors(p.get(0).coeff);
    }
    if (p.get(p.size()-1).coeff < 0) {
      numerators = findFactors(-1 * p.get(p.size()-1).coeff);
    } else {
      numerators = findFactors(p.get(p.size()-1).coeff);
    }

    for (int n : numerators) {
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

  boolean isRoot(Rational r, int minusExp) {
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

  //find factors of non-negative integer argument
  public ArrayList<Integer>findFactors(int num) {
    ArrayList<Integer>result = new ArrayList<Integer>(); 
    for (int i = 1; i <= num; i++) {
      if (num%i == 0)
        result.add(i);
    }
    return (result);
  }
}
