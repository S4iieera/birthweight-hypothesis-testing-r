# Load necessary libraries
if (!require(MASS)) install.packages("MASS", dependencies=TRUE)
if (!require(dplyr)) install.packages("dplyr", dependencies=TRUE)
if (!require(tibble)) install.packages("tibble", dependencies=TRUE)

library(MASS)    # For birthwt dataset
library(dplyr)   # For data manipulation
library(tibble)  # For tidy data handling

# Step 1: Set a seed so the generated subset is reproducible
seed_value <- 42

# Step 2: Load and clean the birthwt dataset
set.seed(seed_value)  # Ensure results are reproducible
birthwt <- as_tibble(MASS::birthwt)

# Rename variables for clarity
birthwt <- birthwt %>%
  rename(
    birthwt.below.2500 = low,
    mother.age = age,
    mother.weight = lwt,
    mother.smokes = smoke,
    previous.prem.labor = ptl,
    hypertension = ht,
    uterine.irr = ui,
    physician.visits = ftv,
    birthwt.grams = bwt
  )

# Convert categorical variables to factors with meaningful labels
birthwt <- birthwt %>%
  mutate(
    race = recode_factor(race, `1` = "white", `2` = "black", `3` = "other"),
    mother.smokes = recode_factor(mother.smokes, `0` = "no", `1` = "yes"),
    hypertension = recode_factor(hypertension, `0` = "no", `1` = "yes"),
    uterine.irr = recode_factor(uterine.irr, `0` = "no", `1` = "yes"),
    birthwt.below.2500 = recode_factor(birthwt.below.2500, `0` = "no", `1` = "yes")
  )

# 📌 Step 3: Randomize the dataset to ensure unique student datasets

# (A) Randomly sample a subset of 100 rows for each student
birthwt_sample <- birthwt %>%
  sample_n(100, replace = FALSE)

# (B) Add slight random noise to birth weight values
birthwt_sample <- birthwt_sample %>%
  mutate(birthwt.grams = birthwt.grams + rnorm(n(), mean = 0, sd = 20))

# (C) Shuffle the smoking status to prevent direct comparison
birthwt_sample <- birthwt_sample %>%
  mutate(mother.smokes = sample(mother.smokes))

# (D) Randomize variable names for some numerical columns
random_labels <- sample(c("factorA", "factorB", "factorC"))
colnames(birthwt_sample)[c(3, 4, 5)] <- random_labels

# 📌 Step 4: Save the dataset
write.csv(birthwt_sample, file = "data/birthweight.csv", row.names = FALSE)

# 📌 Step 5: Display confirmation message
cat("\nDataset saved as: data/birthweight.csv\n")

# 📌 Step 6: Show the first few rows
print(head(birthwt_sample))
