import 'package:bloc_test/bloc_test.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:venue_list/presentation/bloc/venue_bloc.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';
import 'package:venue_list/domain/venue_details_model_mapper.dart';
import 'package:venue_list/domain/venue_data_model_mapper.dart';
import 'package:datasource_core/datasource_core.dart';

// Mocks
class MockVenueRepository extends Mock implements VenueRepositoryImpl {}

class MockVenueDetailsModelMapper extends Mock
    implements VenueDetailsModelMapper {}

class MockVenueDataModelMapper extends Mock implements VenueDataModelMapper {}

class _FakeVenueItem extends Fake implements VenueItem {}

void main() {
  late VenueBloc bloc;
  late MockVenueRepository repository;
  late MockVenueDetailsModelMapper detailsMapper;
  late MockVenueDataModelMapper dataMapper;

  setUpAll(() {
    registerFallbackValue(_FakeVenueItem());
  });

  setUp(() {
    repository = MockVenueRepository();
    detailsMapper = MockVenueDetailsModelMapper();
    dataMapper = MockVenueDataModelMapper();

    bloc = VenueBloc(repository, detailsMapper, dataMapper);
  });

  test('initial state is VenueLoadingState', () {
    expect(bloc.state, isA<VenueLoadingState>());
  });

  blocTest<VenueBloc, VenueState>(
    'emits [VenueLoadedState] when FetchVenue is added',
    build: () {
      when(() => repository.getVenues()).thenAnswer((_) async => []);
      when(() => repository.getFiltersFromAssets()).thenAnswer((_) async => []);
      return bloc;
    },
    act: (bloc) => bloc.add(const FetchVenue()),
    expect: () => [
      isA<VenueLoadedState>(),
    ],
  );

  blocTest<VenueBloc, VenueState>(
    'emits [VenueMapViewState] when MapViewEvent is added',
    build: () {
      when(() => repository.getVenues()).thenAnswer((_) async => []);
      return bloc;
    },
    act: (bloc) => bloc.add(const MapViewEvent()),
    expect: () => [
      isA<VenueMapViewState>(),
    ],
  );

  blocTest<VenueBloc, VenueState>(
    'emits [FilterViewState] when FilterViewEvent is added',
    build: () => bloc,
    act: (bloc) => bloc.add(const FilterViewEvent()),
    expect: () => [
      const FilterViewState(),
    ],
  );

  blocTest<VenueBloc, VenueState>(
    'emits [VenueLoadedState] when SearchVenueEvent is added and succeeds',
    build: () {
      when(() => repository.searchVenues(any())).thenAnswer((_) async => []);
      when(() => repository.getFiltersFromAssets()).thenAnswer((_) async => []);
      when(() => dataMapper.mapToVenueDataDisplayModel(any(), any())).thenReturn(
        VenueDataDisplayModel(venues: [], filters: []),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchVenueEvent(query: 'test')),
    expect: () => [
      isA<VenueLoadedState>(),
    ],
  );

  blocTest<VenueBloc, VenueState>(
    'emits [VenueErrorState] when SearchVenueEvent throws error',
    build: () {
      when(() => repository.searchVenues(any())).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(const SearchVenueEvent(query: 'test')),
    expect: () => [
      isA<VenueErrorState>(),
    ],
  );

  blocTest<VenueBloc, VenueState>(
    'emits [VenueDetailState] when VenueDetailsEvent is added and venue exists',
    build: () {
      when(() => repository.getVenueByName(any()))
          .thenAnswer((_) async => VenueItem(
                id: 1,
                section: '',
                name: '',
                city: '',
                type: '',
                location: '',
                lat: 0,
                lng: 0,
                accessibleForGuestPass: false,
                imageUrls: [],
                categories: [],
                openingHours: {},
                overviewText: [],
                thingsToDo: [],
              ));
      when(() => detailsMapper.mapToVenueDetailsDisplayModel(any())).thenReturn(
        VenueDetailsDisplayModel(
          name: '',
          location: '',
          openingHours: '',
          overview: '',
          imageUrls: [],
          amenities: [],
        ),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(const VenueDetailsEvent(name: 'Venue')),
    expect: () => [
      isA<VenueDetailState>(),
    ],
  );

  blocTest<VenueBloc, VenueState>(
    'emits [VenueErrorState] when VenueDetailsEvent is added and venue is null',
    build: () {
      when(() => repository.getVenueByName(any()))
          .thenAnswer((_) async => null);
      return bloc;
    },
    act: (bloc) => bloc.add(const VenueDetailsEvent(name: 'Venue')),
    expect: () => [
      isA<VenueErrorState>(),
    ],
  );
}
