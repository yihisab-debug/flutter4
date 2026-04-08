import 'package:flutter/material.dart';
import '../models/shopping_list.dart';
import '../models/shopping_item.dart';
import '../services/api_service.dart';

class ShoppingProvider extends ChangeNotifier {
  final _api = ApiService();
  List<ShoppingList> _lists = [];
  List<ShoppingItem> _items = [];
  bool _loading = false;
  String? _error;

  List<ShoppingList> get lists => _lists;
  List<ShoppingItem> get items => _items;
  bool get loading => _loading;
  String? get error => _error;

  List<ShoppingItem> get boughtItems =>
      _items.where((i) => i.isBought).toList();
  List<ShoppingItem> get pendingItems =>
      _items.where((i) => !i.isBought).toList();

  Future<void> loadLists(String userId) async {
    _loading = true;
    notifyListeners();
    try {
      _lists = await _api.getLists(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addList(ShoppingList list) async {
    final created = await _api.createList(list);
    _lists.add(created);
    notifyListeners();
  }

  Future<void> removeList(String id) async {
    await _api.deleteList(id);
    _lists.removeWhere((l) => l.id == id);
    notifyListeners();
  }

  Future<void> loadItems(String listId) async {
    _loading = true;
    notifyListeners();
    try {
      _items = await _api.getItems(listId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> addItem(ShoppingItem item) async {
    final created = await _api.createItem(item);
    _items.add(created);
    notifyListeners();
  }

  Future<void> toggleBought(ShoppingItem item) async {
    item.isBought = !item.isBought;
    await _api.updateItem(item);
    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    await _api.deleteItem(id);
    _items.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  List<ShoppingItem> search(String query) {
    return _items
        .where((i) => i.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> updateItem(ShoppingItem item) async {
    final updated = await _api.updateItem(item);
    final idx = _items.indexWhere((i) => i.id == updated.id);
    if (idx != -1) _items[idx] = updated;
    notifyListeners();
  }

  void reorderItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;

    final item = _items.removeAt(oldIndex);
    _items.insert(newIndex, item);

    notifyListeners();
  }
}
