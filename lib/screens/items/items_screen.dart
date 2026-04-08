import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/shopping_list.dart';
import '../../models/shopping_item.dart';
import '../../providers/shopping_provider.dart';
import 'add_item_screen.dart';

class ItemsScreen extends StatefulWidget {
  final ShoppingList list;
  const ItemsScreen({super.key, required this.list});
  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  String _filter = 'all';
  String _search = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShoppingProvider>().loadItems(widget.list.id);
    });
  }

  List<ShoppingItem> _filtered(List<ShoppingItem> all) {
    return all.where((i) {
      final matchSearch = i.name.toLowerCase().contains(_search.toLowerCase());
      final matchFilter =
          _filter == 'all' ||
          (_filter == 'bought' && i.isBought) ||
          (_filter == 'pending' && !i.isBought);
      return matchSearch && matchFilter;
    }).toList();
  }

  void _confirmDeleteItem(String id) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Удалить товар?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Нет'),
          ),

          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<ShoppingProvider>().removeItem(id);
              Navigator.pop(context);
            },
            child: const Text('Да', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<ShoppingProvider>();
    final displayed = _filtered(shop.items);
    return Scaffold(
      appBar: AppBar(title: Text(widget.list.title)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Поиск по товарам...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) => setState(() => _search = v),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ChoiceChip(
                label: const Text('Все'),
                selected: _filter == 'all',
                onSelected: (_) => setState(() => _filter = 'all'),
              ),

              const SizedBox(width: 8),

              ChoiceChip(
                label: const Text('Куплено'),
                selected: _filter == 'bought',
                onSelected: (_) => setState(() => _filter = 'bought'),
              ),

              const SizedBox(width: 8),

              ChoiceChip(
                label: const Text('Не куплено'),
                selected: _filter == 'pending',
                onSelected: (_) => setState(() => _filter = 'pending'),
              ),
            ],
          ),

          Expanded(
            child: shop.loading
                ? const Center(child: CircularProgressIndicator())
                : ReorderableListView.builder(
                    itemCount: displayed.length,
                    onReorder: (oldIdx, newIdx) {
                      shop.reorderItems(oldIdx, newIdx);
                    },
                    itemBuilder: (ctx, i) {
                      final item = displayed[i];
                      return Card(
                        key: ValueKey(item.id),

                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),

                        child: ListTile(
                          leading: Checkbox(
                            value: item.isBought,
                            onChanged: (_) => shop.toggleBought(item),
                          ),

                          title: Text(
                            item.name,
                            style: TextStyle(
                              decoration: item.isBought
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),

                          subtitle: Text(
                            '${item.quantity} шт. — ${item.price} ₸',
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => AddItemScreen(
                                      listId: widget.list.id,
                                      item: item,
                                    ),
                                  ),
                                ),
                              ),

                              IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () => _confirmDeleteItem(item.id),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddItemScreen(listId: widget.list.id),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
