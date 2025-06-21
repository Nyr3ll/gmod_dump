# Addon GMod - Bones manipulation

## Description

Cet addon permet de **modifier dynamiquement les "os" du joueur** pour créer des effets visuels amusants ou étranges.  
À l'origine conçu comme un système de **potions visuelles**, il est facilement réutilisable dans d'autres contextes.

---

### 🧪 Fonctionnalités principales :

- 📦 Fichier de configuration `effects.lua` :
  - Définit les **effets visuels appliqués sur les os** des modèles joueurs.
- 🦴 Fichier `bones.lua` :
  - Regroupe une **liste d’os utiles** pour être manipulés dans les effets.
- 🌐 Fichier `config.lua` :
  - Permet de **changer la langue** de l'addon.
  - Gère une **whitelist de rôles** autorisés à utiliser les commandes.

---

### 💬 Commandes de chat :

- `!applybonemanip` → applique un effet prédéfini (hardcodé mais modifiable dans le fichier "lua\autorun\nap_ad_hooks.lua" vers la ligne ~143 toutes les infos en commentaire dans le code).
- `!model` → affiche le modèle de l'entité regardée.
- `!bones` → liste tous les os du modèle actuel avec leurs noms.
- `!material` → affiche le matériel de l'entité regardée.
- `!waila` → affiche la classe de l’entité regardée.

---

## Description (English)

This addon allows you to **dynamically manipulate player model bones** to create unique or strange visual effects.  
Originally designed as a **visual potion effect system**, it's reusable in any context involving model deformation.

---

### 🧪 Main Features:

- 📦 `effects.lua`:
  - Defines **visual effects** applied to player bones.
- 🦴 `bones.lua`:
  - Contains a list of **useful bones** for use in the effects file.
- 🌐 `config.lua`:
  - Used to **set the addon’s language**.
  - Contains a **role whitelist** to control command access.

---

### 💬 Chat Commands:

- `!applybonemanip` → applies a hardcoded bone manipulation effect to yourself (customizable in the file "lua\autorun\nap_ad_hooks.lua" line ~143 all info in code comment).
- `!model` → returns the model of the entity you're looking at.
- `!bones` → lists all bones of the current model with their names.
- `!material` → returns the material of the entity you're looking at.
- `!waila` → displays the class of the entity you're looking at.

---

## 📜 Licence / License

Ce projet est distribué sous une licence **libre non-commerciale** :

- ✅ Vous pouvez **utiliser, modifier et partager** librement cet addon.
- ❌ **Usage commercial ou monétisation interdits**.
- 🙏 **Créditez l’auteur original** dans toute version redistribuée ou modifiée.

This project is released under a **non-commercial open license**:

- ✅ You are free to **use, modify, and share** this addon.
- ❌ **Commercial or monetized use is strictly prohibited**.
- 🙏 **Please credit the original author** in any modified or redistributed version.

---

## 📁 Installation

1. Téléchargez les fichiers ou clonez le dépôt.
2. Placez le dossier dans `garrysmod/addons/`.
3. Modifiez les fichiers de config dans `lua/nap_alchemist_disaster/` selon vos besoins.

---

## ✉️ Auteur / Author

Créé par **[Nyrell]**  
Merci d’utiliser cet addon et de respecter sa licence ✌️
