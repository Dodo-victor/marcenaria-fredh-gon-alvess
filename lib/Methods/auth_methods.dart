// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/models/userModel.dart';
import 'package:fredh_lda/services/pref_service.dart';
import 'package:fredh_lda/utilis/show_snack_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final PrefService _prefService = PrefService();

  String? currentUid;

  AuthMethods({this.currentUid}) {
    currentUid = "";
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<bool> authUserWithGoogle({
    required BuildContext context,
  }) async {
    bool res = false;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleSignInAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuth?.idToken,
          accessToken: googleSignInAuth?.accessToken);

      final authUser = await _auth.signInWithCredential(credential);

      User? user = authUser.user;

      if (user != null) {
        if (authUser.additionalUserInfo!.isNewUser) {
        final  UserModel userModel = UserModel(
              name: user.displayName!,
              email: user.email!,
              phone: "",
              uid: user.uid,
              password: "",
              type: "user");
          await _db.collection("usuários").doc(user.uid).set(
                userModel.toMap(),
              );

              print(user.uid);

              

          await _prefService.setUser(user: userModel);
        }
        res = true;
      }
    } on FirebaseAuthException catch (e) {
      res = false;
      showSnackBar(
          content:
              "Ocorreu um erro ao autenticar. Tente mais tarde! ${e.message}",
          context: context);
    }

    return res;
  }

  signupUp({required UserModel userModel, required context}) async {
    String res = '';
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password,
      );

      if (userCredential.user != null) {
        User? user = userCredential.user;

        UserModel userData = UserModel(
          name: userModel.name,
          email: userModel.email,
          phone: userModel.phone,
          password: userModel.password,
          type: "user",
          uid: user!.uid,
        );

        await _db.collection("usuários").doc(user!.uid).set(
          userData.toMap(),
            );

        await _prefService.setUser(user: userModel);

        res = 'success';
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // E-mail já está sendo usado por outra conta.
          showSnackBar(
              context: context,
              content: 'E-mail já está sendo usado por outra conta.');
          // Exiba uma mensagem de erro ao usuário.
        } else if (e.code == 'weak-password') {
          showSnackBar(
              context: context,
              content:
                  'Senha fraca, informe ao usuário que a senha deve ser mais forte.');
          // Senha fraca, informe ao usuário que a senha deve ser mais forte.
        } else if (e.code == "invalid-email") {
          // Outro erro de autenticação, trate de acordo com suas necessidades.
          showSnackBar(context: context, content: 'Email inválido');
        } else {
          showSnackBar(context: context, content: 'Erro desconhecido');
        }
      }
    }

    return res;
  }

  login(
      {required String email,
      required String password,
      required context}) async {
    try {
      String res = '';

      if (email.isNotEmpty || password.isNotEmpty) {
        final UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: email, password: password);

        final UserModel userData =
            await FirestoreMethods().getUser(userUid: userCredential.user!.uid);
        await _prefService.setUser(user: userData);
        return res = "success";
      } else {
        showSnackBar(
            context: context, content: 'Preencha todos os campos por favor');
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "user-not-found") {
          showSnackBar(context: context, content: "Este email não existe");
        } else if (e.code == "wrong-password") {
          showSnackBar(context: context, content: "Senha incorrecta!");
        } else if (e.code == "invalid-email") {
          showSnackBar(context: context, content: 'Email inválido');
        } else {
          showSnackBar(
              context: context,
              content: "Ocorreu um erro um erro desconhecido");
        }
      } else {
        showSnackBar(
            context: context, content: "Ocorreu um erro desconhecido $e");
      }
    }
  }
}
