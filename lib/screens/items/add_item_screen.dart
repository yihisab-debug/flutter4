import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/shopping_item.dart';
import '../../providers/shopping_provider.dart';

class AddItemScreen extends StatefulWidget {
  final String listId;
  final ShoppingItem? item;
  const AddItemScreen({super.key, required this.listId, this.item});
  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final _nameCtrl = TextEditingController();
  final _qtyCtrl = TextEditingController(text: '1');
  final _priceCtrl = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    if (widget.item != null) {
      _nameCtrl.text = widget.item!.name;
      _qtyCtrl.text = widget.item!.quantity.toString();
      _priceCtrl.text = widget.item!.price.toString();
    }
  }

  Future<void> _save() async {
    final shop = context.read<ShoppingProvider>();
    final item = ShoppingItem(
      id: widget.item?.id ?? '',
      name: _nameCtrl.text,
      quantity: int.tryParse(_qtyCtrl.text) ?? 1,
      price: double.tryParse(_priceCtrl.text) ?? 0,
      isBought: widget.item?.isBought ?? false,
      listId: widget.listId,
      addedAt: widget.item?.addedAt ?? DateTime.now().millisecondsSinceEpoch,
      category: widget.item?.category ?? '',
      note: widget.item?.note ?? '',
      dueDate: widget.item?.dueDate ?? 0,
    );
    if (widget.item == null) {
      await shop.addItem(item);
    } else {
      await shop.updateItem(item);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.item == null ? 'Добавить товар' : 'Редактировать товар',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                controller: _nameCtrl,
                decoration: const InputDecoration(
                  labelText: 'Название товара',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _qtyCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Количество',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: TextField(
                      controller: _priceCtrl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Цена (₸)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: _save,
                child: Text(widget.item == null ? 'Добавить' : 'Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
