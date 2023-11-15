// ignore_for_file: use_build_context_synchronously

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
bool _isChangePhoneNumber = false;
double? _ExpandsSheet;

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
  final TextEditingController _updatePhoneNumberController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer(builder: (context, WidgetRef ref, child) {
      final UserModel? userData = ref.watch(userProvider).user;
      final userDataProv = ref.watch(userDataProvider);
      final themeDataManger = ref.watch(themeDataManagerProvider);
      return Scaffold(
        appBar: AppBar(
            title: _userInformationLoader(
          userData: userDataProv
              .whenData(
                (value) => value,
              )
              .value,
          property: 'Olá ${userDataProv.whenData((value) => value.name).value}',
        )),
        body: WillPopScope(
          onWillPop: () async {
            setState(() {
              _ExpandsSheet = null;
            });
            return true;
          },
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                _ExpandsSheet = null;
              });
            },
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    Column(
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
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: const Divider(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ListTile(
                                leadingAndTrailingTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      /*    constraints: BoxConstraints(
                                  minHeight: 200,
                                  maxHeight: size.height * 0.8,
                                ), */
                                      // enableDrag: true,
                                      builder: (context) {
                                        return SizedBox(
                                          height: _ExpandsSheet ??
                                              size.height * 0.4,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text(
                                                    "Alterar O Nome",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  CustomInput(
                                                    onTap: () {
                                                      setState(() {
                                                        _ExpandsSheet =
                                                            size.height * 0.7;
                                                      });
                                                    },
                                                    title:
                                                        "Introduza o novo nome",
                                                    controller:
                                                        _updateNameController,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SubmitButton(
                                                    title: "Alterar",
                                                    width: 250,
                                                    height: 40,
                                                    isLoading: _isChangeName,
                                                    loaderColor:
                                                        Colors.grey.shade100,
                                                    color: ColorsApp
                                                        .primaryColorTheme,
                                                    function: () async {
                                                      try {
                                                     /*    setState(() {
                                                          _isChangeName = true;
                                                          _ExpandsSheet = null;
                                                        }); */
                                                        if (_updateNameController
                                                            .text.isNotEmpty) {
                                                          await FirestoreMethods()
                                                              .changeName(
                                                            newName:
                                                                _updateNameController
                                                                    .text,
                                                          );
                                                          setState(() {
                                                            _isChangeName =
                                                                false;
                                                            _ExpandsSheet =
                                                                null;
                                                          });
                                                          _updateNameController
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
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
                                                        setState(() {
                                                          _isChangeName = false;
                                                          _ExpandsSheet = null;
                                                        });
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
                                  showModalBottomSheet(
                                      context: context,
                                      showDragHandle: true,
                                      isScrollControlled: true,
                                      /*    constraints: BoxConstraints(
                                  minHeight: 200,
                                  maxHeight: size.height * 0.8,
                                ), */
                                      // enableDrag: true,
                                      builder: (context) {
                                        return SizedBox(
                                          height: _ExpandsSheet ??
                                              size.height * 0.4,
                                          child: SingleChildScrollView(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  const Text(
                                                    "Alterar O Número de telefone",
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const Divider(),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  CustomInput(
                                                    onTap: () {
                                                      setState(() {
                                                        _ExpandsSheet =
                                                            size.height * 0.7;
                                                      });
                                                    },
                                                    title:
                                                        "Introduza o novo número",
                                                    controller:
                                                        _updatePhoneNumberController,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  SubmitButton(
                                                    title: "Alterar número",
                                                    width: 250,
                                                    height: 40,
                                                    isLoading:
                                                        _isChangePhoneNumber,
                                                    loaderColor:
                                                        Colors.grey.shade100,
                                                    color: ColorsApp
                                                        .primaryColorTheme,
                                                    function: () async {
                                                               setState(() {
                                                          _isChangePhoneNumber =
                                                              true;
                                                          _ExpandsSheet = null;
                                                        });
                                                      try {
                                               
                                                        if (_updatePhoneNumberController
                                                            .text.isNotEmpty) {
                                                          await FirestoreMethods()
                                                              .changePhoneNumber(
                                                                  phoneNumber:
                                                                      _updatePhoneNumberController
                                                                          .text);
                                                          setState(() {
                                                            _isChangePhoneNumber =
                                                                false;
                                                            _ExpandsSheet =
                                                                null;
                                                          });
                                                          _updatePhoneNumberController
                                                              .clear();
                                                          Navigator.pop(
                                                              context);
                                                          showSnackBar(
                                                              context: context,
                                                              content:
                                                                  "Número atualizado com sucesso");
                                                        } else {
                                                          showSnackBar(
                                                              context: context,
                                                              content:
                                                                  "Insira o número por favor");
                                                        }
                                                      } catch (e) {
                                                        setState(() {
                                                          _isChangePhoneNumber =
                                                              false;
                                                          _ExpandsSheet = null;
                                                        });
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
                                leadingAndTrailingTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                leading:
                                    const Text("Alterar número de telefone"),
                                trailing: const Icon(Icons.phone),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                onTap: () {
                                  themeDataManger.changeTheme();
                                },
                                leading: const Text("Alterar o tema"),
                                leadingAndTrailingTextStyle:
                                    Theme.of(context).textTheme.bodyMedium,
                                trailing: themeDataManger.isDarkTheme
                                    ? const Icon(Icons.dark_mode)
                                    : const Icon(Icons.light_mode),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                  leadingAndTrailingTextStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  onTap: () async {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return FittedBox(
                                            child: AlertDialog(
                                              backgroundColor: ColorsApp
                                                  .googleSignColor
                                                  .withOpacity(0.4),
                                              title: const Text("Saír"),
                                              content: SizedBox(
                                                height: 180,
                                                child: Column(
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Tens a certeza que deseja saír?",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    SubmitButton(
                                                      title: "Sim",
                                                      color: ColorsApp
                                                          .primaryColorTheme,
                                                      function: () async {
                                                        Navigator.pop(context);
                                                        final UserModel
                                                            emptyUser =
                                                            UserModel(
                                                          name: "",
                                                          email: "",
                                                          phone: "",
                                                          password: "",
                                                          type: "",
                                                          uid: '', photoUrl: '',
                                                        );
                                                        await PrefService()
                                                            .setUser(
                                                                user:
                                                                    emptyUser);
                                                        await FirebaseAuth
                                                            .instance
                                                            .signOut()
                                                            .then((value) => Navigator
                                                                .pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                const LoginScreen()),
                                                                    (route) =>
                                                                        false));
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
                                                text:
                                                    "Todos os direitos reservado á ",
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          " Astro Build Corporation",
                                                      style: TextStyle(
                                                          color: Colors.black54,
                                                          fontWeight:
                                                              FontWeight.w600))
                                                ]),
                                          ]),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
        ),
      );
    });
  }
}
