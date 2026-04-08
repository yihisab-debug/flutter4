class ShoppingItem {
  final String id;
  String name;
  int quantity;
  double price;
  bool isBought;
  final String listId;
  final int addedAt;
  String category;
  String note;
  int dueDate;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.isBought,
    required this.listId,
    required this.addedAt,
    required this.category,
    required this.note,
    required this.dueDate,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) => ShoppingItem(
    id: json['id'].toString(),
    name: json['name'] ?? '',
    quantity: int.tryParse(json['quantity'].toString()) ?? 1,
    price: double.tryParse(json['price'].toString()) ?? 0.0,
    isBought: json['isBought'] ?? false,
    listId: json['listId']?.toString() ?? '',
    addedAt: int.tryParse(json['addedAt'].toString()) ?? 0,
    category: json['category'] ?? '',
    note: json['note'] ?? '',
    dueDate: int.tryParse(json['dueDate'].toString()) ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'quantity': quantity,
    'price': price,
    'isBought': isBought,
    'listId': listId,
    'addedAt': addedAt,
    'category': category,
    'note': note,
    'dueDate': dueDate,
  };
}
