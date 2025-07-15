import 'package:datasource_core/models/category.dart';
import 'package:datasource_core/models/city.dart';
import 'package:datasource_core/models/filter.dart';
import 'package:datasource_core/models/venue_item.dart';


class VenueData {
  final List<VenueItem> venues;
  final List<Filter> filters;
  final List<Category> categories;
  final List<City> cities;

  VenueData({
    required this.venues,
    required this.filters,
    required this.categories,
    required this.cities,
  });
}