import 'package:flutter/material.dart';
import 'package:design_common/venue_card.dart';
import 'package:design_common/venue_card_configuration.dart';

class VenueListScreen extends StatelessWidget {
  const VenueListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VenueCard(
        configuration: VenueCardConfiguration(imageUrls: [
          "https://images.prismic.io/privilee/ZerPXXUurf2G3NRb_WestinAD-07.10.2018-1of17--1.png?auto=format,compress",
          "https://images.prismic.io/privilee/ZerPXXUurf2G3NRb_WestinAD-07.10.2018-1of17--1.png?auto=format,compress",
          "https://images.prismic.io/privilee/ZerPXXUurf2G3NRb_WestinAD-07.10.2018-1of17--1.png?auto=format,compress",
        ], title: "Venue", subtitle: "Location"),
      ),
    );
  }
}
