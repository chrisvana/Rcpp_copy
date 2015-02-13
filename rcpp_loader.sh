# Copyright 2015
# Author: Christopher Van Arsdale
#
# Modified from RInside's inst/examples/standard/Makefile.

## include headers and libraries for R 
RCPPFLAGS=$(R CMD config --cppflags)
RLDFLAGS=$(R CMD config --ldflags)
RBLAS=$(R CMD config BLAS_LIBS)
RLAPACK=$(R CMD config LAPACK_LIBS)

## include headers and libraries for Rcpp interface classes
## note that RCPPLIBS will be empty with Rcpp (>= 0.11.0) and can be omitted
RCPPINCL=$(echo 'Rcpp:::CxxFlags()' | R --vanilla --slave)
RCPPLIBS=$(echo 'Rcpp:::LdFlags()'  | R --vanilla --slave)

## include headers and libraries for RInside embedding classes
RINSIDEINCL=$(echo 'RInside:::CxxFlags()' | R --vanilla --slave)
RINSIDELIBS=$(echo 'RInside:::LdFlags()'  | R --vanilla --slave)

## compiler etc settings used in default make rules
CXXFLAGS="${RCPPFLAGS} ${RCPPINCL} ${RINSIDEINCL}"
# TODO: CXXFLAGS="$(R CMD config CXXFLAGS)"
LDFLAGS="${RLDFLAGS} ${RRPATH} ${RBLAS} ${RLAPACK}"
LDLIBS="${RCPPLIBS} ${RINSIDELIBS}"

split_flags() {
    echo '["'$(echo $@ | sed 's/ -/", "-/g')'"]'
}

echo '
{ "cc_library": {
    "name": "rcpp_loader_lib",
    "header_compile_args": '$(split_flags $CXXFLAGS)',
    "cc_linker_args": '$(split_flags $LDFLAGS)',
    "cc_objects": '$(split_flags $LDLIBS)'
} }
'

exit 0
