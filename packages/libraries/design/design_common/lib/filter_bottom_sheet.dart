import 'package:design_common/filter_chip_widget.dart';
import 'package:flutter/material.dart';

void showFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Filter by',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    _buildCategoryTabs(),
                    const Divider(),
                    _buildSection(
                      title: 'City',
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('All UAE'),
                          Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                    _buildSection(
                      title: 'Available for today',
                      child: const Wrap(
                        spacing: 8,
                        children: [
                          FilterChipWidget(label: 'Before 2pm'),
                          FilterChipWidget(label: 'After 2pm'),
                        ],
                      ),
                    ),
                    _buildSection(
                      title: 'Venue type',
                      child: const Wrap(
                        spacing: 8,
                        children: [
                          FilterChipWidget(label: 'Hotel'),
                          FilterChipWidget(label: 'Beach club'),
                          FilterChipWidget(label: 'Community club'),
                        ],
                      ),
                    ),
                    _buildSection(
                      title: 'Hotel facilities',
                      child: const Wrap(
                        spacing: 8,
                        children: [
                          FilterChipWidget(label: 'Beach'),
                          FilterChipWidget(label: 'Kids pool'),
                          FilterChipWidget(label: 'Adults-only pool'),
                          FilterChipWidget(label: 'Rooftop pool'),
                          TextButton(onPressed: null, child: Text('Show more')),
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
                          'Clear filters',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7A87A0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text('Show results'),
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
      _CategoryTab(label: 'Pool & Beach', icon: Icons.waves),
      _CategoryTab(label: 'Fitness', icon: Icons.fitness_center),
      _CategoryTab(label: 'Dining', icon: Icons.restaurant),
      _CategoryTab(label: 'Family', icon: Icons.family_restroom),
    ],
  );
}

Widget _buildSection({required String title, required Widget child}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 8),
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
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
