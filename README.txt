# Addon GMod - Template de développement

## Description

Cet addon est un **template** destiné aux développeurs Garry's Mod.  
Il permet de **créer rapidement un nouvel addon** grâce à des fonctions, extraits de code et structures déjà prêtes à l’emploi.

Il est conçu pour être **copié, personnalisé ou intégré** facilement à n’importe quel projet.

---

### 🧰 Contenu du template :

- 📁 **Fichier langue** :
  - Permet d'ajouter facilement plusieurs traductions (Français / Anglais inclus de base).
- ⚙️ **2 fichiers de configuration** :
  - `config_general.lua` : configuration générale de l’addon.
  - `config_audio.lua` : liste des fichiers audio à gérer dans l’addon.
- 🎨 **Dossier "ui"** :
  - Contient toutes les ressources graphiques utilisées dans l’interface (images, icônes, etc.).
- 📦 **Fichier `downloads.lua`** :
  - Gère le téléchargement automatique des fichiers ressources par les clients (⚠️ à mettre à jour avec chaque ajout de fichiers `.png`, `.wav`, etc.).

---

## Description (English)

This addon is a **development template** for Garry's Mod addon creators.  
It provides a ready-to-use structure with **predefined functions, code snippets, and config files** to help you start building addons faster.

The template is designed to be **easily copied, customized, and reused** in any project.

---

### 🧰 Template content:

- 📁 **Language file**:
  - Easy localization support (French and English included).
- ⚙️ **2 config files**:
  - `config_general.lua`: global configuration.
  - `config_audio.lua`: handles custom audio file setup.
- 🎨 **"ui" folder**:
  - Stores all UI resources (images, icons, etc.).
- 📦 **`downloads.lua`**:
  - Automatically handles client download of required resources (⚠️ update it when adding new `.png`, `.wav`, etc. files).

---

## 📝 Instructions

1. Clone ou téléchargez le dossier dans `garrysmod/addons/`.
2. Renommez le dossier et les fichiers selon le nom de votre addon.
3. Modifiez les fichiers de langue, config et UI selon vos besoins.
4. N’oubliez pas de **mettre à jour `downloads.lua`** quand vous ajoutez des fichiers ressources.

---

## 📜 Licence / License

Ce template est distribué sous une licence **libre non-commerciale** :

- ✅ Utilisation, modification et partage autorisés.
- ❌ Interdiction d’usage commercial ou monétisé.
- 🙏 Merci de créditer l’auteur original si vous le redistribuez.

This template is released under a **non-commercial open license**:

- ✅ You may use, modify, and share it freely.
- ❌ Commercial or monetized use is strictly forbidden.
- 🙏 Please credit the original author if you redistribute it.

---

## ✉️ Auteur / Author

Créé par **[Nyrell]**  
Merci d’utiliser ce template et bon développement ! 👨‍💻🚀
