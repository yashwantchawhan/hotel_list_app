import 'package:flutter/material.dart';
import 'package:venue_list/venue_list.dart';

void main() {
  runApp(const VenueListScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const VenueListScreen();
  }
}
