import 'package:cached_network_image/cached_network_image.dart';
import 'package:design_common/tokens/common_colors.dart';
import 'package:design_common/tokens/common_dimensions.dart';
import 'package:design_common/widgets/venue_card_configuration.dart';
import 'package:flutter/material.dart';

class VenueCard extends StatefulWidget {
  final VenueCardConfiguration configuration;
  final VoidCallback? onCardClick;

  const VenueCard({
    super.key,
    required this.configuration,
    this.onCardClick,
  });

  @override
  State<VenueCard> createState() => _VenueCardState();
}

class _VenueCardState extends State<VenueCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onCardClick,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(CommonDimensions.cardRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image carousel
            SizedBox(
              height: CommonDimensions.cardImageHeight,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  PageView.builder(
                    itemCount: widget.configuration.imageUrls.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        imageUrl: widget.configuration.imageUrls[index],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                      );
                    },
                  ),
                  // Slider dots
                  Positioned(
                    bottom: CommonDimensions.dotBottomPadding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          widget.configuration.imageUrls.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: CommonDimensions.dotSpacing),
                          width: _currentIndex == index
                              ? CommonDimensions.dotSelectedSize
                              : CommonDimensions.dotUnselectedSize,
                          height: _currentIndex == index
                              ? CommonDimensions.dotSelectedSize
                              : CommonDimensions.dotUnselectedSize,
                          decoration: BoxDecoration(
                            color: _currentIndex == index
                                ? CommonColors.dotSelected
                                : CommonColors.dotUnselected,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(CommonDimensions.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.configuration.title,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: CommonDimensions.cardSubtitleSpacing),
                  Text(
                    widget.configuration.subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
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
