import 'package:expense_tracker/feature/expense/data/database/app_database.dart';

class CategoryLocalDataSource {
  final AppDatabase database;

  CategoryLocalDataSource(this.database);

  Future<List<Category>> getCategories() async {
    final count = await database.getCategories();

    if (count == 0) {
      await _seedDefaultCategories();
    }
    return database.getCategories();
  }

  Future<void> _seedDefaultCategories() async {
    final data = [
      CategoriesCompanion.insert(id: 'food', name: 'Food', type: 'expense'),
      CategoriesCompanion.insert(id: 'rent', name: 'Rent', type: 'expense'),
      CategoriesCompanion.insert(id: 'travel', name: 'Travel', type: 'expense'),
      CategoriesCompanion.insert(
        id: 'misc',
        name: 'Miscellaneous',
        type: 'expense',
      ),
      CategoriesCompanion.insert(id: 'salary', name: 'Salary', type: 'income'),
    ];

    await database.insertCategories(data);
  }
}
