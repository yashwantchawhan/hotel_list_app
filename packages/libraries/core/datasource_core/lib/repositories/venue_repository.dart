import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:datasource_core/local_db/venue_dao.dart';
import '../models/venue_item.dart';

import 'dart:async';

class VenueRepository {
  final VenueDao _venueDao = VenueDao();
  static const String _localDataPath = 'assets/data/venues.json';

  final StreamController<List<VenueItem>> _venueController =
  StreamController.broadcast();

  /// Stream of venues from DB
  Stream<List<VenueItem>> get venueStream => _venueController.stream;

  /// Fetch cached venues & start background refresh
  Future<List<VenueItem>> getVenues() async {
    final cachedVenues = await _venueDao.getAllVenues();

    if (cachedVenues.isEmpty) {
      await _refreshFromAssets();
      final freshVenues = await _venueDao.getAllVenues();
      _venueController.add(freshVenues);
      return freshVenues;
    } else {
      // emit current
      _venueController.add(cachedVenues);
      // background refresh
      _refreshFromAssets();
      return cachedVenues;
    }
  }

  /// Background refresh
  Future<void> _refreshFromAssets() async {
    try {
      final jsonString = await rootBundle.loadString(_localDataPath);
      final jsonData = jsonDecode(jsonString) as Map<String, dynamic>;

      final venues = <VenueItem>[];

      for (var json in jsonData['items'] ?? []) {
        venues.add(VenueItem.fromJson(json));
      }

      await _venueDao.clearVenues();
      await _venueDao.insertVenues(venues);

      // push to stream after refreshing
      final updatedVenues = await _venueDao.getAllVenues();
      _venueController.add(updatedVenues);
    } catch (e) {
      print('Failed to refresh venues from assets: $e');
    }
  }

  /// Search venues by keyword in name, city, type or location
  Future<List<VenueItem>> searchVenues(String query) async {
    final allVenues = await _venueDao.getAllVenues();

    final lowerQuery = query.toLowerCase();

    return allVenues.where((venue) {
      return venue.name.toLowerCase().contains(lowerQuery) ||
          venue.city.toLowerCase().contains(lowerQuery) ||
          venue.location.toLowerCase().contains(lowerQuery) ||
          venue.type.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  void dispose() {
    _venueController.close();
  }
}

