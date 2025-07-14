import 'package:flutter/material.dart';

class SelectableChip extends StatefulWidget {
  final String label;
  final bool initiallySelected;
  final ValueChanged<bool>? onSelected;

  const SelectableChip({
    super.key,
    required this.label,
    this.initiallySelected = false,
    this.onSelected,
  });

  @override
  State<SelectableChip> createState() => _SelectableChipState();
}

class _SelectableChipState extends State<SelectableChip> {
  late bool _isSelected;

  @override
  void initState() {
    super.initState();
    _isSelected = widget.initiallySelected;
  }

  void _toggleSelection() {
    setState(() {
      _isSelected = !_isSelected;
    });
    widget.onSelected?.call(_isSelected);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSelection,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: _isSelected ? const Color(0xFF7A87A0) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isSelected ? Colors.blue : Colors.grey.shade400,
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black,
            fontSize: 14,
            fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}