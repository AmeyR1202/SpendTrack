import 'package:expense_tracker/feature/expense/data/datasources/category_local_data_source.dart';
import 'package:expense_tracker/feature/expense/domain/entities/category_entity.dart';
import 'package:expense_tracker/feature/expense/domain/entities/category_type.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl(this.localDataSource);

  @override
  Future<List<CategoryEntity>> getCategories() async {
    final categories = await localDataSource.getCategories();
    return categories
        .map(
          (c) => CategoryEntity(
            categoryId: c.id,
            categoryName: c.name,
            type: c.type == 'income'
                ? CategoryType.income
                : CategoryType.expense,
          ),
        )
        .toList();
  }
}
