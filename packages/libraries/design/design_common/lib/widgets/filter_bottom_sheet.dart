import 'package:design_common/tokens/common_colors.dart';
import 'package:design_common/tokens/common_dimensions.dart';
import 'package:design_common/tokens/localization.dart';
import 'package:design_common/widgets/filter_chip_widget.dart';
import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape:  const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(CommonDimensions.sheetRadius),
      ),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                height: CommonDimensions.handleHeight,
                width: CommonDimensions.handleWidth,
                margin: const EdgeInsets.symmetric(
                  vertical: CommonDimensions.handleMargin,
                ),
                decoration: BoxDecoration(
                  color: CommonColors.sheetHandle,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(CommonDimensions.listPadding),
                  children: [
                    const Text(
                      Localization.filterBy,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: CommonDimensions.fontSize16,
                      ),
                    ),
                    const SizedBox(height: CommonDimensions.chipSpacing),
                    _buildCategoryTabs(),
                    const Divider(),
                    _buildSection(
                      title: Localization.city,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(Localization.allUAE),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    _buildSection(
                      title: Localization.availableForToday,
                      child: const Wrap(
                        spacing: CommonDimensions.chipSpacing,
                        children: [
                          FilterChipWidget(label: Localization.before2pm),
                          FilterChipWidget(label: Localization.after2pm),
                        ],
                      ),
                    ),
                    _buildSection(
                      title: Localization.venueType,
                      child: const Wrap(
                        spacing: CommonDimensions.chipSpacing,
                        children: [
                          FilterChipWidget(label: Localization.hotel),
                          FilterChipWidget(label: Localization.beachClub),
                          FilterChipWidget(label: Localization.communityClub),
                        ],
                      ),
                    ),
                    _buildSection(
                      title: Localization.hotelFacilities,
                      child: const Wrap(
                        spacing: CommonDimensions.chipSpacing,
                        children: [
                          FilterChipWidget(label: Localization.beach),
                          FilterChipWidget(label: Localization.kidsPool),
                          FilterChipWidget(label: Localization.adultsOnlyPool),
                          FilterChipWidget(label: Localization.rooftopPool),
                          TextButton(
                            onPressed: null,
                            child: Text(Localization.showMore),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          Localization.clearFilters,
                          style: TextStyle(
                            color: CommonColors.clearFiltersText,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CommonColors.buttonBackground,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                CommonDimensions.buttonRadius),
                          ),
                        ),
                        child: const Text(Localization.showResults),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _buildCategoryTabs() {
  return const Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _CategoryTab(label: Localization.poolAndBeach, icon: Icons.waves),
      _CategoryTab(label: Localization.fitness, icon: Icons.fitness_center),
      _CategoryTab(label: Localization.dining, icon: Icons.restaurant),
      _CategoryTab(label: Localization.family, icon: Icons.family_restroom),
    ],
  );
}

Widget _buildSection({required String title, required Widget child}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: CommonDimensions.sectionSpacing),
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: CommonDimensions.chipSpacing),
      child,
    ],
  );
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final IconData icon;

  const _CategoryTab({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: CommonDimensions.categoryIconSpacing),
        Text(
          label,
          style: const TextStyle(fontSize: CommonDimensions.fontSize12),
        ),
      ],
    );
  }
}
