import 'dart:async';

import 'package:datasource_core/datasource_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venue_list/domain/venue_data_model_mapper.dart';
import 'package:venue_list/domain/venue_details_model_mapper.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final VenueRepositoryImpl venueRepository;
  final VenueDetailsModelMapper venueDetailsModelMapper;
  final VenueDataModelMapper venueDataModelMapper;

  VenueBloc(
    this.venueRepository,
    this.venueDetailsModelMapper,
    this.venueDataModelMapper,
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
    var venueDataDisplay =
        VenueDataDisplayModel(venues: venues, filters: filters ?? []);
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
      final venueDataDisplay = venueDataModelMapper.map(venues, filters!);
      emit(VenueLoadedState(venueDataDisplayModel: venueDataDisplay));
    } catch (e) {
      emit(const VenueErrorState(errorMessage: "Search failed, please use right word to search"));
    }
  }

  FutureOr<void> _loadVenueDetails(
      VenueDetailsEvent event, Emitter<VenueState> emit) async {
    try {
      final venue = await venueRepository.getVenueByName(event.name);
      if (venue != null) {
        final venueDisplay = venueDetailsModelMapper.map(venue);
        emit(VenueDetailState(venueItem: venueDisplay));
      } else {
        emit(const VenueErrorState(errorMessage: "Failed to load details screen"));
      }
    } catch (e) {
      emit(const VenueErrorState(errorMessage: "Failed to load details screen"));
    }
  }
}
