import 'package:flutter/material.dart';
import 'package:design_common/venue_card.dart';
import 'package:design_common/venue_card_configuration.dart';
import 'package:venue_list/venue_test_widget.dart';

class VenueListScreen extends StatelessWidget {
  const VenueListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VenueTestWidget(),
    );
  }
}
