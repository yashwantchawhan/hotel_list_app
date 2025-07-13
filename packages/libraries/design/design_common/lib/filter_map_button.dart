import 'package:flutter/material.dart';

class FilterAndMapButton extends StatelessWidget {
  const FilterAndMapButton({
    super.key,
    required this.onMapTap,
    required this.onFilterTap,
  });

  /// Called when Map is tapped (icon or text)
  final VoidCallback onMapTap;

  /// Called when Filter is tapped (icon or text)
  final VoidCallback onFilterTap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
            ),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: onMapTap,
                    child: const Row(
                      children: [
                        Icon(Icons.map),
                        SizedBox(width: 4),
                        Text("Map"),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onFilterTap,
                    child: const Row(
                      children: [
                        Icon(Icons.tune),
                        SizedBox(width: 4),
                        Text("Filters"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
