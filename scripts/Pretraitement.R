# Chargement des packages
library(dplyr)

# Vérifier s’il y a des données manquantes
colSums(is.na(heart))
# On constate que toutes les colonnes sont à 0, il n'y a donc pas de données manquantes.

# 1. Vérification de valeurs aberrantes (exemple : RestingBP ou Cholesterol à 0 ?)
heart %>%
  select(RestingBP, Cholesterol) %>%
  summary()

# 2.Il existe des lignes où la pression ou le cholestérol est à 0. On les supprime car cela est impossible à étudier
# Parmi les patients avec Cholestérol = 0, x% ont une maladie cardiaque. 
# Cela pourrait refléter un problème de saisie ou une absence de mesure clinique.
# Ces données ont été exclues du modèle principal pour ne pas biaiser l’apprentissage
heart_clean <- heart %>%
  filter(RestingBP > 0, Cholesterol > 0)
nrow(heart)        # nombre initial de lignes
nrow(heart_clean)  # après nettoyage


# 3. Conversion des variables catégorielles en facteurs
heart_clean <- heart_clean %>%
  mutate(
    Sex = as.factor(Sex),
    ChestPainType = as.factor(ChestPainType),
    RestingECG = as.factor(RestingECG),
    ExerciseAngina = as.factor(ExerciseAngina),
    ST_Slope = as.factor(ST_Slope),
    HeartDisease = as.factor(HeartDisease)  # Très important : la cible doit être un facteur (une variable en 0 ou 1)
  )

# 4. Vérif rapide : structure finale des données
str(heart_clean)
heart_clean <- heart_clean %>%
  mutate(FastingBS = as.factor(FastingBS))

# 5. Sauvegarder le dataset nettoyé dans data/ pour l'utiliser plus tard
write.csv(heart_clean, "data/heart_clean.csv", row.names = FALSE)
