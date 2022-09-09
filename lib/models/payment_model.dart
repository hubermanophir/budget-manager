class Payment {
  int? id;
  final String name;
  final int amount;
  final DateTime creationDate;
  final String category;

  Payment({
    this.id,
    required this.name,
    required this.amount,
    required this.creationDate,
    required this.category,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'creationDate': creationDate.toString(),
      'category': category
    };
  }

  @override
  String toString() {
    return 'Payment(id: $id, name: $name, amount:$amount, creationDate:$creationDate, category:$category)';
  }
}
