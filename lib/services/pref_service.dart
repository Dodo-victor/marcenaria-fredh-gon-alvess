import 'dart:convert';

import 'package:fredh_lda/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PrefService {




  setUser({ required UserModel user}) async{



    final prefService = await SharedPreferences.getInstance();

   await prefService.setString("user",jsonEncode(user.toMap()),);

  }

  getUser() async {

    final prefService = await SharedPreferences.getInstance();

   final user =  prefService.get("user");

   print(user);

  return user;

  }

  saveTheme({ bool value = false}) async {
    final prefService = await SharedPreferences.getInstance();

   await prefService.setBool("theme", value);
  }

  getTheme() async {
    final prefService = await SharedPreferences.getInstance();

    final theme =  prefService.getBool("theme");

    print(theme);

    return theme;

  }
}