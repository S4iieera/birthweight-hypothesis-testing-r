# Hypothesis testing on a birthweight dataset
# Author: Sameer Ali
# Originally produced as university coursework (statistical techniques in R)

# Load necessary libraries
library(MASS)    # For birthwt dataset
library(dplyr)   # For data manipulation
library(tibble)  # For tidy data handling
library(ggplot2) # For visualization

# Load dataset (regenerate it with generate_dataset.R if missing)
dataset_filename <- "data/birthweight.csv"
birthwt_data <- read.csv(dataset_filename)

# Display dataset structure
dim(birthwt_data)
str(birthwt_data)

# Convert necessary columns to factors
birthwt_data <- birthwt_data %>%
  rename(mother.smokes = factorC) %>%
  mutate(
    mother.smokes = as.factor(mother.smokes),
    birthwt.below.2500 = as.factor(birthwt.below.2500),
    hypertension = as.factor(hypertension),
    uterine.irr = as.factor(uterine.irr),
    factorA = as.factor(factorA)
  )

# Summary of the dataset
summary(birthwt_data)

# Boxplot: Birth Weight by Smoking Status
ggplot(birthwt_data, aes(x = mother.smokes, y = birthwt.grams, fill = mother.smokes)) +
  geom_boxplot() +
  labs(title = "Birth Weight by Smoking Status", x = "Smoking Status", y = "Birth Weight (grams)")

# Compute summary statistics for birth weight by smoking status
smoke_stats <- birthwt_data %>%
  group_by(mother.smokes) %>%
  summarise(
    Mean = mean(birthwt.grams, na.rm = TRUE),
    SD = sd(birthwt.grams, na.rm = TRUE),
    SE = SD / sqrt(n())
  )
print(smoke_stats)

# Perform independent t-test
t_test_result <- t.test(birthwt.grams ~ mother.smokes, data = birthwt_data)
print(t_test_result)

# Normality checks: QQ Plot and Histogram
qqnorm(birthwt_data$birthwt.grams, main="QQ Plot of Birth Weight")
qqline(birthwt_data$birthwt.grams, col="red", lwd=2)
hist(birthwt_data$birthwt.grams, main="Histogram of Birth Weight", xlab="Birth Weight (grams)", col="blue")

# Contingency table for chi-square test
contingency_table <- table(birthwt_data$birthwt.below.2500, birthwt_data$mother.smokes)
print(contingency_table)

# Chi-Square Test
chi_sq_test <- chisq.test(contingency_table)
print(chi_sq_test)

# Fisher’s Exact Test
fisher_test <- fisher.test(contingency_table)
print(fisher_test)

# Simulated t-test with no effect
set.seed(123)
control <- rnorm(50, mean = 100, sd = 15)
treatment <- rnorm(50, mean = 100, sd = 15)
simulated_data <- data.frame(Group = rep(c("Control", "Treatment"), each = 50), Value = c(control, treatment))
t_test_sim <- t.test(Value ~ Group, data = simulated_data)
print(t_test_sim)

# Simulated t-test with treatment effect
set.seed(123)
p_values <- replicate(10000, {
  control <- rnorm(50, mean = 100, sd = 15)
  treatment <- rnorm(50, mean = 110, sd = 15)
  t.test(control, treatment)$p.value
})

# Histogram of p-values
hist(p_values, breaks = 30, main="Distribution of P-Values", col="red")
