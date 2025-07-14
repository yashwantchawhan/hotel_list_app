import 'package:cached_network_image/cached_network_image.dart';
import 'package:datasource_core/models/venue_item.dart';
import 'package:flutter/material.dart';

class VenueDetailsScreen extends StatefulWidget {
  final VenueItem venue;

  const VenueDetailsScreen({super.key, required this.venue});

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.venue.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PageView.builder(
                itemCount: widget.venue.imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.venue.imageUrls[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(widget.venue.imageUrls.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 12 : 8,
                  height: _currentIndex == index ? 12 : 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Colors.blueAccent
                        : Colors.grey,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),

            // Overview
            ExpansionTile(
              title: const Text("Overview"),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(widget.venue.overviewText.single),
                )
              ],
            ),

            // Opening hours
            ExpansionTile(
              title: const Text("Opening Hours"),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("opening hour"),
                )
              ],
            ),

            // Activities
            ExpansionTile(
              title: const Text("Things to Do"),
              children: widget.venue.thingsToDo
                  .map((activity) => ListTile(
                title: Text(activity.title),
              ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}