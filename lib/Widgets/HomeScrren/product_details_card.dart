// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Screens/bottom_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 5 / 5,
            child: Container(
              height: size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
              child: Image(
                image: NetworkImage(widget.photoUrl, scale: 2),
                fit: BoxFit.cover,
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
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                      TextSpan(
                        text: widget.name,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ])),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(
                        text: "Preço:  ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                      TextSpan(
                        text: widget.price,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ])),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(
                        text: "Medidas:  ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                      TextSpan(
                        text: widget.size,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ])),
                const SizedBox(
                  height: 5,
                ),
                RichText(
                    text: TextSpan(
                        text: "Tipo de madeira:  ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                      TextSpan(
                        text: widget.woodType,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ])),
               SizedBox(height: 5,),
                Text(
                  widget.detais,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                    : Consumer(builder: (context, WidgetRef ref, child) {
                        final requestRepository = ref.watch(requestProvider);
                        return SubmitButton(
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
                        );
                      }),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Contacte-nos atravês dos terminais abaixo:',
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.w600),
                ),
                const Divider(),
                InkWell(
                  onTap: () {
                    makeCall(phoneNumber: '923687570', context: context);
                  },
                  child: Text(
                    '923687570',
                    style: TextStyle(
                        color: ColorsApp.primaryColorTheme,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
