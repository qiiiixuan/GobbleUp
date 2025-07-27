# 🍽️ GobbleUp
A food recommendation app inspired by Hinge

**NUS Orbital 2025 – Apollo 11 Project**  
Team GobbleUp (ID 7035)  
Contributors: Truman Tong, Zhu Qixuan  
[🔗 Try the Web App](https://gobbleup-4b0ad.web.app)

---

## 💡 Motivation

Looking for food can be stressful due to information overload, decision fatigue, and platform fragmentation. GobbleUp solves this by offering an engaging, swipe-based recommendation system inspired by dating apps and optimized for foodies.

---

## 🎯 Aim

GobbleUp aims to:
- Connect restaurants with potential customers.
- Provide food recommendations through swipe mechanics.
- Centralize food info with links, reviews, and profiles.
- Make food discovery fun, fast, and personalized.

---

## 👥 Target Audience

- **Gobbler**: Foodies looking for new eats.
- **Gobbled**: Restaurants promoting their food.

---

## 🧑‍💻 User Stories

1. As a foodie, I want to swipe through restaurants based on my preferences.
2. As someone with dietary restrictions, I want to filter options (e.g., vegetarian, halal).
3. As a frequent diner, I want to leave reviews.
4. As a restaurant owner, I want to reach users who match my cuisine.
5. As a planner, I want a list of go-to places.
6. As a responsible partner, I want my restaurant choices to be impressive.

---

## ✨ Features

| Feature               | Status        | Description |
|----------------------|---------------|-------------|
| Swipe Interface       | ✅ Implemented | Tinder-like food discovery |
| User Profiles         | ✅ Implemented | Separated onboarding for Gobbler & Gobbled |
| Restaurant Integration| ✅ Implemented | Editable restaurant profiles |
| Authentication        | ✅ Implemented | Firebase Auth for sign in/up |
| External Links        | ✅ Implemented | Google Maps, TikTok, restaurant websites |
| Saving Restaurants    | ✅ Implemented | Save swiped right restaurants |
| Filtering             | ✅ Implemented | Cuisines, price ranges, dietary needs |
| Help Page             | ✅ Implemented | FAQs and app usage guidance |

---

## 🔮 Future Extensions

- ⭐ **Review & Rating System**: Food journaling and star ratings
- 🤖 **Matchmaking Algorithm**: Recommend based on swipe history
- 📅 **Reservation Links**: Redirect to restaurant’s reservation system
- 📈 **Restaurant Stats Dashboard**: View swipes, saves, and insights

---

## 🧪 Testing

All key features have been tested manually and through user feedback.

- ✅ Sign-up/login validation
- ✅ Swipe/save flow logic
- ✅ Saved/deleted state consistency
- ✅ Hyperlink external redirects
- ✅ Filter application and reset behavior

---

## 🛠️ Software Engineering Practices

- **Git + GitHub**: Version control, milestones, and issues
- **CI/CD**: Firebase Hosting via GitHub deploys
- **Code Comments**: All logic and UI components are annotated
- **Error Handling**: Try-catch + Snackbar error messages
- **Responsive UI**: LayoutBuilder & MediaQuery
- **KISS Principle**: Clean functions with minimal side effects
- **Data Abstraction**: Services for auth and database logic reuse

---

## 🧰 Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Firebase Auth, Realtime Database
- **Hosting**: Firebase Hosting
- **Version Control**: Git + GitHub

---

## 📆 Project Timeline

| Milestone | Deliverables |
|----------|--------------|
| **M1 (Jun 2)** | Ideation, tech stack, proof-of-concept login |
| **M2 (Jun 30)** | Swipe functionality, profile creation, auth |
| **M3 (Jul 28)** | Filtering, saving, help page, UI polish |

---

## 📁 Code Structure

<details>
<summary><code>📂 lib/</code> folder (main app logic)</summary>

- `data/` – App-wide constants (e.g. styles)
- `services/` – Firebase logic (auth, DB)
- `views/`
  - `pages/` – Screens for onboarding, home, profile, etc.
  - `widgets/` – Reusable UI widgets (e.g., restaurant cards)
- `main.dart` – App entry point
- `app.dart` – Theme & routing
- `firebase_options.dart` – Firebase config
</details>
