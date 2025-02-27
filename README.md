# News App

This is a Flutter application that displays news articles, allows user registration and login. The app uses JWT authentication and supports multiple languages (English and Croatian).

## Features

- **User Authentication:**
  - User registration, login, and token management (JWT)
  - Automatic login if the user is already logged in
  - Supports token refresh when expired

- **News Section:**
  - Displays a list of news articles with infinite scrolling (pagination)
  - Shows detailed views of each news article

- **Localization:**
  - The app supports English and Croatian languages.

- **State Management:**
  - Uses the BLoC pattern for state management.

- **Error Handling:**
  - Retry logic for failed requests and error messages displayed to users.

- **UI/UX:**
  - Custom design to provide a native look for both iOS and Android
  - Minimal animations and transitions for smooth navigation

## Technologies Used

- **Flutter**: Cross-platform mobile development
- **BLoC**: State management pattern
- **JWT Authentication**: JSON Web Tokens for secure authentication
- **Firebase**: Crashlytics for app performance monitoring
- **flutter_secure_storage**: Secure storage for JWT tokens
- **flutter_localizations**: For app localization

## Packages Used

### Dependencies:
- **flutter_bloc**: ^8.0.1 - For state management using the BLoC pattern
- **dio**: ^5.8.0+1 - For making HTTP requests to APIs
- **equatable**: ^2.0.7
- **email_validator**: ^3.0.0
- **flutter_secure_storage**: ^5.0.0 - For securely storing the JWT token
- **firebase_core**: ^2.1.1 - For Firebase integration
- **firebase_crashlytics**: ^3.0.6 - For crash reporting using Firebase Crashlytics
- **flutter_localizations**: ^2.10.0 - For localization support
- **flutter_launcher_icons**: ^0.10.0 - For customizing app launcher icons
- **intl**: ^0.17.0 - For internationalization support
### Dev Dependencies:
- **flutter_launcher_icons**: ^0.10.0 - For generating custom launcher icons

## Getting Started

To run the app locally, follow these steps:

### 1. Clone the Repository


Clone the project to your local machine:

``bash
git clone https://github.com/yourusername/news-app.git

### 2. Install Dependencies

Navigate to the project directory and install the dependencies:

cd news-app
flutter pub get

### 3. Set Up Firebase (Optional)

If you want to use your Firebase Crashlytics and other Firebase services, follow these steps:

-  Go to the Firebase Console.
- Create a new project and add Android and iOS apps.
- Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS).
- Add them to your project as specified in the Firebase setup guide for Flutter.

### 4. Set Up Flutter Launcher Icons

If you want to customize the app's launcher icon, follow these steps:

    Place your icon image (e.g., assets/icon/app_icon.png) in the assets/icon folder.
    Run the following command to generate launcher icons:

flutter pub run flutter_launcher_icons:main

### 5. Run the App

Finally, run the app on an Android or iOS emulator/device:

flutter run