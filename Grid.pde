class Grid {
  // Attributes
  float t;
  PVector v;
  float rho;
  
  // Constructors
  Grid(float t1) {
    t = t1;
  }
  Grid(float t1, PVector v1) {
    t = t1;
    v = v1;
  }
  Grid(float t1, PVector v1, float rho1) {
    t = t1;
    v = v1;
    rho = rho1;
  }
  
  // Setters
  void st(float t1) {
    t = t1;
  }
  void sv(PVector v1) {
    v = v1;
  }
  void sr(float rho1) {
    rho = rho1;
  }
  
  // Getters
  float gt() {
    return t;
  }
  PVector gv() {
    return v;
  }
  float gr() {
    return rho;
  }
}
