// NOTE:
// For this to work, you need R installed with R packages Rcpp and RInside.
// This is not a standalone library (unfortunately).
[
 { "config": {
    "component": "rcpp",
    "licenses": [ "http://www.apache.org/licenses/LICENSE-2.0" ]
 } },

 { "plugin": {
    "name": "rcpp_loader",
    "command": "$SRC_DIR/rcpp_loader.sh"
 } },

 { "rcpp_loader": {
    "name": "rcpp_loader_lib"
 } },

 { "cc_library": {
    "name": "rcpp",
    "dependencies": [ ":rcpp_loader_lib" ]
 } },

 { "cc_test": {
    "name": "rcpp_test",
    "cc_sources": [ "rcpp_test.cc" ],
    "dependencies": [ ":rcpp" ]
 } }
]