import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Screens/Auth/login_screen.dart';
import 'package:fredh_lda/Widgets/custom_input.dart';
import 'package:fredh_lda/Widgets/submit_button.dart';
import 'package:fredh_lda/main.dart';
import 'package:fredh_lda/models/userModel.dart';
import 'package:fredh_lda/services/pref_service.dart';

import 'package:fredh_lda/utilis/colors.dart';
import 'package:fredh_lda/utilis/show_snack_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

bool _isChangeName = false;

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _userInformationLoader({required userData, required property}) {
    if (userData != null) {
      return Text(property);
    } else {
      return Container(
        height: 10,
        width: 80,
        decoration: BoxDecoration(
            color: Colors.grey.shade500,
            borderRadius: BorderRadius.circular(10)),
      );
    }
  }

  final userDataProvider = FutureProvider<UserModel>((ref) async {
    final userData = await FirestoreMethods().getUser();
    return userData;
  });

  final TextEditingController _updateNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, WidgetRef ref, child) {
      final UserModel? userData = ref.watch(userProvider).user;
      final userDataProv = ref.watch(userDataProvider);
      final themeDataManger = ref.watch(themeDataManagerProvider);
      return RefreshIndicator(
        onRefresh: () async{
          await Future.delayed( const Duration(seconds: 5));
          userDataProv.isReloading;
          setState(() {

          });

        },
        child: Scaffold(
          appBar: AppBar(
              title: _userInformationLoader(
            userData: userDataProv
                .whenData(
                  (value) => value,
                )
                .value,
            property: 'Olá ${userDataProv.whenData((value) => value.name).value}',
          )),
          body: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                child: userDataProv.when(data: (value) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(value.name),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(value.email),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(value.phone),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }, error: (error, stackTrace) {
                  return const Center(
                    child: Text("Ocorreu um erro desconhecido"),
                  );
                }, loading: () {
                  return Column(
                    children: [
                      Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: 10,
                        width: 80,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade500,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  );
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: SizedBox(
                                  height: size.height * 0.3,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        const Text(
                                          "Alterar O Nome",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        CustomInput(
                                          title: "Introduza o novo nome",
                                          controller: _updateNameController,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        SubmitButton(
                                          title: "Alterar",
                                          width: 250,
                                          height: 40,
                                          //isLoading: _isChangeName,
                                          color: ColorsApp.primaryColorTheme,
                                          function: () async {
                                            try {


                                              if (_updateNameController
                                                  .text.isNotEmpty) {
                                                await FirestoreMethods()
                                                    .changeName(
                                                        newName:
                                                            _updateNameController
                                                                .text);
                                                Navigator.pop(context);
                                                showSnackBar(
                                                    context: context,
                                                    content:
                                                        "Nome atualizado com sucesso");
                                              } else {
                                                showSnackBar(
                                                    context: context,
                                                    content:
                                                        "Insira o nome por favor");
                                              }
                                            } catch (e) {
                                              showSnackBar(
                                                  context: context,
                                                  content:
                                                      "Ocorreu um erro desconhecido");
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      leading: const Text("Alterar o nome"),
                      trailing: const Icon(Icons.person),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      onTap: () {
                        themeDataManger.changeTheme();
                      },
                      leading: const Text("Alterar o tema"),
                      trailing: themeDataManger.isDarkTheme
                          ? const Icon(Icons.dark_mode)
                          : const Icon(Icons.light_mode),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return FittedBox(
                                  child: AlertDialog(
                                    backgroundColor: ColorsApp.googleSignColor
                                        .withOpacity(0.4),
                                    title: const Text("Saír"),
                                    content: SizedBox(
                                      height: 150,
                                      child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Tens a certeza que deseja saír?",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SubmitButton(
                                            title: "Sim",
                                            color: ColorsApp.primaryColorTheme,
                                            function: () async {
                                              Navigator.pop(context);
                                              final UserModel emptyUser =
                                                  UserModel(
                                                name: "",
                                                email: "",
                                                phone: "",
                                                password: "",
                                                type: "",
                                              );
                                              await PrefService()
                                                  .setUser(user: emptyUser);
                                              await FirebaseAuth.instance
                                                  .signOut()
                                                  .then((value) => Navigator
                                                      .pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const LoginScreen()),
                                                          (route) => false));
                                            },
                                          ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          SubmitButton(
                                            title: "Não",
                                            color: Colors.redAccent,
                                            function: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        leading: const Text("Terminar a sessão"),
                        trailing: const Icon(Icons.logout_outlined)),
                    const SizedBox(height: 10),
                    const Divider(),
                    const SizedBox(height: 10),
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          text: "Criado por ",
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.black45,
                          ),
                          children: [
                            TextSpan(
                                text: "¢ Dodó Victor ",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600),
                                children: [
                                  TextSpan(
                                      text: "Todos os direitos reservado á ",
                                      style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black45,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      children: [
                                        TextSpan(
                                            text: " Astro Build Corporation",
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w600))
                                      ]),
                                ]),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
