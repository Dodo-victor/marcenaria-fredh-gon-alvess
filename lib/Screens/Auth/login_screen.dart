import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/Methods/auth_methods.dart';
import 'package:fredh_lda/Screens/Auth/signup_screen.dart';
import 'package:fredh_lda/Screens/bottom_bar.dart';
import 'package:fredh_lda/Widgets/custom_input.dart';
import 'package:fredh_lda/Widgets/submit_button.dart';
import 'package:fredh_lda/utilis/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool _isLoading = false;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();

  _login(context) async {
    setState(() {
      _isLoading = true;
    });
    final res = await _authMethods.login(
        email: _emailController.text,
        password: _passwordController.text,
        context: context);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: _size.height * 0.5,
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              "Fredh LDA",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /*    SizedBox(
                height: _size.height *0.5,
                width: double.infinity,
                child: Card(
                  shape:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  color: ColorsApp.primaryColorTheme.withOpacity(0.5),
                  
                ),
              ) */

              Container(
                height: _size.height * 0.5,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorsApp.primaryColorTheme,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: ColorsApp.googleSignColor,
                          spreadRadius: 20,
                          offset: Offset.infinite)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      /// mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                          title: "Senha",
                          controller: _passwordController,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SubmitButton(
                          title: "Entrar",
                          isLoading: _isLoading,
                          function: (){
                            _login(context);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Não tem uma conta?"),
                            const SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SignupScreen()));
                              },
                              child: Text(
                                "Crie uma aqui!",
                                style:
                                    TextStyle(color: ColorsApp.googleSignColor),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Expanded(
                                child: Divider(
                              endIndent: 15,
                              thickness: 4,
                            )),
                            Text("Ou"),
                            Expanded(
                                child: Divider(
                              indent: 15,
                              thickness: 4,
                            )),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 40,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorsApp.googleSignColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/google.png",
                                height: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Entrar Com O Google",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
