import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/shopping_provider.dart';
import '../../models/shopping_list.dart';
import '../items/items_screen.dart';
import '../history/history_screen.dart';

class ListsScreen extends StatefulWidget {
  const ListsScreen({super.key});
  @override
  State<ListsScreen> createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthProvider>().user!.uid;
      context.read<ShoppingProvider>().loadLists(userId);
    });
  }

  void _createList() {
    final ctrl = TextEditingController();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Новый список'),

        content: TextField(
          controller: ctrl,
          decoration: const InputDecoration(hintText: 'Название списка'),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),

          ElevatedButton(
            onPressed: () {
              final userId = context.read<AuthProvider>().user!.uid;
              context.read<ShoppingProvider>().addList(
                ShoppingList(
                  id: '',
                  title: ctrl.text,
                  description: '',
                  createdAt: DateTime.now().millisecondsSinceEpoch,
                  userId: userId,
                  isArchived: false,
                ),
              );
              Navigator.pop(context);
            },
            child: const Text('Создать'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Удалить список?'),
        content: const Text('Это действие нельзя отменить.'),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Отмена'),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<ShoppingProvider>().removeList(id);
              Navigator.pop(context);
            },
            child: const Text('Удалить', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<ShoppingProvider>();
    final auth = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои списки покупок'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const HistoryScreen()),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => auth.signOut(),
          ),
        ],
      ),

      body: shop.loading
          ? const Center(child: CircularProgressIndicator())
          : shop.lists.isEmpty
          ? const Center(child: Text('Нет списков. Создай первый! 🛒'))
          : ListView.builder(
              itemCount: shop.lists.length,
              itemBuilder: (ctx, i) {
                final list = shop.lists[i];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),

                  child: ListTile(
                    leading: const Icon(
                      Icons.shopping_basket,
                      color: Colors.green,
                    ),

                    title: Text(
                      list.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    subtitle: Text('Создан: ${list.createdAt}'),

                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () => _confirmDelete(list.id),
                    ),

                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ItemsScreen(list: list),
                      ),
                    ),
                  ),
                );
              },
            ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _createList,
        icon: const Icon(Icons.add),
        label: const Text('Новый список'),
      ),
    );
  }
}
