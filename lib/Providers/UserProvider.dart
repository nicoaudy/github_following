import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:github_following/Models/User.dart';
import 'package:github_following/Requests/GithubRequest.dart';

class UserProvider with ChangeNotifier {
  User user;
  String errorMessage;
  bool loading = false;

  Future<bool> fetchUser(username) async {
    setLoading(true);

    await Github(username).fetchUser().then((data) {
      setLoading(false);

      if (data.statusCode == 200) {
        setUser(User.fromJson(json.decode(data.body)));
      } else {
        print(data.body);
        Map<String, dynamic> result = json.decode(data.body);
        setMessage(result['message']);
      }
    });

    return isUser();
  }

  void setLoading(payload) {
    loading = payload;
    notifyListeners();
  }

  bool isLoading() {
    return loading;
  }

  void setUser(payload) {
    user = payload;
    notifyListeners();
  }

  User getUser() {
    return user;
  }

  void setMessage(payload) {
    errorMessage = payload;
    notifyListeners();
  }

  String getMessage() {
    return errorMessage;
  }

  bool isUser() {
    return user != null ? true : false;
  }
}
