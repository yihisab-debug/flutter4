import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/shopping_list.dart';
import '../models/shopping_item.dart';

class ApiService {
  static const _base = 'https://6939834cc8d59937aa082275.mockapi.io';

  Future<List<ShoppingList>> getLists(String userId) async {
    final res = await http.get(Uri.parse('$_base/project'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data
          .map((j) => ShoppingList.fromJson(j))
          .where((l) => l.userId == userId)
          .toList();
    }
    throw Exception('Ошибка загрузки списков');
  }

  Future<ShoppingList> createList(ShoppingList list) async {
    final res = await http.post(
      Uri.parse('$_base/project'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(list.toJson()),
    );
    if (res.statusCode == 201) {
      return ShoppingList.fromJson(jsonDecode(res.body));
    }
    throw Exception('Ошибка создания списка');
  }

  Future<void> deleteList(String id) async {
    await http.delete(Uri.parse('$_base/project/$id'));
  }

  Future<List<ShoppingItem>> getItems(String listId) async {
    final res = await http.get(Uri.parse('$_base/image'));
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data
          .map((j) => ShoppingItem.fromJson(j))
          .where((i) => i.listId == listId)
          .toList();
    }
    throw Exception('Ошибка загрузки товаров');
  }

  Future<ShoppingItem> createItem(ShoppingItem item) async {
    final res = await http.post(
      Uri.parse('$_base/image'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (res.statusCode == 201) {
      return ShoppingItem.fromJson(jsonDecode(res.body));
    }
    throw Exception('Ошибка создания товара');
  }

  Future<ShoppingItem> updateItem(ShoppingItem item) async {
    final res = await http.put(
      Uri.parse('$_base/image/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );
    if (res.statusCode == 200) {
      return ShoppingItem.fromJson(jsonDecode(res.body));
    }
    throw Exception('Ошибка обновления товара');
  }

  Future<void> deleteItem(String id) async {
    await http.delete(Uri.parse('$_base/image/$id'));
  }
}
