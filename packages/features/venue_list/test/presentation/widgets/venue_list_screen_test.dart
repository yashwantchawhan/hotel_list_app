import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:venue_list/presentation/bloc/venue_bloc.dart';
import 'package:venue_list/presentation/bloc/venue_event.dart';
import 'package:venue_list/presentation/bloc/venue_state.dart';
import 'package:venue_list/presentation/widgets/venue_list_screen.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:datasource_core/models/venue_data_display.dart';

class MockVenueBloc extends Mock implements VenueBloc {}

void main() {
  late MockVenueBloc mockBloc;

  final venues = [
    VenueItem(
      id: 1,
      section: 'section',
      name: 'Venue 1',
      city: 'City 1',
      type: 'Type 1',
      location: 'Location 1',
      lat: 0,
      lng: 0,
      accessibleForGuestPass: true,
      imageUrls: [],
      categories: [],
      openingHours: {},
      overviewText: [],
      thingsToDo: [],
    )
  ];

  setUpAll(() {
    registerFallbackValue(const FetchVenue());
    registerFallbackValue(VenueLoadingState());
  });

  setUp(() {
    mockBloc = MockVenueBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<VenueBloc>.value(
        value: mockBloc,
        child: const VenueListScreen(),
      ),
    );
  }

  testWidgets('renders loading indicator when state is VenueLoadingState', (tester) async {
    when(() => mockBloc.state).thenReturn(VenueLoadingState());
    when(() => mockBloc.stream).thenAnswer((_) => const Stream<VenueState>.empty());

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders error text when state is VenueErrorState', (tester) async {
    when(() => mockBloc.state).thenReturn(const VenueErrorState(errorMessage: 'Something went wrong'));
    when(() => mockBloc.stream).thenAnswer((_) => const Stream<VenueState>.empty());

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.textContaining('Something went wrong'), findsOneWidget);
  });

  testWidgets('renders venue list when state is VenueLoadedState', (tester) async {
    final venueDataDisplayModel = VenueDataDisplayModel(
      venues: venues,
      filters: [],
    );

    when(() => mockBloc.state).thenReturn(VenueLoadedState(venueDataDisplayModel: venueDataDisplayModel));
    when(() => mockBloc.stream).thenAnswer((_) => const Stream<VenueState>.empty());

    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.text('Venue 1'), findsOneWidget);
  });
}
