class ShoppingList {
  final String id;
  final String title;
  final String description;
  final int createdAt;
  final String userId;
  final bool isArchived;

  ShoppingList({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.userId,
    required this.isArchived,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) => ShoppingList(
    id: json['id'].toString(),
    title: json['title'] ?? '',
    description: json['description'] ?? '',
    createdAt: int.tryParse(json['createdAt'].toString()) ?? 0,
    userId: json['userId'] ?? '',
    isArchived: json['isArchived'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'createdAt': createdAt,
    'userId': userId,
    'isArchived': isArchived,
  };
}
