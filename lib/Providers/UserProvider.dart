import 'package:flutter/foundation.dart';
import 'package:github_following/Models/User.dart';

class UserProvider with ChangeNotifier {
  User user;
  String errorMessage;
  bool loading = false;

  Future<bool> fetchUser(username) async {
    setLoading(true);
  }

  void setLoading(payload) {
    loading = payload;
    notifyListeners();
  }
}
