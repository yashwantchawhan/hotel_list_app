import 'package:equatable/equatable.dart';

sealed class VenueEvent extends Equatable {
  const VenueEvent();
}

final class FetchVenue extends VenueEvent {
  const FetchVenue();
  @override
  List<Object?> get props => [];
}

final class SearchVenueEvent extends VenueEvent {
  final String query;
  const SearchVenueEvent({required this.query});
  @override
  List<Object?> get props => [query];
}

final class MapViewEvent extends VenueEvent {
  const MapViewEvent();
  @override
  List<Object?> get props => [];
}
