import 'package:expense_tracker/feature/expense/domain/entities/category_type.dart';

class CategoryEntity {
  final String categoryId;
  final String categoryName;
  final CategoryType type;

  CategoryEntity({
    required this.categoryId,
    required this.categoryName,
    required this.type,
  });
}
