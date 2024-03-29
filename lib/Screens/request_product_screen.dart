import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Methods/times_ago_methods..dart';
import 'package:fredh_lda/Screens/show_product_screen.dart';
import 'package:fredh_lda/Widgets/loader.dart';
import 'package:fredh_lda/utilis/colors.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class RequestProductScreen extends StatelessWidget {
  final String? productDoc;
  final String? productCollection;

  const RequestProductScreen(
      {super.key, this.productDoc, this.productCollection});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solicitações"),
      ),
      body: FutureBuilder<dynamic>(
        future: FirestoreMethods().getRequestProduct(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Loader(),
            );
          }
          if (snap.hasData) {
            final data = snap.data!;
            print(data);
            return snap.data.docs.isEmpty
                ? Center(
                    child: Text(
                      "0 Solicitações de momento",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 20, color: Colors.black45),
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: data.docs.length,
                    itemBuilder: (context, index) {
                      final requestProductData = data.docs[index];
                      return ListTile(
                        autofocus: false,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ShowProductScreen(
                                photoUrl: requestProductData["foto"],
                                name: requestProductData["produtoNome"],
                                size: requestProductData["medida"],
                                woodType: requestProductData["tipoMadeira"],
                                price: requestProductData["preço"],
                                detais: requestProductData["descrição"],
                                productId: requestProductData["id"],
                                isRequesting:
                                    requestProductData["estaSolicitando"],
                                productDoc: productDoc ?? "",
                                productCollection: productCollection ?? "",
                                category: requestProductData["categoria"],
                              ),
                            ),
                          );
                        },
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                        leading: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade400,
                          ),
                          child: Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                              //color: ColorsApp.googleSignColor,
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  requestProductData['foto'],
                                ),
                              ),
                            ),
                          ),
                        ),
                        title: Text(requestProductData['produtoNome']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(requestProductData['preço']),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(TimesAgo.setDate(
                                requestProductData['data'].toDate()))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider();
                    },
                  );
          }

          return const Center(
            child: Text(
              "Ocorreu um erro por favor verifica á sua conecão com a internet",
              style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
            ),
          );
        },
      ),
    );
  }
}
