import 'package:datasource_core/datasource_core.dart';
import 'package:datasource_core/models/venue_item.dart';

abstract class VenueDataModelMapper {
  VenueDataDisplayModel map(
      List<VenueItem> venueItem, List<FilterItem> filters);
}

class VenueDataModelMapperImpl extends VenueDataModelMapper {
  @override
  VenueDataDisplayModel map(List<VenueItem> venues, List<FilterItem> filters) {
    return VenueDataDisplayModel(venues: venues, filters: filters ?? []);
  }
}
