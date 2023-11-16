// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Screens/bottom_bar.dart';
import 'package:fredh_lda/Widgets/loader.dart';
import 'package:fredh_lda/Widgets/submit_button.dart';
import 'package:fredh_lda/main.dart';
import 'package:fredh_lda/utilis/colors.dart';
import 'package:fredh_lda/utilis/makeCall.dart';

class ProductDetailsCard extends StatefulWidget {
  final String photoUrl;
  final String name;
  final String price;
  final String productId;
  final String productDoc;
  final String productCollection;
  final String category;
  final bool isRequesting;
  final String detais;
  final String woodType;
  bool isLoading;
  final String size;
  final VoidCallback? requestProduct;
  final double? heigth;

  ProductDetailsCard({
    super.key,
    required this.photoUrl,
    this.heigth,
    required this.name,
    required this.price,
    required this.detais, //
    this.requestProduct,
    required this.productId,
    this.isRequesting = false,
    required this.woodType,
    required this.size,
    this.isLoading = false,
    required this.productDoc,
    required this.productCollection,
    required this.category,
  });

  @override
  State<ProductDetailsCard> createState() => _ProductDetailsCardState();
}

//bool _isLoading = false;

class _ProductDetailsCardState extends State<ProductDetailsCard> {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  final _contactData = FutureProvider((ref) async {
    final contactData = await FirebaseFirestore.instance
        .collection("definições")
        .doc("contactos")
        .collection("contacto")
        .get();

    return contactData;
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Consumer(builder: (context, WidgetRef ref, child) {
        final requestRepository = ref.watch(requestProvider);
        final contactProvider = ref.watch(_contactData);
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 7 / 7,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                height: size.height * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image(
                  image: NetworkImage(widget.photoUrl, scale: 2),
                  fit: BoxFit.fitWidth,
                  errorBuilder: (s, error, a) {
                    return const Center(
                      child: Text(
                        "Ocorreu um erro ao carregar a Imagem",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Nome:  ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                          text: widget.name,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ])),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Preço:  ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                            text: widget.price,
                            style: Theme.of(context).textTheme.titleSmall),
                      ])),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Medidas:  ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                            text: widget.size,
                            style: Theme.of(context).textTheme.titleSmall),
                      ])),
                  const SizedBox(
                    height: 5,
                  ),
                  RichText(
                      text: TextSpan(
                          text: "Tipo de madeira:  ",
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                        TextSpan(
                            text: widget.woodType,
                            style: Theme.of(context).textTheme.titleSmall),
                      ])),
                  SizedBox(
                    height: 5,
                  ),
                  Text(widget.detais,
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(
                    height: 20,
                  ),
                  widget.isRequesting == true
                      ? SubmitButton(
                          // width: 400,

                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Cancelar solicitação',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          height: 40,
                          title: 'Solicitar',
                          isLoading: widget.isLoading,
                          borderRadius: BorderRadius.circular(15),
                          loaderColor: Colors.grey.shade200,
                          color: Colors.redAccent.shade400,
                          function: () async {
                            setState(() {
                              widget.isLoading = true;
                            });

                            await _firestoreMethods.cancelRequest(
                                productDoc: widget.productDoc,
                                productCollection: widget.productCollection,
                                productId: widget.productId);

                            /*   Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomBar(),
                                ),
                              ); */
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomBar()),
                                (route) => false);

                            setState(() {
                              widget.isLoading = false;
                            });
                          },
                        )
                      : SubmitButton(
                          // width: 400,

                          icon: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.shopping_cart),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Solicitar',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                          height: 40,
                          title: 'Solicitar',
                          isLoading: widget.isLoading,
                          borderRadius: BorderRadius.circular(15),
                          loaderColor: Colors.grey.shade200,
                          color: ColorsApp.primaryColorTheme,
                          function: () async {
                            setState(() {
                              widget.isLoading = true;
                            });

                            /*  try { */
                            await _firestoreMethods.setRequestProduct(
                              productId: widget.productId,
                              productDoc: widget.productDoc,
                              productCollection: widget.productCollection,
                              context: context,
                              category: widget.category,
                            );

                            await requestRepository.getRequestSize();
                            /*  } catch (e) {
                                    showSnackBar(
                                        context: context,
                                        content:
                                            "Ocorreu um erro desconhecido por favor tente mais tarde $e");
                                  } */

                            setState(() {
                              widget.isLoading = false;
                            });
                          },
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Contacte-nos atravês dos terminais abaixo:',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  const Divider(),
                  contactProvider.when(data: (contact) {
                    print(contact.docs.length);
                    return SizedBox(
                      height: 20,
                      width: 400,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final contactDataSnap = contact.docs[index];
                            return InkWell(
                              onTap: () {
                                makeCall(
                                    phoneNumber:
                                        contactDataSnap["numeroDeTelefone"],
                                    context: context);
                              },
                              child: Text(
                                "+244 ${contactDataSnap["numeroDeTelefone"]}",
                                style: TextStyle(
                                    color: ColorsApp.primaryColorTheme,
                                    fontWeight: FontWeight.w600),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              height: 2,
                              width: 2,
                              decoration:
                                  BoxDecoration(color: Colors.grey.shade700),
                            );
                          },
                          itemCount: contact.docs.length),
                    );
                  }, error: (error, stackTrace) {
                    return const Center(
                      child: Text("Ocorreu um erro desconhecido"),
                    );
                  }, loading: () {
                    return const Center(
                      child: Loader(),
                    );
                  }),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
