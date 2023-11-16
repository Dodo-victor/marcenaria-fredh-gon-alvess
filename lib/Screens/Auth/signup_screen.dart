import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/Methods/auth_methods.dart';
import 'package:fredh_lda/Screens/Auth/login_screen.dart';
import 'package:fredh_lda/Widgets/custom_input.dart';
import 'package:fredh_lda/Widgets/submit_button.dart';
import 'package:fredh_lda/models/userModel.dart';
import 'package:fredh_lda/utilis/colors.dart';
import 'package:fredh_lda/utilis/show_snack_bar.dart';

import '../bottom_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

bool _isLoading = false;

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  _signUp(context) async {
    if (_nameController.text.isNotEmpty ||
        _emailController.text.isNotEmpty ||
        _passwordController.text.isNotEmpty ||
        _phoneController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      UserModel userModel = UserModel(
        name: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        password: _passwordController.text,
        type: "user",
        uid: "", photoUrl: null,
      );
      final res =
          await _authMethods.signupUp(userModel: userModel, context: context);
      setState(() {
        _isLoading = false;
      });
      if (res == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
            (route) => false);
      }
    } else {
      showSnackBar(
        context: context,
        content: 'Preencha todos os campos por favor',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: size.height * 0.4,
                  //decoration: const BoxDecoration(),
                  child:  Text(
                    'Criar Conta',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 28),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: size.height * 0.6,
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: ColorsApp.primaryColorTheme,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorsApp.googleSignColor,
                                )
                              ]),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                CustomInput(
                                  title: "Nome",
                                  controller: _nameController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomInput(
                                  title: "Email",
                                  controller: _emailController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomInput(
                                  title: "Telefone",
                                  controller: _phoneController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomInput(
                                  title: "Senha",
                                  controller: _passwordController,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                SubmitButton(
                                  isLoading: _isLoading,
                                  function: () async {
                                    await _signUp(context);
                                  },
                                  title: "Criar Conta",
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Já tem uma conta?'),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginScreen()));
                                      },
                                      child: Text(
                                        'Inicie a sessão',
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
