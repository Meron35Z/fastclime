library(fastclime)

set.seed(42)

# man/dantzig.generator.Rd
L_dg = dantzig.generator(n = 50, d = 100, sparsity = 0.1)
stopifnot(
  all(dim(L_dg$X0) == c(50, 100)),
  all(dim(L_dg$y) == c(50, 1)),
  sum(L_dg$BETA0) == 0
)

# man/dantzig.Rd
a = dantzig.generator(n = 200, d = 100, sparsity = 0.1)
b = dantzig(a$X0, a$y, lambda = 0.1, nlambda = 100)
stopifnot(
  all(dim(b$BETA0) == c(100, 100)),
  all(dim(b$BETA) == c(100, 100)),
  length(b$lambdalist) == 100
)

# man/dantzig.selector.Rd
c = dantzig.selector(b$lambdalist, b$BETA0, 15)
stopifnot(
  length(c) == 100,
  # We check the sum using all.equal to handle minor precision differences
  isTRUE(all.equal(sum(c), -2.338258, tolerance = 1e-4))
)

# man/fastclime.generator.Rd
pdf(file = NULL)
L_fg1 = fastclime.generator(n = 100, d = 20)
stopifnot(all(dim(L_fg1$data) == c(100, 20)))

L_fg2 = fastclime.generator(graph = "band", g = 3)
stopifnot(all(dim(L_fg2$data) == c(200, 50)))

L_fg3 = fastclime.generator(vis = TRUE)
stopifnot(all(dim(L_fg3$data) == c(200, 50)))

L_fg4 = fastclime.generator(prob = 0.5, vis = TRUE)
stopifnot(all(dim(L_fg4$data) == c(200, 50)))

L_fg5 = fastclime.generator(graph = "hub", g = 6, vis = TRUE)
stopifnot(all(dim(L_fg5$data) == c(200, 50)))

L_fg6 = fastclime.generator(graph = "cluster", g = 8, vis = TRUE)
stopifnot(all(dim(L_fg6$data) == c(200, 50)))
dev.off()

# man/fastclime.Rd & man/fastclime.selector.Rd
out1 = fastclime(L_fg1$data,0.1)
out2 = fastclime.selector(out1$lambdamtx, out1$icovlist,0.2)
stopifnot(
  length(out1$lambdamtx) == 320,
  all(dim(out1$icovlist[[1]]) == c(20, 20)),
  all(dim(out2$adaj) == c(20, 20))
)

out3 = fastclime(cor(L_fg1$data),0.1)
out4 = fastclime.selector(out3$lambdamtx, out3$icovlist,0.2)
stopifnot(
  length(out3$lambdamtx) == 340
)

# man/fastlp.Rd
A=matrix(c(-1,-1,0,1,-2,1),nrow=3)
b_lp=c(-1,-2,1)
c_lp=c(-2,3)
res_fastlp = fastlp(c_lp,A,b_lp)
stopifnot(
  length(res_fastlp) == 2,
  isTRUE(all.equal(res_fastlp, c(2, 1), tolerance = 1e-6))
)

# man/paralp.Rd
b_bar=c(1,1,1)
c_bar=c(1,1)
res_paralp = paralp(c_lp,A,b_lp,c_bar,b_bar)
stopifnot(
  length(res_paralp) == 2,
  isTRUE(all.equal(res_paralp, c(4/3, 1/3), tolerance = 1e-6))
)

# man/stockdata.Rd
data(stockdata)
stopifnot(
  all(dim(stockdata$data) == c(1258, 452)),
  length(stockdata$info) == 1356
)

print("All tests passed.")
