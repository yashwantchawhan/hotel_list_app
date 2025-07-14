class VenueDetailsDisplayModel {
  final String name;
  final String location;
  final String openingHours;
  final String overview;
  final List<String> imageUrls;
  final List<AmenityItem> amenities;

  VenueDetailsDisplayModel({
    required this.name,
    required this.location,
    required this.openingHours,
    required this.overview,
    required this.imageUrls,
    required this.amenities,
  });
}

class AmenityItem {
  final String title;
  final String? subtitle;
  final String? note;

  AmenityItem({
    required this.title,
    this.subtitle,
    this.note,
  });
}