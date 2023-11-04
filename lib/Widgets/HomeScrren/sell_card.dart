import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fredh_lda/utilis/colors.dart';

class SellCard extends StatelessWidget {
  final VoidCallback? function;
  final String price;
  final String name;
  final double? height;
  final double? width;
  final ImageProvider<Object>? photoUrl;

  const SellCard(
      {super.key,
      this.function,
      required this.price,
      required this.name,
      this.photoUrl,
      this.height,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 280,
      width: width ?? 250,
      child: InkWell(
        onTap: function,
        child: Card(
          color: Colors.grey.shade200,
          surfaceTintColor: Colors.grey.shade300,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 20,
          shadowColor: ColorsApp.googleSignColor,
          child: Column(
            children: [
              /*     const SizedBox(
                height: 15,
              ), */
              Container(
                // alignment: Alignment.center,
                height: 220,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Image(
                  image: photoUrl ?? const AssetImage("assets/porta.jpg"),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorsApp.primaryColorTheme,
                    borderRadius: const BorderRadiusDirectional.only(
                        bottomStart: Radius.circular(10),
                        bottomEnd: Radius.circular(10))),
                width: double.infinity,
                height: 52,
                child: FittedBox(
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        price,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
