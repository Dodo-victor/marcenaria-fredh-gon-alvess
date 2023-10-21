import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/models/userModel.dart';
import 'package:fredh_lda/services/pref_service.dart';

class UserRepository extends ChangeNotifier {
  final FirestoreMethods _db = FirestoreMethods();
  final PrefService _prefService = PrefService();

  UserModel? _user;

   get user async  {

    if(_user != null)  {

    return _user!;


    } else {

      final  userLocal = await  _prefService.getUser();

      final UserModel _user = UserModel.fromMap(jsonDecode(userLocal));

      return _user;
    }




  }


  getUser() async {
    final userData = await _db.getUser();
    _user = userData;
    notifyListeners();
  }
}
