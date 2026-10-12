# MSAP Alumni

### One community. Generations of connections.

**The official mobile application for the Association of MSAP Alumni, Manipur.**

MSAP Alumni is a Flutter-based mobile application designed to bring alumni together, preserve cultural heritage, strengthen professional networks, and keep the Manipuri alumni community connected across generations.

From discovering fellow alumni to staying updated on community events, the app aims to make every connection easier and every generation part of the same community.

---

## About the Project

The Association of MSAP Alumni, Manipur, traces its roots to the Pune Manipuri Students Association, founded in 1973. Built around fellowship, cultural continuity, mentorship, and community development, the association connects people whose journeys began in student life and continue across professions and generations.

**MSAP Alumni** brings this mission to mobile through a dedicated platform for alumni discovery, events, announcements, community history, and member profiles.

## Features

### Community & Networking

- **Alumni Directory** — Explore alumni profiles and search using available filters.
- **Member Profiles** — View and manage profile information.
- **Authentication Screens** — Login and registration interfaces.
- **Community Information** — Learn about the association, its history, leadership, and mission.

### Events & Engagement

- **Events** — Browse upcoming and past community events.
- **Event Participation** — RSVP to events through the app interface.
- **Announcements** — Access community news and updates.
- **Photo Gallery** — Explore memories from association events and activities.

### Additional Modules

- **Payments** — Payment-related interface for future association transactions.
- **Feedback & Contact** — Submit feedback through the app interface.
- **Governance & History** — Explore the association's milestones and leadership.

> **Development status:** The app is under active development. Several screens and interactions currently use local mock data and application state. Live authentication, persistent backend data, payment processing, and other server-dependent functionality require further integration.

## Tech Stack

| Technology      | Purpose                           |
| --------------- | --------------------------------- |
| Flutter         | Cross-platform mobile UI          |
| Dart            | Application development           |
| Material Design | UI components and layouts         |
| Git & GitHub    | Version control and collaboration |

## Project Structure

```text
lib/
├── core/
│   ├── router/
│   ├── theme/
│   └── widgets/
├── data/
│   └── mock/
├── features/
│   ├── about/
│   ├── alumni/
│   ├── announcements/
│   ├── auth/
│   ├── events/
│   ├── feedback/
│   ├── gallery/
│   ├── home/
│   ├── payments/
│   └── profile/
├── models/
└── main.dart

assets/
├── Gallery/
├── General Body/
├── News/
└── ...
```

*The directory overview may evolve as development continues.*

## Getting Started

### Prerequisites

- Flutter SDK compatible with the project's SDK constraints
- Dart SDK
- Android Studio or Visual Studio Code
- An Android device or emulator, or another supported Flutter target

### Installation

**1. Clone the repository**

```bash
git clone https://github.com/N0xx77/MSAP-Alumni-Application.git
```

**2. Enter the project directory**

```bash
cd MSAP-Alumni-Application
```

**3. Install dependencies**

```bash
flutter pub get
```

**4. Check the project**

```bash
flutter analyze
flutter test
```

**5. Run the application**

```bash
flutter run
```

Connect an Android device with USB debugging enabled or start an emulator before running the application.

## Development Roadmap

- [x] Feature-based Flutter project structure
- [x] Core navigation and primary application screens
- [x] Alumni directory and search interface
- [x] Events and RSVP interface
- [x] Member profile management interface
- [x] Gallery and association information screens
- [ ] Connect the mobile application to a shared backend
- [ ] Implement secure authentication and persistent member profiles
- [ ] Persist alumni data, event registrations, and announcements
- [ ] Integrate cloud-based image and gallery storage
- [ ] Implement payment gateway integration and transaction verification
- [ ] Add administrative workflows and production-ready error handling

## Project Goals

MSAP Alumni aims to:

- Strengthen connections between alumni across generations.
- Help current students access mentorship and professional guidance.
- Preserve Manipuri culture, traditions, and shared memories.
- Support collaboration and community initiatives.
- Build a reliable digital home for the alumni association.

## Contributing

Contributions, ideas, and feedback are welcome.

1. Fork the repository.
2. Create a feature branch.
3. Make your changes and test them.
4. Commit your work with a descriptive message.
5. Open a pull request describing the changes.

Please avoid committing credentials, API keys, private member information, or other sensitive data.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

\<p align="center">
&#x20; \<strong>MSAP Alumni\</strong>\<br/>
&#x20; Preserving our roots. Connecting our journeys. Building our future.
\</p>
