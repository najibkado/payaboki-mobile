import 'package:payaboki/models/data_model.dart';
import 'package:payaboki/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> storeUserData(Data data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', data.user.userId);
    prefs.setString('token', data.user.token);
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', data.user.user.username);
  }

  static Future<void> storeUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', user.userId);
    prefs.setString('token', user.token);
    prefs.setBool('isLoggedIn', true);
    prefs.setString('username', user.user.username);
  }

  static Future<void> storeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('onBoarded', true);
  }

  static Future<bool> isOnboarded() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? onBoarded =
        prefs.getBool('onBoarded') != null ? prefs.getBool('onBoarded') : null;
    if (onBoarded == true) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId =
        prefs.getInt('userId') != null ? prefs.getInt('userId') : null;
    if (userId != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  static clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  static Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? id = prefs.getInt('userId') ?? 0;
    return id;
  }
}
