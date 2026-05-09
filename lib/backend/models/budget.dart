class BudgetModel {
  int? id;
  int categoryID;
  double budgetAmount;
  String? status;
  String? month;
  String? note;

  BudgetModel({
    this.id,
    required this.categoryID,
    required this.budgetAmount,
    this.status,
    this.month,
    this.note
  });

  Map <String, dynamic> toMap() {
    return {
      "id":id,
      "category_id":categoryID,
      "budget_amount":budgetAmount,
      "status":status,
      "month":month,
      "note":note
    };
  }

  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      id: map["id"],
      categoryID: map["category_id"], 
      budgetAmount: map["budget_amount"],
      status: map["status"],
      month: map["month"],
      note: map["note"]
      );
  }
}