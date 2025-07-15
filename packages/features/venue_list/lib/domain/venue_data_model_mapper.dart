import 'package:datasource_core/datasource_core.dart';
import 'package:datasource_core/models/venue_item.dart';

abstract class VenueDataModelMapper {
  VenueDataDisplayModel mapToVenueDataDisplayModel(
      List<VenueItem> venueItem, List<FilterItem> filters);
}

class VenueDataModelMapperImpl extends VenueDataModelMapper {
  @override
  VenueDataDisplayModel mapToVenueDataDisplayModel(List<VenueItem> venueItem, List<FilterItem> filters) {
    return VenueDataDisplayModel(venues: venueItem, filters: filters);
  }
}
