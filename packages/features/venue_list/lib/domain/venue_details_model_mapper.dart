import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/models/venue_item_display_model.dart';

abstract class VenueDetailsModelMapper {
  VenueDetailsDisplayModel map(VenueItem venueItem);
}

class VenueDetailsModelMapperImpl extends VenueDetailsModelMapper {
  @override
  VenueDetailsDisplayModel map(VenueItem venue) {
   return VenueDetailsDisplayModel(
      name: venue.name,
      location: "${venue.location}, ${venue.city}",
      openingHours: "09:00 - 20:00", // or from your DB
      overview: venue.overviewText.join(" "),
      imageUrls: venue.imageUrls,
      amenities: [
        ...venue.categories.map((c) => AmenityItem(
          title: c.title ?? "",
          subtitle: c.details.join(", "),
          note: c.showOnVenuePage ? "Free access" : null,
        )),
        ...venue.thingsToDo.map((t) => AmenityItem(
          title: t.title,
          subtitle: t.subtitle,
          note: t.badge,
        )),
      ],
    );
  }

}