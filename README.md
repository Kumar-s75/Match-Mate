# 💕 MatchMate

MatchMate is a modern iOS matchmaking application built with **SwiftUI** and a **FastAPI backend**.

The project is being developed as a production-style iOS application, with a focus on clean architecture, asynchronous networking, REST APIs, and scalable client-server design.

> 🚧 **Status:** Active Development

---

## 📱 Overview

MatchMate allows users to discover potential matches based on profile information such as interests, location, age, and compatibility.

The application consists of:

- A native iOS application built with SwiftUI
- A REST API built with FastAPI
- MVVM architecture on the iOS side
- Asynchronous API communication using Swift Concurrency
- Profile discovery and compatibility information

The project is being built incrementally with the goal of eventually supporting authentication, matching, messaging, notifications, and offline functionality.

---

## ✨ Current Features

### Profile Discovery

The Discover screen displays potential matches with:

- Name
- Age
- Location
- Bio
- Interests
- Compatibility score
- Profile image

### REST API Integration

The iOS application communicates with a FastAPI backend using HTTP requests.

Current endpoint:

```text
GET /api/profiles
```

Example response:

```json
[
  {
    "id": "UUID",
    "name": "Priya",
    "age": 24,
    "location": "Delhi",
    "bio": "Love travelling, photography and discovering new places.",
    "interests": [
      "Travel",
      "Photography",
      "Music"
    ],
    "compatibility": 92,
    "imageURL": "https://example.com/image.jpg"
  }
]
```

### Health Check

The backend also exposes:

```text
GET /health
```

Response:

```json
{
  "status": "ok"
}
```

---

# 🏗️ Architecture

MatchMate currently follows an MVVM-inspired architecture.

```text
┌─────────────────────────────┐
│         SwiftUI View        │
│       DiscoveryView         │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       ViewModel             │
│   DiscoveryViewModel        │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│       Repository            │
│     ProfileRepository       │
└──────────────┬──────────────┘
               │
               ▼
┌─────────────────────────────┐
│        APIService           │
│        URLSession           │
└──────────────┬──────────────┘
               │
               │ HTTP
               ▼
┌─────────────────────────────┐
│        FastAPI Backend      │
│        /api/profiles        │
└─────────────────────────────┘
```

This separation keeps networking, business logic, and UI responsibilities isolated.

---

# 🛠️ Tech Stack

## iOS

- Swift
- SwiftUI
- Swift Concurrency
- URLSession
- MVVM
- AsyncImage
- Codable

## Backend

- Python
- FastAPI
- Pydantic
- Uvicorn

## Development Tools

- Xcode
- VS Code
- Git
- GitHub
- iOS Simulator

---

# 📂 Project Structure

The repository is planned as a monorepo containing both the iOS application and backend.

```text
MatchMate/
│
├── MatchMate/
│   ├── Core/
│   │   ├── AppState.swift
│   │   └── Networking/
│   │       ├── APIService.swift
│   │       └── ProfileRepository.swift
│   │
│   ├── Features/
│   │   ├── Discovery/
│   │   │   ├── DiscoveryView.swift
│   │   │   ├── DiscoveryViewModel.swift
│   │   │   ├── ProfileCardView.swift
│   │   │   └── UserProfile.swift
│   │   │
│   │   └── Matches/
│   │       └── ...
│   │
│   ├── MainTabView.swift
│   └── MatchMateApp.swift
│
├── backend/
│   ├── main.py
│   ├── requirements.txt
│   └── ...
│
├── MatchMate.xcodeproj
├── project.yml
├── .gitignore
└── README.md
```

> **Note:** At the current development stage, the FastAPI backend is still located in a separate `matchmate-api` folder on the local machine. It will be moved into the repository under `backend/` when the project structure is finalized.

---

# 🚀 Getting Started

## Prerequisites

Make sure you have:

- macOS
- Xcode
- Python 3.10+
- Git

---

## 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/matchmate.git
cd matchmate
```

---

# 🍎 Running the iOS App

Open the Xcode project:

```bash
open MatchMate.xcodeproj
```

Select an iPhone Simulator and run the application.

Alternatively, build from the command line:

```bash
xcodebuild \
  -project MatchMate.xcodeproj \
  -scheme MatchMate \
  -sdk iphonesimulator \
  -configuration Debug
```

---

# 🐍 Running the Backend

### Current development setup

At this stage, the backend is located separately at:

```text
~/Desktop/matchmate-api
```

Navigate to it:

```bash
cd ~/Desktop/matchmate-api
```

Create a virtual environment:

```bash
python3 -m venv .venv
```

Activate it:

### macOS / Linux

```bash
source .venv/bin/activate
```

Install dependencies:

```bash
pip install fastapi "uvicorn[standard]"
```

Start the API:

```bash
python3 -m uvicorn main:app --reload
```

The API will be available at:

```text
http://127.0.0.1:8000
```

FastAPI documentation:

```text
http://127.0.0.1:8000/docs
```

---

# 🔌 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/health` | Check API health |
| GET | `/api/profiles` | Retrieve available profiles |

---

# 🧪 Development

The project is currently being developed incrementally.

Current development flow:

```text
SwiftUI
   ↓
MVVM
   ↓
Repository
   ↓
URLSession
   ↓
FastAPI
   ↓
JSON
```

The iOS simulator communicates with the local FastAPI development server through:

```text
http://127.0.0.1:8000
```

---

# 🗺️ Roadmap

## Phase 1 — Core Application

- [x] SwiftUI application
- [x] MVVM structure
- [x] Discovery screen
- [x] Profile model
- [x] FastAPI backend
- [x] REST API integration
- [x] Async networking
- [x] Profile image loading
- [ ] Swipe gestures
- [ ] Like / Pass functionality

## Phase 2 — Matching

- [ ] Like system
- [ ] Pass system
- [ ] Mutual matching
- [ ] Matches screen
- [ ] Match notifications

## Phase 3 — Authentication

- [ ] User registration
- [ ] Login
- [ ] Secure token storage
- [ ] Keychain integration
- [ ] User profile creation
- [ ] Profile editing

## Phase 4 — Messaging

- [ ] Chat interface
- [ ] Message API
- [ ] Real-time messaging
- [ ] WebSocket support
- [ ] Message persistence

## Phase 5 — iOS Features

- [ ] Core Data
- [ ] Offline support
- [ ] Image caching
- [ ] Push notifications
- [ ] PhotosPicker
- [ ] Location services
- [ ] Deep linking
- [ ] Error handling

## Phase 6 — Production Backend

- [ ] PostgreSQL
- [ ] Authentication service
- [ ] User management
- [ ] Matching algorithm
- [ ] Message storage
- [ ] API validation
- [ ] Docker
- [ ] CI/CD
- [ ] Cloud deployment
- [ ] Automated testing

---

# 🔐 Privacy & Security

MatchMate is currently a development project.

Future versions will implement:

- Secure authentication
- Keychain-based credential storage
- HTTPS communication
- API authentication
- Input validation
- Secure image handling
- User privacy controls

No production user data is currently stored.

---

# 🎯 Project Goals

The goal of MatchMate is to build a complete modern iOS application while exploring:

- Native iOS development
- SwiftUI
- Swift Concurrency
- REST API architecture
- Client-server communication
- MVVM
- Backend development
- Database design
- Real-time communication
- Push notifications
- Offline-first application design

---

# 📌 Current Status

**Version:** `0.1.0`

### Currently working

- Native SwiftUI application
- Discovery screen
- MVVM architecture
- FastAPI backend
- REST API
- Profile retrieval
- iOS → FastAPI communication
- Profile data rendering

### Currently being developed

- Profile image loading
- Swipe interactions
- Like / Pass system

---

# 👨‍💻 Author

**Kumar Saurabh**

B.Tech — NIT Jalandhar

Interested in:

- iOS Development
- Full Stack Engineering
- Backend Systems
- AI & Software Engineering

---

## ⭐ Project Status

MatchMate is an educational and portfolio project currently under active development.

More features will be added as development progresses.
