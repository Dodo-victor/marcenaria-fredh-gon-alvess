import 'package:flutter/material.dart';
import 'package:fredh_lda/utilis/colors.dart';

class ThemeDataManagerRepository extends ChangeNotifier {

  static final ThemeDataManagerRepository instance = ThemeDataManagerRepository();

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeData themeData(context) {
    if (_isDarkTheme) {
      return ThemeData.dark(
        
      ).copyWith(
        useMaterial3: true,
       // primaryColorDark: ColorsApp.primaryColorTheme,
      
        //scaffoldBackgroundColor: Colors.grey.shade800,

      );
    } else {
      return ThemeData.light().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade100,
        
      
        appBarTheme: AppBarTheme(
          backgroundColor: ColorsApp.primaryColorTheme
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      );
    }
  }

  changeTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }
}
