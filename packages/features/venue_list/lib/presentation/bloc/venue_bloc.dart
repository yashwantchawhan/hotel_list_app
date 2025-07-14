import 'package:datasource_core/datasource_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';

class VenueBloc extends Bloc<VenueEvent, VenueState> {
  final VenueRepository venueRepository;

  VenueBloc(
    this.venueRepository,
  ) : super(VenueLoadingState()) {
    // initiaze something
    on<FetchVenue>(_fetchVendorsList);
    on<MapViewEvent>(_fetchVendorsLocationList);
  }

  Future<void> _fetchVendorsList(
    FetchVenue event,
    Emitter<VenueState> emit,
  ) async {
    var data = await venueRepository.getVenues();
    emit(VenueLoadedState(venueItemList: data));
  }
  Future<void> _fetchVendorsLocationList(
      MapViewEvent event,
      Emitter<VenueState> emit,
      ) async {
    var data = await venueRepository.getVenues();
    emit(VenueMapViewState(venueItemList: data));
  }
}
