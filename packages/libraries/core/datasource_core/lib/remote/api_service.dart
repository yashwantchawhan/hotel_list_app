import 'dart:convert';

import 'package:datasource_core/models/venue_data_display.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:flutter/services.dart';

const String _localDataPath = 'assets/data/venues.json';

abstract class ApiService {
  Future<List<VenueItem>> getAllVenues();
  Future<List<FilterItem>?> getFilters();
}

class ApiServiceImpl extends ApiService {
  final AssetBundle bundle;

  ApiServiceImpl({AssetBundle? bundle}) : bundle = bundle ?? rootBundle;

  @override
  Future<List<VenueItem>> getAllVenues() async {
    final jsonString = await bundle.loadString(_localDataPath);
    final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

    final venues = <VenueItem>[];

    for (var json in jsonData['items'] ?? []) {
      venues.add(VenueItem.fromJson(json));
    }
    return venues;
  }

  @override
  Future<List<FilterItem>?> getFilters() async {
    try {
      final jsonString = await bundle.loadString(_localDataPath);
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;
      final filters = <FilterItem>[];

      for (var json in jsonData['filters'] ?? []) {
        filters.add(FilterItem.fromJson(json));
      }
      return filters;
    } catch (_) {
      return null;
    }
  }
}
