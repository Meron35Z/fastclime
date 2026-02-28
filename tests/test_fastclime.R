library(fastclime)

# man/dantzig.Rd
a = dantzig.generator(n = 200, d = 100, sparsity = 0.1)
b = dantzig(a$X0, a$y, lambda = 0.1, nlambda = 100)

# man/dantzig.generator.Rd
L = dantzig.generator(n = 50, d = 100, sparsity = 0.1)

# man/dantzig.selector.Rd
a = dantzig.generator(n = 200, d = 100, sparsity = 0.1)
b = dantzig(a$X0, a$y, lambda = 0.1, nlambda = 100)
c = dantzig.selector(b$lambdalist, b$BETA0, 15)

# man/fastclime.Rd
L = fastclime.generator(n = 100, d = 20)
out1 = fastclime(L$data,0.1)
out2 = fastclime.selector(out1$lambdamtx, out1$icovlist,0.2)

out1 = fastclime(cor(L$data),0.1)
out2 = fastclime.selector(out1$lambdamtx, out1$icovlist,0.2)

# man/fastclime.generator.Rd
L = fastclime.generator(graph = "band", g = 3)
L = fastclime.generator(vis = TRUE)
L = fastclime.generator(prob = 0.5, vis = TRUE)
L = fastclime.generator(graph = "hub", g = 6, vis = TRUE)
L = fastclime.generator(graph = "cluster", g = 8, vis = TRUE)

# man/fastclime.selector.Rd
L = fastclime.generator(n = 100, d = 20)
out1 = fastclime(L$data,0.1)
out2 = fastclime.selector(out1$lambdamtx, out1$icovlist,0.2)

# man/fastlp.Rd
A=matrix(c(-1,-1,0,1,-2,1),nrow=3)
b=c(-1,-2,1)
c=c(-2,3)
fastlp(c,A,b)

# man/paralp.Rd
A=matrix(c(-1,-1,0,1,-2,1),nrow=3)
b=c(-1,-2,1)
c=c(-2,3)
b_bar=c(1,1,1)
c_bar=c(1,1)
paralp(c,A,b,c_bar,b_bar)

# man/stockdata.Rd
data(stockdata)
