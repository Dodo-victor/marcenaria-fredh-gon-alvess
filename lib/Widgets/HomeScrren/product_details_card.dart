import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Screens/bottom_bar.dart';
import 'package:fredh_lda/Widgets/submit_button.dart';
import 'package:fredh_lda/utilis/colors.dart';

import '../../utilis/show_snack_bar.dart';

class ProductDetailsCard extends StatefulWidget {
  final String photoUrl;
  final String name;
  final String price;
  final String productId;
  final String productDoc;
  final String productCollection;
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
     this.isLoading = false, required this.productDoc, required this.productCollection,
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
    return Column(
      children: [
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(widget.photoUrl, scale: 2),
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

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomBar(),
                            ),
                          );
                          /*  Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const BottomBar()),
                              (route) => false); */


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
                            context: context);
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
              const Text(
                'Caso gostou da mercadoria contacte atraves dos terminais',
                style: TextStyle(
                    color: Colors.black45, fontWeight: FontWeight.w600),
              ),
              Text(
                '921750554',
                style: TextStyle(
                    color: ColorsApp.primaryColorTheme,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
        )
      ],
    );
  }
}
