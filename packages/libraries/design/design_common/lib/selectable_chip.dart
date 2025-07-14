import 'package:design_common/common_colors.dart';
import 'package:design_common/common_dimensions.dart';
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
        padding: const EdgeInsets.symmetric(
          horizontal: CommonDimensions.chipHorizontalPadding,
          vertical: CommonDimensions.chipVerticalPadding,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? CommonColors.chipSelectedBackground
              : CommonColors.chipUnselectedBackground,
          borderRadius: BorderRadius.circular(CommonDimensions.chipRadius),
          border: Border.all(
            color: _isSelected
                ? CommonColors.chipSelectedBorder
                : CommonColors.chipUnselectedBorder,
            width: CommonDimensions.chipBorderWidth,
          ),
          boxShadow: const [
            BoxShadow(
              color: CommonColors.chipShadow,
              blurRadius: CommonDimensions.chipShadowBlur,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          widget.label,
          style: TextStyle(
            color: _isSelected
                ? CommonColors.chipSelectedText
                : CommonColors.chipUnselectedText,
            fontSize: CommonDimensions.chipFontSize,
            fontWeight: _isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
