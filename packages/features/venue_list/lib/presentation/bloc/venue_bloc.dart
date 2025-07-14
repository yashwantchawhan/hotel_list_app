import 'dart:async';

import 'package:datasource_core/datasource_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final VenueRepository venueRepository;

  VenueBloc(
    this.venueRepository,
  ) : super(VenueLoadingState()) {
    on<FetchVenue>(_fetchVenueList);
    on<MapViewEvent>(_fetchVenueLocationList);
    on<FilterViewEvent>(_loadFilters);
    on<SearchVenueEvent>(_loadSearchResult);
    on<VenueDetailsEvent>(_loadVenueDetails);
  }

  Future<void> _fetchVenueList(
    FetchVenue event,
    Emitter<VenueState> emit,
  ) async {
    var venues = await venueRepository.getVenues();
    final filters = await venueRepository.getFiltersFromAssets();
    var venueDataDisplay = VenueDataDisplayModel(venues: venues, filters: filters ?? []);
    emit(VenueLoadedState(venueDataDisplayModel: venueDataDisplay));
  }

  Future<void> _fetchVenueLocationList(
    MapViewEvent event,
    Emitter<VenueState> emit,
  ) async {
    var data = await venueRepository.getVenues();
    emit(VenueMapViewState(venueItemList: data));
  }

  FutureOr<void> _loadFilters(FilterViewEvent event, Emitter<VenueState> emit) {
    emit(const FilterViewState());
  }

  FutureOr<void> _loadSearchResult(
      SearchVenueEvent event, Emitter<VenueState> emit) async {
    try {
      final venues = await venueRepository.searchVenues(event.query);
      final filters = await venueRepository.getFiltersFromAssets();
      var venueDataDisplay = VenueDataDisplayModel(venues: venues, filters: filters ?? []);
      emit(VenueLoadedState(venueDataDisplayModel: venueDataDisplay));
    } catch (e) {
      emit(const VenueErrorState());
    }
  }

  FutureOr<void> _loadVenueDetails(
      VenueDetailsEvent event, Emitter<VenueState> emit) async {
    try {
      final venue = await venueRepository.getVenueByName(event.name);

      final venueDisplay = VenueDetailsDisplayModel(
        name: venue!.name,
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

        emit(VenueDetailState(venueItem: venueDisplay));
    } catch (e) {
      emit(const VenueErrorState());
    }
  }
}
