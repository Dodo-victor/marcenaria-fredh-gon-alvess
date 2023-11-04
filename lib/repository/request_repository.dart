import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';

class RequestRepository extends ChangeNotifier {
  int? _size;

  int get size => _size ?? 0;

  getRequestSize() async {
    final requestSize = await FirestoreMethods().getRequestSize();

    _size = requestSize;
    notifyListeners();
  }
}
