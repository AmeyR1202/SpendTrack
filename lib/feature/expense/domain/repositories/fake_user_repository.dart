import 'package:expense_tracker/feature/expense/domain/entities/user_entity.dart';
import 'package:expense_tracker/feature/expense/domain/repositories/user_repository.dart';

class FakeUserRepository implements UserRepository {
  @override
  Future<UserEntity?> getUser() async {
    /// Simulate no users exists
    return null;
  }

  @override
  Future<void> saveUser(UserEntity user) async {
    // no - operation
  }
}
