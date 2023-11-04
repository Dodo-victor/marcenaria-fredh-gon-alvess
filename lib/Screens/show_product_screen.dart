import 'package:flutter/material.dart';
import 'package:fredh_lda/Widgets/HomeScrren/product_details_card.dart';

class ShowProductScreen extends StatelessWidget {
  final String photoUrl;
  final String name;
  final String price;
  final String detais;
  final String productDoc;
  final String category;
  final String productCollection;
  final String woodType;
  final String size;
  final String productId;
  final bool isRequesting;

  ShowProductScreen(
      {super.key,
      required this.photoUrl,
      required this.name,
      required this.price,
      required this.detais,
      required this.productId,
      this.isRequesting = false,
      required this.woodType,
      required this.size,
      required this.productDoc,
      required this.productCollection,
      required this.category});

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //bool isLoading = false;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: ProductDetailsCard(
        isLoading: isLoading,
        photoUrl: photoUrl,
        name: name,
        price: price,
        detais: detais,
        productId: productId,
        isRequesting: isRequesting,
        size: size,
        woodType: woodType,
        productDoc: productDoc,
        productCollection: productCollection,
        category: category,
      ),
    );
  }
}
