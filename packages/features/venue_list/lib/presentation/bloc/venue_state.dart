import 'package:datasource_core/datasource_core.dart';
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
  final VenueDataDisplayModel venueDataDisplayModel;

  const VenueLoadedState({
    required this.venueDataDisplayModel,
  });

  @override
  List<Object?> get props => [venueDataDisplayModel];
}

final class VenueDetailState extends Equatable implements VenueState {
  final VenueDetailsDisplayModel venueItem;

  const VenueDetailState({
    required this.venueItem,
  });

  @override
  List<Object?> get props => [venueItem];
}


final class VenueMapViewState extends Equatable implements VenueState {
  final List<VenueItem> venueItemList;

  const VenueMapViewState({
    required this.venueItemList,
  });

  @override
  List<Object?> get props => [venueItemList];
}

final class FilterViewState extends Equatable implements VenueState {
  const FilterViewState();

  @override
  List<Object?> get props => [];
}

