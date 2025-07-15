import 'dart:convert';
import 'package:datasource_core/models/venue_data_display.dart';
import 'package:datasource_core/remote/api_service.dart';
import 'package:flutter/services.dart';
import 'package:datasource_core/local_db/venue_dao.dart';
import '../models/venue_item.dart';

import 'dart:async';

abstract class VenueRepository {
  Future<List<VenueItem>> getVenues();
  Future<VenueItem?> getVenueByName(String name);
  Future<List<FilterItem>?> getFiltersFromAssets();
  Future<List<VenueItem>> searchVenues(String query);
}


class VenueRepositoryImpl extends VenueRepository {
  final VenueDao venueDao;
  final ApiService apiService;

  VenueRepositoryImpl({required this.venueDao,required this.apiService});

  final StreamController<List<VenueItem>> _venueController =
  StreamController.broadcast();

  Stream<List<VenueItem>> get venueStream => _venueController.stream;

  @override
  Future<List<VenueItem>> getVenues() async {
    final cachedVenues = await venueDao.getAllVenues();
    if (cachedVenues.isEmpty) {
      await _refreshFromAssets();
      final freshVenues = await venueDao.getAllVenues();
      _venueController.add(freshVenues);
      return freshVenues;
    } else {
      _venueController.add(cachedVenues);
      _refreshFromAssets();
      return cachedVenues;
    }
  }

  @override
  Future<VenueItem?> getVenueByName(String name) async {
    final venue = await venueDao.getVenueByName(name);

    if (venue == null) {
      await _refreshFromAssets();

      // After refreshing, try again
      final refreshedVenue = await venueDao.getVenueByName(name);
      return refreshedVenue;
    }

    return venue;
  }


  Future<void> _refreshFromAssets() async {
    try {
      final venues = await apiService.getAllVenues();
      await venueDao.clearVenues();
      await venueDao.insertVenues(venues);

      final updatedVenues = await venueDao.getAllVenues();
      _venueController.add(updatedVenues);
    } catch (e) {
      print('Failed to refresh venues from assets: $e');
    }
  }

  @override
  Future<List<FilterItem>?> getFiltersFromAssets() async {
    return apiService.getFilters();
  }


  @override
  Future<List<VenueItem>> searchVenues(String query) async {
    final allVenues = await venueDao.getAllVenues();

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

