import 'package:expense_tracker/feature/expense/domain/entities/user_entity.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/user_repository.dart';

class SaveUserUsecase {
  final UserRepository repository;

  SaveUserUsecase({required this.repository});

  Future<void> call(UserEntity user) {
    return repository.saveUser(user);
  }
}
