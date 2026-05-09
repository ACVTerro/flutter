class TransactionsModel {
  int? id;
  double amount;
  int categoryID;
  String? note;
  String date;

  TransactionsModel ({
    this.id,
    required this.amount,
    required this.categoryID,
    this.note,
    required this.date
  });

  Map <String, dynamic> toMap() {
    return {
      "id":id,
      "amount":amount,
      "category_id":categoryID,
      "note":note,
      "transact_date":date
    };
  }

  factory TransactionsModel.fromMap(Map<String, dynamic> map) {
    return TransactionsModel(
      id: map["id"],
      amount: map["amount"],
      categoryID: map["category_id"],
      note: map["note"],
      date: map["transact_date"]
    );
  }
}