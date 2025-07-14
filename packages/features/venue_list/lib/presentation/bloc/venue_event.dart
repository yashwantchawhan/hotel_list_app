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

final class VenueDetailsEvent extends VenueEvent {
  final String name;
  const VenueDetailsEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

final class MapViewEvent extends VenueEvent {
  const MapViewEvent();

  @override
  List<Object?> get props => [];
}

final class FilterViewEvent extends VenueEvent {
  const FilterViewEvent();

  @override
  List<Object?> get props => [];
}

class SearchVenue extends VenueEvent {
  final String query;

  const SearchVenue(this.query);

  @override
  List<Object> get props => [query];
}
