import 'package:expense_tracker/feature/expense/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser();
  Future<void> saveUser(UserEntity user);
}
