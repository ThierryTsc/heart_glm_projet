install.packages(c("dplyr", "ggplot2", "caret", "MASS", "pROC", "glmnet", "car", "readr"))
# Importation des données
library(readr)
heart <- read_csv("data/heart.csv")
glimpse(heart)
library(dplyr)

# Visualisation rapide des données
summary(heart)

# Barplot pour voir la distribution de la variable cible (maladie cardiaque)
# 0 pour les patients non-atteints d'une maladie cardiaque et 1 pour ceux atteints
library(ggplot2)

# 1. Distribution de la variable cible (HeartDisease)
# On regarde combien de patients ont ou non une maladie cardiaque
ggplot(heart, aes(x = factor(HeartDisease))) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Répartition des cas de maladie cardiaque",
    x = "Présence de maladie cardiaque (0 = non, 1 = oui)",
    y = "Nombre de patients"
  ) +
  theme_minimal()

# 2. Distribution de l'âge selon la maladie cardiaque
# On observe la relation entre l'âge et le fait d'avoir une maladie
ggplot(heart, aes(x = Age, fill = factor(HeartDisease))) +
  geom_histogram(binwidth = 5, position = "dodge") +
  labs(
    title = "Répartition de l'âge selon la présence de maladie cardiaque",
    x = "Âge", fill = "Maladie cardiaque"
  ) +
  theme_minimal()

# 3. Distribution du cholestérol selon la maladie cardiaque
ggplot(heart, aes(x = Cholesterol, fill = factor(HeartDisease))) +
  geom_histogram(binwidth = 20, position = "dodge") +
  labs(
    title = "Cholestérol et maladie cardiaque",
    x = "Taux de cholestérol", fill = "Maladie cardiaque"
  ) +
  theme_minimal()

# 4. Distribution de la fréquence cardiaque maximale (MaxHR)
ggplot(heart, aes(x = MaxHR, fill = factor(HeartDisease))) +
  geom_histogram(binwidth = 10, position = "dodge") +
  labs(
    title = "Fréquence cardiaque max selon la maladie",
    x = "MaxHR", fill = "Maladie cardiaque"
  ) +
  theme_minimal()

# 5. Sexe et maladie cardiaque
ggplot(heart, aes(x = Sex, fill = factor(HeartDisease))) +
  geom_bar(position = "fill") +
  labs(
    title = "Sexe vs maladie cardiaque",
    x = "Sexe", y = "Proportion", fill = "Maladie cardiaque"
  ) +
  theme_minimal()