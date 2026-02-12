import 'package:spend_wise/feature/expense/domain/entities/category_entity.dart';
import 'package:spend_wise/feature/expense/domain/repositories/category_repository.dart';

class GetCategoriesUseCase {
  final CategoryRepository repository;

  GetCategoriesUseCase({required this.repository});

  Future<List<CategoryEntity>> call() {
    return repository.getCategories();
  }
}
