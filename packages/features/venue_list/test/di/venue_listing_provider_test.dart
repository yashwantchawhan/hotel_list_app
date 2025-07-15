import 'package:datasource_core/datasource_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:venue_list/di/venue_listing_provider.dart';
import 'package:venue_list/presentation/bloc/venue_bloc.dart';
import 'package:venue_list/presentation/widgets/venue_list_screen.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  testWidgets('VenueListingProvider provides VenueBloc and renders VenueListScreen',
          (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: VenueListingProvider(),
          ),
        );

        expect(find.byType(VenueListScreen), findsOneWidget);

        final BuildContext context = tester.element(find.byType(VenueListScreen));
        final venueBloc = BlocProvider.of<VenueBloc>(context, listen: false);

        expect(venueBloc, isNotNull);
        expect(venueBloc, isA<VenueBloc>());
      });
}
