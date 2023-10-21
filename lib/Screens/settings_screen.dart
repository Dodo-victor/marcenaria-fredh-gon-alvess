import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fredh_lda/Screens/Auth/login_screen.dart';
import 'package:fredh_lda/Widgets/submit_button.dart';
import 'package:fredh_lda/main.dart';
import 'package:fredh_lda/models/userModel.dart';
import 'package:fredh_lda/services/pref_service.dart';
import 'package:fredh_lda/utilis/colors.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UserModel userData = ref.watch(userProvider).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("Olá ${userData.name}"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(userData.name),
                const SizedBox(
                  height: 10,
                ),
                Text(userData.email),
                const SizedBox(
                  height: 10,
                ),
                Text(userData.phone),
                const Divider(),
                ListTile(
                  onTap: () {},
                  leading: const Text("Alterar o nome"),
                  trailing: const Icon(Icons.person),
                ),
                const SizedBox(
                  height: 8,
                ),
                Consumer(
                  builder: (context, WidgetRef ref, child) {
                        final themeDataManager = ref.watch(themeDataManagerProvider);

                    return ListTile(
                      onTap: ()  {
                        themeDataManager.changeTheme();

                      },
                      leading: const Text("Mudar o tema"),
                      trailing: const Icon(Icons.format_paint_sharp),
                    );
                  }
                ),
                const SizedBox(
                  height: 8,
                ),
                ListTile(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withOpacity(0.4),
                            title: const Text('Saír'),
                            content: const Text(
                              "Tem a certeza que deseja saír?",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            actions: [
                              SubmitButton(
                                title: "Sim",
                                color: ColorsApp.primaryColorTheme,
                                function: () async  {
                                  Navigator.of(context).pop();

                                  final UserModel emptyUser = UserModel(name: "", email: "", phone: "", password: '', type: '');

                                   PrefService().setUser(user: emptyUser);

                                  await FirebaseAuth.instance
                                      .signOut().then((value) => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false));




                                      
                                },
                              ),
                             const SizedBox(
                                height: 10,
                              ),
                              SubmitButton(title: "Não", function: (){
                                Navigator.of(context).pop();

                              },),
                            ],
                          );
                        });
                  },
                  leading: const Text("Terminar a sessão"),
                  trailing: const Icon(Icons.logout),
                ),
                const SizedBox(height: 8,),
                const Divider(),
                RichText(text: const TextSpan(children: [
                  TextSpan(text: 'Criado por ', children:[
                    TextSpan(text: "Dodó Victor", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                  ] ),

                ],),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
