library(fastclime)

test_that("dantzig.generator works", {
  set.seed(42)
  L_dg = dantzig.generator(n = 50, d = 100, sparsity = 0.1)
  expect_equal(dim(L_dg$X0), c(50, 100))
  expect_equal(dim(L_dg$y), c(50, 1))
  expect_equal(sum(L_dg$BETA0), 0)
})

test_that("dantzig works", {
  set.seed(42)
  a = dantzig.generator(n = 200, d = 100, sparsity = 0.1)
  b = dantzig(a$X0, a$y, lambda = 0.1, nlambda = 100)
  expect_equal(dim(b$BETA0), c(100, 100))
  expect_equal(dim(b$BETA), c(100, 100))
  expect_length(b$lambdalist, 100)
})

test_that("dantzig.selector works", {
  set.seed(42)
  a = dantzig.generator(n = 200, d = 100, sparsity = 0.1)
  b = dantzig(a$X0, a$y, lambda = 0.1, nlambda = 100)
  c = dantzig.selector(b$lambdalist, b$BETA0, 15)
  expect_length(c, 100)
  expect_equal(sum(c), -1.53, tolerance = 1e-2)
})

test_that("fastclime.generator works for different graph types", {
  set.seed(42)

  pdf(file = NULL)

  L_fg1 = fastclime.generator(n = 100, d = 20)
  expect_equal(dim(L_fg1$data), c(100, 20))

  L_fg2 = fastclime.generator(graph = "band", g = 3)
  expect_equal(dim(L_fg2$data), c(200, 50))

  L_fg3 = fastclime.generator(vis = TRUE)
  expect_equal(dim(L_fg3$data), c(200, 50))

  L_fg4 = fastclime.generator(prob = 0.5, vis = TRUE)
  expect_equal(dim(L_fg4$data), c(200, 50))

  L_fg5 = fastclime.generator(graph = "hub", g = 6, vis = TRUE)
  expect_equal(dim(L_fg5$data), c(200, 50))

  L_fg6 = fastclime.generator(graph = "cluster", g = 8, vis = TRUE)
  expect_equal(dim(L_fg6$data), c(200, 50))

  dev.off()
})

test_that("fastclime and fastclime.selector work", {
  set.seed(42)
  L_fg1 = fastclime.generator(n = 100, d = 20)
  out1 = fastclime(L_fg1$data,0.1)
  out2 = fastclime.selector(out1$lambdamtx, out1$icovlist,0.2)

  expect_length(out1$lambdamtx, 380)
  expect_equal(dim(out1$icovlist[[1]]), c(20, 20))
  expect_equal(dim(out2$adaj), c(20, 20))

  out3 = fastclime(cor(L_fg1$data),0.1)
  out4 = fastclime.selector(out3$lambdamtx, out3$icovlist,0.2)
  expect_length(out3$lambdamtx, 500)
})

test_that("fastlp works", {
  A=matrix(c(-1,-1,0,1,-2,1),nrow=3)
  b_lp=c(-1,-2,1)
  c_lp=c(-2,3)
  res_fastlp = fastlp(c_lp,A,b_lp)

  expect_length(res_fastlp, 2)
  expect_equal(res_fastlp, c(2, 1), tolerance = 1e-6)
})

test_that("paralp works", {
  A=matrix(c(-1,-1,0,1,-2,1),nrow=3)
  b_lp=c(-1,-2,1)
  c_lp=c(-2,3)
  b_bar=c(1,1,1)
  c_bar=c(1,1)
  res_paralp = paralp(c_lp,A,b_lp,c_bar,b_bar)

  expect_length(res_paralp, 2)
  expect_equal(res_paralp, c(4/3, 1/3), tolerance = 1e-6)
})

test_that("stockdata works", {
  data(stockdata)
  expect_equal(dim(stockdata$data), c(1258, 452))
  expect_length(stockdata$info, 1356)
})
