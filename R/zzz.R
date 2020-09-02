## for rJava

.onLoad <- function(libname, pkgname) {
  options(java.parameters="-Xrs")  ### so sun java does not kill R on CTRL-C
  rJava::.jpackage(pkgname, lib.loc = libname)
}

