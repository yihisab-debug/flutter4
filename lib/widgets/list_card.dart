import 'package:flutter/material.dart';
import '../models/shopping_list.dart';

class ListCard extends StatelessWidget {
  final ShoppingList list;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ListCard({
    super.key,
    required this.list,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),

        leading: CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const Icon(Icons.shopping_basket, color: Colors.green),
        ),

        title: Text(
          list.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),

        subtitle: Text(
          'Создан: ${list.createdAt}',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
          tooltip: 'Удалить список',
        ),

        onTap: onTap,
      ),
    );
  }
}
