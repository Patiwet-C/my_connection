# My Connection

A web-based Flutter application that can be deployed as a website.

## Features

- Responsive web design
- Material Design 3 theme
- Multi-page navigation with bottom navigation bar
- Dashboard, Profile, and Settings pages
- Modern UI components

## Getting Started

This project is a Flutter web application that can be deployed to web hosting platforms.

### Prerequisites

- Flutter SDK (^3.7.0)
- Web browser for testing

### Installation

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Run `flutter run -d chrome` to start the app in Chrome
4. Or run `flutter build web` to build for production

## Dependencies

- `cupertino_icons: ^1.0.8` - For iOS-style icons

## Supported Platforms

- Web (primary)
- Mobile (Android/iOS) - for testing

## Deployment

To deploy to web hosting:

1. Run `flutter build web`
2. Upload the contents of `build/web/` to your web server
3. Configure your server to serve `index.html` for all routes

## Project Structure

- `lib/main.dart` - Main application code
- `web/` - Web-specific files (HTML, manifest, icons)
- `android/` and `ios/` - Mobile platform files (for testing)
