# 📖 Bible IA Flutter

Bible IA Flutter é um aplicativo desenvolvido em Flutter que integra a Bíblia Sagrada com Inteligência Artificial.

O objetivo é oferecer uma experiência moderna de estudo bíblico, permitindo pesquisar versículos, realizar perguntas utilizando IA e consultar a Bíblia em diferentes idiomas.

---

## ✨ Funcionalidades

- 📚 Bíblia Sagrada Completa
- 🤖 Assistente Bíblico com IA
- 🔎 Pesquisa por Temas Bíblicos
- ❤️ Versículos Favoritos
- 🌍 Português e Inglês
- 📱 Bíblia Offline (SQLite)
- ☁️ Integração com Backend Spring Boot
- 🔐 API REST
- 🌙 Tema Claro e Escuro
- 🚀 Arquitetura Flutter Enterprise

---

## 🏗️ Estrutura

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

## 🛠️ Tecnologias

- Flutter
- Dart
- Riverpod
- Dio
- SQLite
- Spring Boot
- REST API
- OpenAI

---

## 📦 Dependências

- flutter_riverpod
- dio
- sqflite
- shared_preferences
- logger
- intl

---

## 🚀 Como executar

Clone o projeto

```bash
git clone https://github.com/brenopantoja/bibleIAFlutter.git
```

Instale as dependências

```bash
flutter pub get
```

Execute

```bash
flutter run
```

---

## 📡 Backend

O aplicativo utiliza um backend em Spring Boot.

Endpoint de teste

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

## 📄 Licença

MIT License

---
**Developed by Breno Ramos Pantoja**

- Computer Engineer
- Master's Degree in Electrical Engineering
- Full Stack Software Developer