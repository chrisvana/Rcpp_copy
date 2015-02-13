// Copyright 2015
// Author: Christopher Van Arsdale

#include <iostream>
#include <string>
#include <RInside.h>

using std::string;

namespace {
Rcpp::NumericMatrix CreateMatrix(const int n) {
  Rcpp::NumericMatrix M(n,n);
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      M(i,j) = i*10 + j; 
    }
  }
  return(M);
}

void CHECK_EQ(int a, int b) {
  if (a != b) {
    std::cerr << "CHECK_EQ(" << a << ", " << b << ") failed." << std::endl;
    exit(1);
  }
}
}  // anonymous namespace

int main(int argc, char* argv[]) {
  RInside R(argc, argv);
  R["M"] = CreateMatrix(4);
  Rcpp::NumericVector v = R.parseEval("colSums(M)");
  CHECK_EQ(4, v.size());
  CHECK_EQ(60, v[0]);
  CHECK_EQ(64, v[1]);
  CHECK_EQ(68, v[2]);
  CHECK_EQ(72, v[3]);

  std::cout << "PASSED" << std::endl;
  return 0;
}
