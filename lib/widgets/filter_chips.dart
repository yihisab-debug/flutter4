import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onChanged;

  const FilterChips({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _chip('all', 'Все', Icons.list),

          const SizedBox(width: 8),

          _chip('bought', 'Куплено', Icons.check_circle_outline),

          const SizedBox(width: 8),

          _chip('pending', 'Не куплено', Icons.radio_button_unchecked),
        ],
      ),
    );
  }

  Widget _chip(String value, String label, IconData icon) {
    final isSelected = selected == value;
    return ChoiceChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: isSelected ? Colors.white : Colors.grey.shade700,
          ),

          const SizedBox(width: 4),

          Text(label),
        ],
      ),

      selected: isSelected,
      selectedColor: Colors.green,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.grey.shade700,
        fontSize: 13,
      ),
      onSelected: (_) => onChanged(value),
    );
  }
}
