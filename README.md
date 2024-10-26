# 🎬 Flutter Movie, TV Series, and Anime Explorer

A Flutter project to browse and view detailed information about Movies, TV Series, and Anime. This application leverages a REST API for Movies and Series data and a GraphQL API for Anime content. With robust navigation and feature-rich information display, users can explore cast and crew details, seasons, episodes, trailers, images, and streaming providers.

## 📱 Features

- **Explore Movies, TV Series, and Anime:**

  - Browse through popular, top-rated, or trending movies, series, and anime.
  - Quick search functionality to find specific titles across Movies, TV Series, and Anime.

- **Detailed Information View:**

  - Access in-depth details on each title, including:
    - **Overview** of plot, genre, ratings, release year, and more.
    - **Cast and Crew** details, with individual profiles.
    - **Seasons and Episodes** list for TV Series.
    - **YouTube Videos:** Official trailers, teasers, and clips.
    - **Image Gallery:** Still images, posters, and cover art.
    - **Watch Providers:** View where you can stream or purchase the content.

- **Anime Details (via GraphQL):**

  - Browse anime-specific details and explore genres, episodes, and trailers.

- **Efficient Navigation and Deep Linking:**

  - Navigate seamlessly through the app with **GoRouter**, enhancing user experience with clear, structured routes.
  - Support for **deep linking**, allowing users to access specific movies, series, or anime directly through shared links.

- **State Management:**
  - Smooth, organized state handling using the [BLoC (Business Logic Component)](https://bloclibrary.dev/#/) pattern.

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- An IDE like [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/bijithpn/the-movie-box.git
   cd the-movie-box
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Set up API keys**

   - Insert your Movie and Series API details in the appropriate files.
   - Add your GraphQL API details for anime content.

4. **Run the app:**
   ```bash
   flutter run
   ```

## 📦 Dependencies

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) - for implementing the BLoC pattern.
- **Networking**: [Dio](https://pub.dev/packages/dio) - for handling REST API calls, [graphql_flutter](https://pub.dev/packages/graphql_flutter) - for GraphQL API handling.
- **Navigation**: [GoRouter](https://pub.dev/packages/go_router) - for app-wide navigation and deep linking.
- **UI Components**: A mix of custom and standard Flutter widgets to enhance the browsing experience.

## 🗂️ Project Structure

```plaintext
lib/
├── core/                 # App-wide constants, router configuration, API client
├── data/                 # Models and repository classes for data handling
│   ├── models/           # Models for Movies, Series, and Anime
│   └── repositories/     # Repositories for API calls
├── logic/                # BLoC files for handling business logic
├── view/                 # Main screens for browsing and details
├── widgets/              # Reusable UI components
└── main.dart             # Entry point of the application
```

## 📡 APIs

- **Movies and Series API:**

  - [TMDB API](https://developer.themoviedb.org/docs/getting-started)

- **Anime GraphQL API:**

  - [Shikimori API](https://shikimori.one/api/doc/1.0/animes/index)

## 📱 GoRouter and Deep Linking

This app uses **GoRouter** for easy navigation and structured route handling. Deep linking support allows users to directly access specific details pages from external links, making it easy to share specific movies, TV series, or anime directly.

### Deep Linking

To support deep links for specific shows, configure your app to handle URL schemes or app links. This will allow users to share and directly navigate to content such as a movie's details or an anime's episode list.

## 🖼️ Screenshots

<img src="https://github.com/bijithpn/the-movie-box/blob/main/screenshots/movie_box_slider.gif?raw=true" alt="Connection Establishing screen" width="300"/>

## 🔧 Contributing

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature-name`).
3. Commit your changes (`git commit -am 'Add new feature'`).
4. Push to the branch (`git push origin feature/your-feature-name`).
5. Create a new Pull Request.

## 📜 License

This project is licensed under the MIT License.
