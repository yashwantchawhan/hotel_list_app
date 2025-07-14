import 'package:flutter/material.dart';

import 'common_dimensions.dart';
import 'localization.dart';

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
        height: CommonDimensions.dimen48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 48,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(CommonDimensions.dimen100)),
              ),
            ),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: CommonDimensions.dimen8),
              margin: const EdgeInsets.symmetric(horizontal: CommonDimensions.dimen8),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(CommonDimensions.dimen100)),
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
                        SizedBox(width: CommonDimensions.dimen4),
                        Text(Localization.map),
                      ],
                    ),
                  ),
                  const SizedBox(width: CommonDimensions.dimen12),
                  Container(
                    width: 1,
                    height: double.infinity,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: CommonDimensions.dimen12),
                  GestureDetector(
                    onTap: onFilterTap,
                    child: const Row(
                      children: [
                        Icon(Icons.tune),
                        SizedBox(width: CommonDimensions.dimen4),
                        Text(Localization.filters),
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
