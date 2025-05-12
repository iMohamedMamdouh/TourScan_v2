# TourScan

TourScan is a sophisticated Flutter-based mobile application designed to enhance tourism experiences through advanced machine learning capabilities for artifact recognition and information retrieval.

## Features

- **Artifact Recognition**: Camera-based scanning and identification of historical artifacts
- **Detailed Information**: Comprehensive details about recognized artifacts
- **Authentication**: Seamless Google Sign-in integration for secure access
- **Cloud Integration**: Firebase-powered storage and retrieval of artifact data
- **Accessibility**: Text-to-Speech functionality for artifact descriptions
- **Internationalization**: Support for multiple languages
- **Multi-platform**: Compatible with iOS and Android devices

## Technology Stack

- **Frontend**: Flutter (SDK >=3.5.4)
- **Backend**: Firebase
  - Firebase Authentication
  - Cloud Firestore
  - Firebase Storage
- **Machine Learning**: TensorFlow Lite
- **Authentication**: Google Sign-in API
- **Additional Technologies**:
  - Flutter TTS for text-to-speech conversion
  - Advanced image processing
  - Optimized network image caching

## Prerequisites

Before running the application, ensure you have:

- Flutter SDK (>=3.5.4)
- Dart SDK
- Android Studio / Xcode for mobile development
- Firebase project configuration
- Google Cloud Platform project with appropriate APIs enabled

## Installation

1. Clone the repository:
```bash
git clone [https://github.com/iMohamedMamdouh/TourScan_v2.git]
cd tourscan
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure Firebase:
   - Add your `google-services.json` to the Android app directory
   - Add your `GoogleService-Info.plist` to the iOS app directory

4. Run the application:
```bash
flutter run
```

## Project Structure

- `/lib` - Core application source code
- `/assets` - Application assets including:
  - Machine learning model files
  - SVG resources
  - API artifact data
- `/android`, `/ios`, `/web` - Platform-specific implementations
- `/test` - Unit and integration tests

## Dependencies

Key dependencies include:
- `firebase_auth`: ^5.5.1
- `cloud_firestore`: ^5.6.5
- `tflite_flutter`: ^0.11.0
- `flutter_tts`: ^4.2.2
- `google_sign_in`: ^6.2.2
- `provider`: ^6.1.4

For a complete list of dependencies, refer to the `pubspec.yaml` file.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/NewFeature`)
3. Commit your changes (`git commit -m 'Add NewFeature'`)
4. Push to the branch (`git push origin feature/NewFeature`)
5. Submit a Pull Request

## License

This project is licensed under the [MIT License](LICENSE).

## Contact

Project Repository: [https://github.com/iMohamedMamdouh/TourScan_V2](https://github.com/iMohamedMamdouh/TourScan_v2)

## Acknowledgments

- The Flutter development team
- Firebase platform developers
- TensorFlow machine learning framework team
- All contributors to this project
