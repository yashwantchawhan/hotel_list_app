# hotel_list_app

A Flutter-based mobile application for "HotelListApp" - a service that provides members with access to various venues like hotels and beach clubs.
The application displays venue information, allows users to filter venues, and view detailed information about each venue.

### Core Features
- **Venue Listing**: Display venues from API with beautiful cards
- **Advanced Filtering**: Filter by venue type, facilities, family access, and guest pass options
- **Search Functionality**: Search venues by name, location, or type
- **Venue Details**: Comprehensive venue information with:
    - Image carousel with pagination
    - Overview and facilities
    - Opening hours
    - Available activities with collapsible content
- **Responsive Design**: Works on both iOS and Android devices

### Screenshots
<table>
  <tr>
    <td align="center">iOS</td>
    <td align="center">Android</td>
  </tr>
  <tr>
    <td>
      <img width="300" src="https://github.com/user-attachments/assets/b06284df-eb40-43ff-b38d-67a2d76f9a0c" />
    </td>
    <td>
      <img width="300" src="https://github.com/user-attachments/assets/6eb153c6-47c4-4238-b58c-4d5490de4357" />
    </td>
  </tr>
</table>

### Technical Features
- **State Management**: Provider pattern for clean state management
- **Image Caching**: Efficient image loading and caching
- **Error Handling**: Comprehensive error handling and loading states
- **Offline Support**: Local storage capabilities
- **Testing**: Unit tests, widget tests, and integration tests

### Directory Structure
```
lib/
├── main.dart                         # Entry point of the application
packages/                             # Modularized code for features & libraries
├── features/                         # Feature modules (user-facing functionality)
│   ├── venue_details/                # Venue Details Screen
│   │   └── presentation/
│   │       └── widgets/              # Widgets for venue details
│   ├── venue_list/                   # Venue List Screen with MVVM & BLoC
│   │   ├── di/                       # Dependency Injection setup
│   │   │   └── provider/             # Providers, bindings, etc.
│   │   ├── data/                     # Data sources (API, DB)
│   │   ├── domain/                   # Business logic layer
│   │   │   └── mapper/               # DTO-to-domain mappers
│   │   └── presentation/             # Presentation layer
│   │       ├── bloc/                 # BLoC (state & event)
│   │       └── widgets/              # UI widgets for venue list
│   └── venue_map/                    # Map with Venue Pins
│       └── presentation/
│           └── widgets/              # Map-specific UI components
├── libraries/                        # Shared libraries & reusable modules
│   ├── core/                         # App core services & utilities
│   │   └── datasource_core/
│   │       ├── local_db/             # Local database (SQLite helpers, DAOs)
│   │       ├── models/               # Shared domain models
│   │       ├── remote/               # Remote services (API clients)
│   │       └── repositories/         # Repository implementations
│
│   └── design/                       # Design System
│       └── design_common/
│           ├── widgets/              # Shared reusable widgets (e.g., VenueCard)
│           └── tokens/               # Design tokens: colors, dimensions, typography
tests/                                # Unit, widget, and integration tests
├── features/
│   ├── venue_list/
│   │   ├── presentation/
│   │   │   └── bloc_test.dart
│   │   └── data_test.dart
```

## Platform-Specific Setup

### Android
- **Minimum SDK:** API 21 (Android 5.0 Lollipop)
- **Target SDK:** API 34 (Android 14)
- **Compile SDK:** API 34 or higher
- Google Maps API key required if maps functionality is enabled.

### iOS
- **Minimum iOS version:** 14.0
- Google Maps API key required if maps functionality is enabled.

## Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd hotel_list_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## Testing approach
 - Unit tests: models, services, database.
 - Widget tests: UI components like VenueCard, FilterBottomSheet.
 - Integration: DAO + repository interactions.

## Third-Party Libraries Used
| Library                      | Why?                                 |
|------------------------------|--------------------------------------|
| `sqflite` / `sqflite_common_ffi` | Local database (SQLite)           |
| `mocktail`                   | Mocking in unit & widget tests      |
| `bloc_test`                  | Bloc/Cubit testing                  |
| `provider` (optional)        | Lightweight state management        |
| `cached_network_image`       | Caching images efficiently          |

## Design Decisions & Challenges
  - Why modular architecture?
    - Encourages separation of concerns.
    - Easier to maintain & test.
    - Facilitates scaling the app with new modules.