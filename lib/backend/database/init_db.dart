import 'package:tipidbuddy/backend/models/categories.dart';
import 'package:tipidbuddy/backend/services/categories_services.dart';

class DatabaseInitializer {
  static Future<void> init() async {
    final categories = await CategoryServices.getAll();
    if (categories.isEmpty) {
      await CategoryServices.insert(CategoriesModel(label: 'Salary', type: 'income'));
      await CategoryServices.insert(CategoriesModel(label: 'Freelance', type: 'income'));
      await CategoryServices.insert(CategoriesModel(label: 'Allowance', type: 'income'));
      await CategoryServices.insert(CategoriesModel(label: 'Food', type: 'expense'));
      await CategoryServices.insert(CategoriesModel(label: 'Transport', type: 'expense'));
      await CategoryServices.insert(CategoriesModel(label: 'Rent', type: 'expense'));
      await CategoryServices.insert(CategoriesModel(label: 'Utilities', type: 'expense'));
      await CategoryServices.insert(CategoriesModel(label: 'Entertainment', type: 'expense'));
    }
  }
}