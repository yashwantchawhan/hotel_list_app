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

### Technical Features
- **State Management**: Provider pattern for clean state management
- **Image Caching**: Efficient image loading and caching
- **Error Handling**: Comprehensive error handling and loading states
- **Offline Support**: Local storage capabilities
- **Testing**: Unit tests, widget tests, and integration tests


```
lib/
├── models/           # Data models
│   ├── venue.dart    # Venue and related models

```