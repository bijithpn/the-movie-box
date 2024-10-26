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

- **State Management:** Efficient state handling using the [BLoC (Business Logic Component)](https://bloclibrary.dev/#/) pattern, providing smooth performance and an organized codebase.

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

- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc) - for BLoC pattern.
- **Networking**: [DIO](https://pub.dev/packages/dio) - REST API handling, [graphql_flutter](https://pub.dev/packages/graphql_flutter) - GraphQL API handling.
- **UI Components**: A mix of custom and standard Flutter widgets to enhance the browsing experience.

## 🗂️ Project Structure

```plaintext
lib/
├── logic/             # BLoC files for handling business logic
├── data/              # Data models and API integrations
│   ├── models/        # Models for Movies, Series, and Anime
│   └── repositories/  # Repositories for API calls
├── core/              # api client,app router, other app constant
├── view/              # Main screens for browsing and details
├── widgets/           # Reusable components
└── main.dart          # Entry point of the application
```

## 📡 APIs

- **Movies and Series API:**

  - [TMDB APIs](https://developer.themoviedb.org/docs/getting-started)

- **Anime GraphQL API:**
  - [shikimori APIs](https://shikimori.one/api/doc/1.0/animes/index)

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
