import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:datasource_core/datasource_core.dart';

class VenueDetailsScreen extends StatefulWidget {
  final VenueDetailsDisplayModel venue;

  const VenueDetailsScreen({super.key, required this.venue});

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImageCarousel(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.venue.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.venue.location,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Opening hours:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.venue.openingHours,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.venue.overview,
                        style: const TextStyle(fontSize: 14, height: 1.4),
                      ),
                      const Divider(height: 32),
                      ..._buildAmenities(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 250,
          child: PageView.builder(
            itemCount: widget.venue.imageUrls.length,
            onPageChanged: (index) => setState(() => _currentImageIndex = index),
            itemBuilder: (_, index) {
              return CachedNetworkImage(
                imageUrl: widget.venue.imageUrls[index],
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (_, __) =>
                const Center(child: CircularProgressIndicator()),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.venue.imageUrls.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: _currentImageIndex == index ? 10 : 8,
              height: _currentImageIndex == index ? 10 : 8,
              decoration: BoxDecoration(
                color: _currentImageIndex == index ? Colors.blue : Colors.grey,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  List<Widget> _buildAmenities() {
    return widget.venue.amenities.map((amenity) {
      return Column(
        children: [
          ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 0),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    amenity.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                ),
                if (amenity.note != null)
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      amenity.note!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
              ],
            ),
            children: [
              if (amenity.subtitle != null)
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      amenity.subtitle!,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
            ],
          ),
          const Divider(height: 1),
        ],
      );
    }).toList();
  }
}
