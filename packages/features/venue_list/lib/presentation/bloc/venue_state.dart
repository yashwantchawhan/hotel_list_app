import 'package:datasource_core/models/VenueData.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:equatable/equatable.dart';

sealed class VenueState {
  const VenueState();
}

final class VenueLoadingState extends Equatable implements VenueState {
  @override
  List<Object?> get props => [];
}

final class VenueErrorState extends Equatable implements VenueState {
  const VenueErrorState();

  @override
  List<Object?> get props => [];
}

final class VenueLoadedState extends Equatable implements VenueState {
  final List<VenueItem> venueItemList;

  const VenueLoadedState({
    required this.venueItemList,
  });

  @override
  List<Object?> get props => [venueItemList];
}

final class VenueMapViewState extends Equatable implements VenueState {
  final List<VenueItem> venueItemList;

  const VenueMapViewState({
    required this.venueItemList,
  });

  @override
  List<Object?> get props => [venueItemList];
}
