import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fredh_lda/services/pref_service.dart';
import 'package:fredh_lda/utilis/colors.dart';

class ThemeDataManagerRepository extends ChangeNotifier {
  static final ThemeDataManagerRepository instance =
  ThemeDataManagerRepository();

  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  final PrefService _prefService = PrefService();

  loadTheme() async {
    final isDarkTheme = await _prefService.getTheme();

    print(isDarkTheme);

    _isDarkTheme = isDarkTheme;

    notifyListeners();
  }

  themeData(context) {
    if (_isDarkTheme) {
      return ThemeData.dark().copyWith(
          brightness: Brightness.dark,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.black54),
          scaffoldBackgroundColor:  Colors.black38,
        navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.black54,
            surfaceTintColor: Colors.black38,
            indicatorColor: ColorsApp.primaryColorTheme,
            elevation: 30,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected),
        // primaryColorDark: ColorsApp.primaryColorTheme,

        //scaffoldBackgroundColor: Colors.grey.shade800,
          textTheme: TextTheme(
            titleMedium: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            titleSmall:  TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),


        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.black
        )
      );
    } else {
      return ThemeData.light().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade200,

        primaryColorLight: Colors.grey.shade200,
        navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.grey.shade200,
            surfaceTintColor: Colors.grey.shade200,
            indicatorColor: ColorsApp.primaryColorTheme,
            elevation: 20,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected),

        dividerTheme: const DividerThemeData(color: Colors.grey),
        cardTheme: CardTheme(
          color: Colors.grey.shade200,
          surfaceTintColor: Colors.grey.shade300,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 20,
          shadowColor: ColorsApp.googleSignColor,
        ),
        brightness: Brightness.light,

        appBarTheme: AppBarTheme(backgroundColor: ColorsApp.primaryColorTheme),

        dividerColor: Colors.grey,

        //textTheme: const TextTheme()
      );
    }
  }

  changeTheme() async {
    _isDarkTheme = !_isDarkTheme;
    await _prefService.saveTheme(_isDarkTheme);
    notifyListeners();
  }
}
