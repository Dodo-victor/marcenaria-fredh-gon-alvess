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
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black),

        // brightness: Brightness.dark,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
            backgroundColor: ColorsApp.darkBackgroundColor,
            surfaceTintColor: ColorsApp.darkSurfaceColor),
        // scaffoldBackgroundColor: Colors.black38,
        navigationBarTheme: NavigationBarThemeData(
            backgroundColor: ColorsApp.darkBackgroundColor,
            surfaceTintColor: ColorsApp.darkSurfaceColor,
            indicatorColor: ColorsApp.primaryColorTheme,
            elevation: 30,
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected),

        brightness: Brightness.dark,
        scaffoldBackgroundColor: ColorsApp.darkBackgroundColor,
        cardColor: ColorsApp.darkSurfaceColor,
        primaryColor: ColorsApp.darkAccentColor,
        hintColor: ColorsApp.darkAccentColor,
        textTheme: TextTheme(
          titleMedium: TextStyle(
            color: ColorsApp.darkTextColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(color: ColorsApp.darkTextColor),
          titleSmall: TextStyle(
            color: ColorsApp.darkSecondaryTextColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.grey.shade200),
      );

      // primaryColorDark: ColorsApp.primaryColorTheme,

      //scaffoldBackgroundColor: Colors.grey.shade800,
      /*  textTheme: TextTheme(
            titleMedium: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
            titleSmall: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),*/
    } else {
      return ThemeData.light().copyWith(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: ColorsApp.lightBackgroundColor,
        cardColor: ColorsApp.lightSurfaceColor,
        primaryColor: ColorsApp.lightAccentColor,
        hintColor: ColorsApp.lightAccentColor,
        textTheme: TextTheme(
          titleMedium: TextStyle(
              color: ColorsApp.lightTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          titleSmall: TextStyle(
              color: ColorsApp.lightSecondaryTextColor,
              fontSize: 15,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: ColorsApp.lightTextColor),
        ),
        iconTheme: IconThemeData(color: Colors.black),

        // scaffoldBackgroundColor: Colors.grey.shade200,
        /*  textTheme: const TextTheme(
          titleMedium: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            color: Colors.black45,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),*/

        // primaryColorLight: Colors.grey.shade200,
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
