code <- "
  SEXP res;
  int nprotect = 0, nx, ny, nz, x, y;
  PROTECT(res = Rf_duplicate(a)); nprotect++;
  nx = INTEGER(GET_DIM(a))[0];
  ny = INTEGER(GET_DIM(a))[1];
  nz = INTEGER(GET_DIM(a))[2];
  double sigma2 = REAL(s)[0] * REAL(s)[0], d2 ;
  double cx = REAL(centre)[0], cy = REAL(centre)[1], *data, *rdata;
  for (int im = 0; im < nz; im++) {
  data = &(REAL(a)[im*nx*ny]); rdata = &(REAL(res)[im*nx*ny]);
  for (x = 0; x < nx; x++)
  for (y = 0; y < ny; y++) {
  d2 = (x-cx)*(x-cx) + (y-cy)*(y-cy);
  rdata[x + y*nx] = data[x + y*nx] * exp(-d2/sigma2);
  }
}
UNPROTECT(nprotect);
return res;
"