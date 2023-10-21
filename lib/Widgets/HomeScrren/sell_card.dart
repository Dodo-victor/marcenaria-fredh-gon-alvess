import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fredh_lda/utilis/colors.dart';

class SellCard extends StatelessWidget {
  final VoidCallback? function;
  final String price;
  final String name;
  final ImageProvider<Object>? photoUrl;
  const SellCard(
      {super.key,
      this.function,
      required this.price,
      required this.name,
      this.photoUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      width: 250,
      child: InkWell(
        onTap: function,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorsApp.primaryColorTheme),
              boxShadow: [
                BoxShadow(
                    color: ColorsApp.primaryColorTheme.withOpacity(0.5),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0.4, 0.4),)
              ]),
          child: Card(
            color: Colors.grey.shade100,
            surfaceTintColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 5,
            shadowColor: ColorsApp.primaryColorTheme,
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
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: photoUrl ?? const AssetImage("assets/porta.jpg"),
                    ),
                    //color: ColorsApp.primaryColorTheme
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: ColorsApp.primaryColorTheme.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  width: double.infinity,
                  height: 50,
                  child: FittedBox(
                    child: Column(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          price,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
