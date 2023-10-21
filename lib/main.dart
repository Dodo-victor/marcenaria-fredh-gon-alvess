import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/Methods/auth_methods.dart';
import 'package:fredh_lda/Screens/Auth/login_screen.dart';
import 'package:fredh_lda/Screens/bottom_bar.dart';
import 'package:fredh_lda/firebase_options.dart';
import 'package:fredh_lda/repository/theme_manager_repository.dart';
import 'package:fredh_lda/repository/user_repository.dart';
import 'package:fredh_lda/utilis/colors.dart';


final userProvider = ChangeNotifierProvider((ref) => UserRepository());
final themeDataManagerProvider = ChangeNotifierProvider((ref) => ThemeDataManagerRepository.instance);

void main() async {
   
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  final AuthMethods _authMethods = AuthMethods();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeDataManager = ref.watch(themeDataManagerProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: themeDataManager.themeData(context), /* ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        backgroundColor: Colors.grey.shade300,

        useMaterial3: true,
        primarySwatch: Colors.blue,
      ), */
      home: StreamBuilder(
        stream: _authMethods.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitPumpingHeart(
                color: ColorsApp.primaryColorTheme,
              ),
            );
          }
          if (snapshot.hasData) {
            return const BottomBar();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
