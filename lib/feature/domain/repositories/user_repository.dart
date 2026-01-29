import 'package:expense_tracker/feature/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<UserEntity?> getUser();
  Future<void> saveUser(UserEntity user);
}
