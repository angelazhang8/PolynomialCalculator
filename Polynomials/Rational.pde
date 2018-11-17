class Rational {
  int n, d;
  Rational(int n, int d) {
    this.n = n;
    this.d = d;
  }
  void add(Rational other) {
    int tempD = this.d * other.d;
    int tempN = this.n*other.d + this.d*other.n;
    int g = gcd(tempD, tempN);
    this.n = tempN/g;
    this.d = tempD/g;
  }

  void multiply(Rational other) {
    int tempN = this.n*other.n;
    int tempD = this.d*other.d;
    int g = gcd(tempD, tempN);
    this.n = tempN/g;
    this.d = tempD/g;
  }

  int gcd(int a, int b) {
    while (b != 0) {
      int r = a % b;
      a = b;
      b = r;
    }
    return a;
  }
}
