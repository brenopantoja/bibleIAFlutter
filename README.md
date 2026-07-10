# 📖 Bible IA Flutter

Bible IA Flutter is a modern Flutter application that combines the Holy Bible with Artificial Intelligence.

The application is designed to provide a fast, intuitive, and intelligent experience for Bible study, allowing users to search the Scriptures, ask questions using AI, and access the Bible in multiple languages.

---

## ✨ Features

- 📚 Complete Holy Bible
- 🤖 AI-powered Biblical Assistant
- 🔎 Biblical Theme Search
- ❤️ Favorite Verses
- 🌍 Multi-language Support (Portuguese / English)
- 📱 Offline Bible (SQLite)
- ☁️ Spring Boot Backend Integration
- 🔐 Secure REST API
- 🌙 Dark & Light Theme
- 🚀 Enterprise Flutter Architecture

---

## 🏗️ Project Structure

```
lib/
│
├── app/
├── core/
├── features/
├── shared/
└── main.dart
```

---

## 🛠️ Technologies

- Flutter
- Dart
- Riverpod
- Dio
- SQLite
- Spring Boot
- REST API
- OpenAI

---

## 📦 Dependencies

- flutter_riverpod
- dio
- sqflite
- shared_preferences
- logger
- intl

---

## 🚀 Getting Started

Clone the project

```bash
git clone https://github.com/brenopantoja/bibleIAFlutter.git
```

Install dependencies

```bash
flutter pub get
```

Run the project

```bash
flutter run
```

---

## 📡 Backend

The application communicates with the Bible IA Spring Boot Backend.

Health endpoint

```
# API Endpoints

## AI Chat

```
POST /api/chat
```

---

## Bible Search

```
GET /api/search
```

---

## Bible Chapters

```
GET /api/bible/{book}/{chapter}
```

---

## Daily Verse

```
GET /api/verse
```

---

## Health Check

```
GET /api/health
```

---

## Administrative Login

```
POST /api/auth/admin
```

---

## Application Logs

```
GET /api/admin/logs
```

Requires authentication.

---

## Cache Management

```
DELETE /api/admin/cache
```

Requires authentication.

---
```

---

## 📄 License

MIT License

---
**Developed by Breno Ramos Pantoja**

- Computer Engineer
- Master's Degree in Electrical Engineering
- Full Stack Software Developer
 