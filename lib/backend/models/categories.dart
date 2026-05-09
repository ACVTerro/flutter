class CategoriesModel {
  int? id;
  String label;
  String type;

  CategoriesModel ({
    this.id,
    required this.label,
    required this.type
  });

  Map<String, dynamic> toMap() {
    return{
      "id":id,
      "label":label,
      "type":type
    };
  }

  factory CategoriesModel.fromMap(Map<String, dynamic> map) {
    return CategoriesModel(
      id: map["id"],
      label: map["label"], 
      type: map["type"]
      );
  }
}