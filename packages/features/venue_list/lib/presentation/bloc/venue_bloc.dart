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
  }

  Future<void> _fetchVenueList(
    FetchVenue event,
    Emitter<VenueState> emit,
  ) async {
    var data = await venueRepository.getVenues();
    emit(VenueLoadedState(venueItemList: data));
  }

  Future<void> _fetchVenueLocationList(
    MapViewEvent event,
    Emitter<VenueState> emit,
  ) async {
    var data = await venueRepository.getVenues();
    emit(VenueMapViewState(venueItemList: data));
  }

  FutureOr<void> _loadFilters(
      FilterViewEvent event,
      Emitter<VenueState> emit) {
    emit(const FilterViewState());

  }
}
