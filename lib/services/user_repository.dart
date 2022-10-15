import 'package:cubit_test_app01/model/user.dart';
import 'package:cubit_test_app01/services/user_api_provider.dart';

class UserRepository {
  final UserProvider _userProvider = UserProvider();
  Future<List<User>> getAllUsers() => _userProvider.getUsers();
}