# Variables - EXPONENTIAL DISTRIBUTION

par(mfrow = c(1, 2))
n <- 10000
lambda <- 0.1

# No Antiathetic Method

U <- runif(n)
EXDIST <- -log(1-U) / lambda 
x_grid <- seq(0, max(EXDIST), length.out = 1000)
Expo_pdf <- lambda * exp(-lambda * x_grid)

# Antiathetic Method 

U_half <- runif(n / 2)
X1 <- -log(1 - U_half) / lambda
X2 <- -log(U_half) / lambda
X_anti_mean <- (X1 + X2) / 2

# Find the Variance and the mean

EX_true <- 1 / lambda
est_no_anti <- mean(EXDIST)
est_anti <- mean(X_anti_mean)
var_no_anti <- var(EXDIST) / n
var_anti <- var(X_anti_mean) / (n / 2)


# Hist for Antiathetic
hist(c(X1, X2), breaks = 65, prob = TRUE,
     main = "Exponential with Antithetic",
     xlab = paste0("Mean = ", signif(est_anti, 5),
                   ", Variance = ", signif(var_anti, 5)))
lines(x_grid, Expo_pdf, col = "red", lwd = 2)

# Hist for No Antiathetic
hist(EXDIST, breaks = 65, prob = TRUE,
     main = "Exponential No Antithetic",
     xlab = paste0("Mean = ", signif(est_no_anti, 5),
                   ", Variance = ", signif(var_no_anti, 5)))
lines(x_grid, Expo_pdf, col = "red", lwd = 2)

# Show resaults
cat("True E[X]:", EX_true, "\n")
cat("Estimate (no antithetic):", est_no_anti, " | Variance:", var_no_anti, "\n")
cat("Estimate (antithetic):", est_anti, " | Variance:", var_anti, "\n")
cat("Variance reduction ratio (no_anti / anti):", var_no_anti / var_anti, "\n")
