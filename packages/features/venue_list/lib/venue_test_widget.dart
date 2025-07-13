import 'package:datasource_core/datasource_core.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:flutter/material.dart';

class VenueTestWidget extends StatelessWidget {
  final repo = VenueRepository();

  @override
  Widget build(BuildContext context) {
    repo.getVenues(); // trigger load

    return Scaffold(
      appBar: AppBar(title: const Text('Venues')),
      body: StreamBuilder<List<VenueItem>>(
        stream: repo.venueStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No venues found.'));
          }

          final venues = snapshot.data!;
          print("Data size ${venues.length}");
          return ListView.builder(
            itemCount: venues.length,
            itemBuilder: (context, index) {
              final venue = venues[index];
              return ListTile(
                title: Text(venue.name),
                subtitle: Text(venue.city),
              );
            },
          );
        },
      ),
    );
  }
}
