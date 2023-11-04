// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fredh_lda/models/merchandise.dart';
import 'package:fredh_lda/models/request_product_model.dart';
import 'package:fredh_lda/models/userModel.dart';

import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  //final AuthMethods _authMethods = AuthMethods();

  final String currentUid = FirebaseAuth.instance.currentUser!.uid;

  createAndSetMercadory(
      {required String mercadoryDoc,
      required String mercadoryCollection}) async {
    final uid = const Uuid().v4();

    final MerchandiseModel pruduct = MerchandiseModel(
        price: "35.000,00kz",
        name: 'Mesa Orval',
        descr: "Mesa feita pelo fredh faça já á sua solicitaçã ",
        photoUrl:
            "https://www.decoracoesmoveis.com.br/media/catalog/product/cache/1/image/800x/9df78eab33525d08d6e5fb8d27136e95/p/_/p_g_28.jpg",
        id: uid,
        //  hasRequest: false,
        size: '5m x 2,10cm',
        woodType: 'MUSIVI');

    await db
        .collection("marçenaria")
        .doc(mercadoryDoc)
        .collection(mercadoryCollection)
        .doc(uid)
        .set(pruduct.toMap());
  }

  getRequestProduct() {
    return db
        .collection('solicitação')
        .doc(currentUid)
        .collection("solicitação")
        .orderBy("data", descending: true)
        .get();
  }

  cancelRequest(
      {required String productId,
      required String productDoc,
      required String productCollection}) async {
    await db
        .collection("solicitação")
        .doc(currentUid)
        .collection("solicitação")
        .doc(productId)
        .delete();

    /*   await db
        .collection('marçenaria')
        .doc(productDoc)
        .collection(productCollection)
        .doc(productId)
        .update({"temSolicitação": false});*/
  }

  setRequestProduct(
      {required String productId,
      required String productDoc,
      required String productCollection,
      required String category,
      required BuildContext context}) async {
    final userData = await db.collection("usuários").doc(currentUid).get();
    UserModel user = UserModel.fromMap(userData);

    final productData = await db
        .collection('marçenaria')
        .doc(productDoc)
        .collection(productCollection)
        .doc(productId)
        .get();

    print(productId);

    MerchandiseModel merchandise = MerchandiseModel.fromMap(productData);
    final String uid = const Uuid().v4();

    final hasRequest = await db
        .collection("solicitação")
        .doc(currentUid)
        .collection("solicitação")
        .where(
          "id",
          isEqualTo: merchandise.id,
        )
        .get();

    print(merchandise.id);

    print(hasRequest.docs);

//print(hasRequest.docs.length);
    if (hasRequest.docs.isEmpty) {
      final RequestProductModel requestProduct = RequestProductModel(
          user: user,
          product: merchandise,
          id: productId,
          userUid: currentUid,
          isRequested: true,
          category: category);

      await db
          .collection("solicitação")
          .doc(currentUid)
          .collection("solicitação")
          .doc(productId)
          .set(
            requestProduct.toMap(),
          );

/*       await db
          .collection('marçenaria')
          .doc(productDoc)
          .collection(productCollection)
          .doc(productId)
          .update({
        "temSolicitação": true,
      });
 */
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                height: 250,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 142, 224, 184),
                            borderRadius: BorderRadius.circular(190),
                          ),
                          child: Icon(
                            Icons.done_sharp,
                            size: 80,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Solicitação enviada",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Sua solicitação foi enviada com sucesso",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: SizedBox(
                height: 250,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.redAccent.shade400,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Icon(
                            Icons.shopping_cart_checkout,
                            size: 40,
                            color: Colors.grey.shade200,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Ups",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Este produto já se encontra na sua lista de solicitações",
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  getMechandiseData(
      {required String merchandiseDoc, required String merchandiseCollection}) {
    return db
        .collection('marçenaria')
        .doc(merchandiseDoc)
        .collection(merchandiseCollection)
        .orderBy(
          "data",
          descending: true,
        )
        .snapshots();
  }

  /* .map(
      (event)  {
        List<Merchandise> _merchandiseData = [];

       // List<Merchandise> merchandise;




        for (var element in event.docs) {
          //print(element.data().length);
           Merchandise merchandise =/*  Merchandise.fromMap(
              element.data());  */ Merchandise(
      price: element['preço'],
      id: element['id'],
      name: element['nome'],
      descr: element['descrição'],
      photoUrl: element['foto'],
    );






 //print(data);




        }



        return _merchandiseData;
      },
    ); */

  getUser({String? userUid}) async {
    final userData =
        await db.collection("usuários").doc(userUid ?? currentUid).get();

    UserModel user = UserModel.fromMap(userData);

    return user;
  }

  changeName({required String newName}) async {
    await db.collection('usuários').doc(currentUid).update({
      "nome": newName,
    });
  }

  changePhoneNumber({required String phoneNumber}) async {
    await db.collection('usuários').doc(currentUid).update({
      "telefone": phoneNumber,
    });
  }

/* Future<({ int requestSize})> */ getRequestSize() async {
    final requestData = await db
        .collection("solicitação")
        .doc(currentUid)
        .collection("solicitação")
        .get();

    /*   return (requestSize: requestData.size ); */

    return requestData.size;
  }
}
