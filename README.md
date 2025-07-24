# 🔍 Prédiction des maladies cardiaques par régression logistique

## 🎯 Objectif du projet

Ce projet a pour but de construire un modèle de régression logistique permettant de **prédire la présence d'une maladie cardiaque** à partir de données médicales issues d’un jeu de données open-source. L’objectif est double :

1. Identifier les **principaux facteurs de risque** associés à la maladie cardiaque ;
2. Évaluer la **capacité prédictive** d’un modèle statistique simple, interprétable et transparent.

Ce projet a été réalisé dans le cadre d’un cours de modélisation prédictive, avec une attention particulière portée à la rigueur des étapes d’analyse, à l’interprétation des résultats et à la reproductibilité du code.

---

## 🧠 Données utilisées

Le jeu de données utilisé provient d’un dataset classique sur les maladies cardiaques. Il contient **746 observations** et **12 variables** médicales (âge, tension, cholestérol, douleur thoracique, électrocardiogramme, etc.).

La variable cible (`HeartDisease`) est binaire :  
- `1` : présence d’une maladie cardiaque diagnostiquée,  
- `0` : absence de maladie cardiaque.

---

## 🛠️ Étapes du projet

### 1. **Nettoyage et préparation des données**
- Suppression des valeurs manquantes ;
- Conversion des variables qualitatives (`Sex`, `ChestPainType`, etc.) en **facteurs** pour la modélisation ;
- Vérification de la distribution des variables et de la variable cible.

### 2. **Séparation en jeu d’apprentissage et jeu de test**
- 70 % des données pour l’entraînement (`train_data`) ;
- 30 % pour l’évaluation finale (`test_data`) ;
- Utilisation d’un `set.seed()` pour assurer la reproductibilité.

### 3. **Construction du modèle de régression logistique**
- Utilisation de la fonction `glm()` avec `family = binomial` ;
- Modèle initial contenant **toutes les variables explicatives** ;
- Visualisation des coefficients et de leur significativité avec `summary(model)`.

### 4. **Évaluation des performances**
- Prédictions effectuées sur le jeu de test ;
- Construction de **matrices de confusion** pour différents seuils (0.5, 0.8) ;
- Calcul des indicateurs clés :
  - Précision (accuracy)
  - Sensibilité (recall)
  - Spécificité
  - Valeur prédictive positive (précision)
  - Balanced Accuracy

### 5. **Interprétation des résultats**
- Analyse des coefficients : certaines variables comme le sexe, la douleur thoracique, l’angine à l’effort ou la pente ST ont un **effet significatif** ;
- Le modèle est **interprétable** et permet de comprendre les **facteurs de risque**.

---

## 📊 Résultats principaux

### ✔️ Modèle avec seuil 0.5

| Indicateur         | Valeur      |
|--------------------|-------------|
| Accuracy           | **88.3 %**  |
| Sensibilité        | 80.2 %      |
| Spécificité        | 95.7 %      |
| Précision (PPV)    | 94.4 %      |
| Kappa              | 0.76        |

### 🔁 Test avec seuil à 0.8

| Indicateur         | Valeur      |
|--------------------|-------------|
| Accuracy           | 78.9 %      |
| Sensibilité        | 58.5 %      |
| Spécificité        | 97.4 %      |
| Précision (PPV)    | 95.3 %      |

> ⚠️ En augmentant le seuil, on réduit les faux positifs (spécificité) mais on **manque davantage de malades** (sensibilité chute). Cela montre l'importance de **choisir un seuil en fonction du contexte médical** : vaut-il mieux éviter les faux positifs, ou détecter un maximum de cas même si cela génère de fausses alertes ?

---

## 🧩 Interprétations et réflexions

- Les résultats sont cohérents avec ce qu’on attend dans un cadre médical :
  - Le **sexe masculin** augmente significativement le risque ;
  - Certaines formes de **douleur thoracique** sont très discriminantes ;
  - Le **ST Slope** ou l’**Oldpeak** sont des indicateurs ECG puissants.
- Le modèle logistique, bien que simple, offre une **bonne précision globale**, est **facile à interpréter** et permet d’identifier les **facteurs clés** sans boîte noire.

---

## 🔚 Conclusion

Ce projet démontre qu’un **modèle de régression logistique bien préparé** permet de détecter les cas de maladies cardiaques avec une précision satisfaisante. Il offre un **compromis entre performance, transparence et interprétabilité**, ce qui en fait un outil pertinent pour un usage médical exploratoire ou en complément d’un diagnostic.

> 📌 **Axes possibles d'amélioration :**
> - Comparaison avec d’autres modèles : arbres, forêts aléatoires, SVM, etc.  
> - Validation croisée pour réduire le risque d’overfitting.  
> - Ajustement du seuil à l’aide de la courbe ROC et de l’AUC.  
> - Utilisation de techniques de sélection de variables ou d’interactions.

---

## 📁 Structure du projet

```bash
📦 heart-disease-logit
├── data/
│   └── heart.csv               # Jeu de données brut
├── src/
│   └── modelisation.R          # Script complet R (nettoyage, modèle, évaluation)
├── README.md                   # Ce fichier
└── plots/
    └── roc_curve.png           # (optionnel) Graphique ROC si généré
