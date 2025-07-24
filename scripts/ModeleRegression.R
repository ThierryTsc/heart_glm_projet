# Charger le package pour division aléatoire
library(caret)
set.seed(123)  # pour reproductibilité

# Création des ensembles de train et de test (70% train / 30% test)
split <- createDataPartition(heart_clean$HeartDisease, p = 0.7, list = FALSE)

# Séparation des données
train_data <- heart_clean[split, ]
test_data  <- heart_clean[-split, ]

# Vérification
nrow(train_data)  # A 523 données
nrow(test_data)   # A 223 données

# Modèle initial : toutes les variables
model_logit <- glm(HeartDisease ~ ., data = train_data, family = binomial)

# Résumé du modèle
summary(model_logit)

# On entraîne un modèle de régression logistique (GLM) pour prédire la probabilité 
# qu'une personne ait une maladie cardiaque (HeartDisease), en utilisant toutes les 
# autres variables disponibles comme prédicteurs.

# Le modèle est ajusté avec la fonction glm(), en précisant :
#   - la formule HeartDisease ~ . (toutes les variables explicatives)
#   - la famille binomiale (car la variable cible est binaire : 0 ou 1)

# Le summary(model_logit) affiche :
#   - les coefficients estimés pour chaque variable ou modalité (log-odds)
#   - leur écart-type, valeur z et p-value pour tester leur significativité

# Interprétation des résultats :
#   - Un coefficient positif = augmentation du risque de maladie cardiaque
#   - Un coefficient négatif = effet protecteur (réduction du risque)
#   - Les p-values < 0.05 indiquent que l'effet est significatif statistiquement

# Résultats clés :
#   - Être un homme (SexM) est fortement associé à un risque accru (**très significatif**)
#   - Certains types de douleur thoracique (ChestPainType) sont protecteurs (notamment ATA, NAP, TA)
#   - Oldpeak (dépression du segment ST) et l'angine d'effort (ExerciseAnginaY) sont aussi des facteurs de risque
#   - En revanche, certaines variables comme RestingBP, Cholesterol, MaxHR, etc. n'ont pas montré d'effet significatif

# Qualité du modèle :
#   - Null deviance = modèle sans prédicteurs
#   - Residual deviance = notre modèle actuel
#   - Plus cette dernière est faible, mieux le modèle explique les données
#   - L’AIC (Akaike Information Criterion) permet aussi de comparer différents modèles (plus c’est bas, mieux c’est)

# Pour une meilleure interprétation, on peut transformer les coefficients en odds ratios avec :
#     exp(coef(model_logit))

# Prédictions sur le jeu de test (probabilités)
probs <- predict(model_logit, newdata = test_data, type = "response")

# Conversion en classe binaire (0 ou 1)
preds <- ifelse(probs > 0.5, 1, 0)

# Confusion matrix
confusionMatrix(as.factor(preds), test_data$HeartDisease, positive = "1")


# ÉVALUATION DU MODÈLE SUR LES DONNÉES TEST

# Étape 1 : Prédictions
# On utilise le modèle entraîné pour prédire la probabilité d'avoir une maladie cardiaque
# pour chaque individu du jeu de test. Le paramètre type = "response" renvoie des probabilités (entre 0 et 1).

# Étape 2 : Seuil de décision
# On convertit les probabilités en classes binaires : 
#     - si proba > 0.5 → prédiction = 1 (malade)
#     - sinon → prédiction = 0 (non malade)

# tape 3 : Matrice de confusion
# On compare les prédictions aux vraies valeurs (HeartDisease dans test_data).
# La confusionMatrix nous donne plusieurs métriques importantes :

# - Accuracy (précision globale) : 88.34 % → bon score !
# - Sensitivity (vrai positif) : 80.2 % → le modèle détecte bien les malades
# - Specificity (vrai négatif) : 95.7 % → il identifie très bien les non-malades
# - Kappa : 0.76 → accord réel entre prédictions et réalité, bien au-dessus de l'aléatoire
# - McNemar's test : p < 0.01 → indique une petite asymétrie dans les erreurs (faux positifs/fausses négatifs)

# Conclusion :
# Le modèle a de bonnes performances, avec un très bon équilibre entre sensibilité et spécificité.
# On peut le considérer comme fiable pour une première version, surtout avec aussi peu de variables très prédictives.


