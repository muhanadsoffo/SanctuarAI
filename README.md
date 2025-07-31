# 📱 SanctuarAI

SanctuarAI is an intelligent emotional well-being app that helps users track, analyze, and reflect on their relationships and emotional interactions through the power of AI.

## ✨ Features

- 🧠 **AI-Powered Insights**: Automatically generate summaries and relationship advice using GPT based on your journaled interactions
- 👤 **People Tracking**: Add people you interact with and record entries about how those interactions made you feel
- 📊 **Emotional Trends**: Get weekly summaries that analyze your mental health state based on emotional patterns
- 🖼️ **Profile & Picture Support**: Add and update profile pictures for yourself and others using Cloudinary
- 🔐 **User Authentication**: Firebase-based login, sign-up, and user profile creation
- 📥 **Offline Caching**: Uses Firestore's local persistence to allow smooth offline access to your data

## 🔧 Technologies Used

- **Flutter** (Frontend)
- **Firebase Auth** (Authentication)
- **Firestore** (Realtime database)
- **Cloudinary** (Image hosting)
- **OpenRouter GPT-3.5 Turbo** (AI summaries)

## 🧠 How It Works

1. Users add entries about their interactions with people
2. AI processes these interactions and returns summaries and advice per person
3. A collective AI summary is generated to reflect the user's overall mental state
4. All data is stored securely in Firestore, and profile images are hosted on Cloudinary