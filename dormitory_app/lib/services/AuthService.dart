import 'package:dormitorycpfapp/models/User.dart';

class AuthService {
  Future login({User user}) async {
    if (user.Username == "admin@gmail.com" && user.Password == "password") {
      return true;
    }
    return false;
  }
}
