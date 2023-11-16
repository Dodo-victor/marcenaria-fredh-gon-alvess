import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/models/userModel.dart';
import 'package:fredh_lda/services/pref_service.dart';

class UserRepository extends ChangeNotifier {
  final FirestoreMethods _db = FirestoreMethods();
  final PrefService _prefService = PrefService();

  UserModel? _user;
  UserModel? _localUser;

  get user {
    if (_user != null) {
      return _user!;
    } else {
      if (_localUser != null) {
        return _localUser!;
      }
    }
  }

  updateData({required Map<Object, Object> data}) async {
    await FirestoreMethods().updateData(data: data);
    await getUser();


  }

  getUser() async {
    final userData = await _db.getUser();
    _user = userData;
    final userLocal = await _prefService.getUser();

    if (userLocal != null) {
      final user = await jsonDecode(userLocal);
      UserModel userModel = UserModel.fromMap(user);
      _localUser = userModel;
    }

    notifyListeners();
  }
}
