import 'package:flutter/material.dart';

class FilterChipWidget extends StatefulWidget {
  final String label;

  const FilterChipWidget({super.key, required this.label});

  @override
  State<FilterChipWidget> createState() => _FilterChipWidgetState();
}

class _FilterChipWidgetState extends State<FilterChipWidget> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(widget.label),
      selected: isSelected,
      onSelected: (val) {
        setState(() => isSelected = val);
      },
    );
  }
}