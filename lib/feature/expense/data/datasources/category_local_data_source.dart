import 'package:spend_wise/feature/expense/data/database/app_database.dart';

class CategoryLocalDataSource {
  final AppDatabase database;

  CategoryLocalDataSource(this.database);

  Future<List<Category>> getCategories() async {
    final count = await database.getCategories();

    if (count.isEmpty) {
      await _seedDefaultCategories();
    }
    return database.getCategories();
  }

  Future<void> _seedDefaultCategories() async {
    final data = [
      CategoriesCompanion.insert(id: 'fuel', name: 'Fuel', type: 'expense'),
      CategoriesCompanion.insert(id: 'repair', name: 'Repair', type: 'expense'),
      CategoriesCompanion.insert(
        id: 'service',
        name: 'Service',
        type: 'expense',
      ),
      CategoriesCompanion.insert(
        id: 'maintenance',
        name: 'Maintenance',
        type: 'expense',
      ),
      CategoriesCompanion.insert(id: 'salary', name: 'Salary', type: 'income'),
      CategoriesCompanion.insert(
        id: 'opening',
        name: 'Opening Balance',
        type: 'income',
      ),
    ];

    await database.insertCategories(data);
  }
}
