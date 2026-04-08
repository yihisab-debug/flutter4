import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/shopping_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final shop = context.watch<ShoppingProvider>();
    final bought = shop.boughtItems;
    return Scaffold(
      appBar: AppBar(title: const Text('История покупок')),
      body: bought.isEmpty
          ? const Center(child: Text('Ещё ничего не куплено'))
          : ListView.builder(
              itemCount: bought.length,
              itemBuilder: (ctx, i) {
                final item = bought[i];
                return ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),

                  title: Text(item.name),

                  subtitle: Text(
                    '${item.quantity} шт. — ${item.price} ₸  •  ${item.addedAt}',
                  ),

                  trailing: TextButton(
                    child: const Text('Восстановить'),
                    onPressed: () => shop.toggleBought(item),
                  ),
                );
              },
            ),
    );
  }
}
