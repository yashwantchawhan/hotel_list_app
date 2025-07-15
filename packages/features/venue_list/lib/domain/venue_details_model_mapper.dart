import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/models/venue_item_display_model.dart';

abstract class VenueDetailsModelMapper {
  VenueDetailsDisplayModel mapToVenueDetailsDisplayModel(VenueItem venueItem);
}

class VenueDetailsModelMapperImpl extends VenueDetailsModelMapper {
  @override
  VenueDetailsDisplayModel mapToVenueDetailsDisplayModel(VenueItem venueItem) {
   return VenueDetailsDisplayModel(
      name: venueItem.name,
      location: "${venueItem.location}, ${venueItem.city}",
      openingHours: "09:00 - 20:00", // or from your DB
      overview: venueItem.overviewText.join(" "),
      imageUrls: venueItem.imageUrls,
      amenities: [
        ...venueItem.categories.map((c) => AmenityItem(
          title: c.title ?? "",
          subtitle: c.details.join(", "),
          note: c.showOnVenuePage ? "Free access" : null,
        )),
        ...venueItem.thingsToDo.map((t) => AmenityItem(
          title: t.title,
          subtitle: t.subtitle,
          note: t.badge,
        )),
      ],
    );
  }

}