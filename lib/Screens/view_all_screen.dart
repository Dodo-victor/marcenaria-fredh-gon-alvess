import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Widgets/HomeScrren/sell_card.dart';
import 'package:fredh_lda/models/merchandise.dart';
import 'package:fredh_lda/utilis/colors.dart';

import 'show_product_screen.dart';

class ViewAllScreen extends StatelessWidget {
  final String category;
  const ViewAllScreen({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: StreamBuilder<dynamic>(
          stream: FirestoreMethods().getMechandiseData(
              merchandiseDoc: category, merchandiseCollection: category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: SpinKitCircle(color: ColorsApp.primaryColorTheme),
              );
            }

            if (snapshot.hasData) {
              final lenght = snapshot.data.docs.length;
              return lenght == 0
                  ? const Center(
                      child: Text(
                        "Sem artigos a venda de momento",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black45,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView.separated(
                        itemCount: lenght,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemBuilder: (BuildContext context, int index) {
                          final merchandiseData = snapshot.data.docs;

                          final MerchandiseModel merchandiseModel =
                              MerchandiseModel.fromMap(merchandiseData[index]);
                          return Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20)),
                              child: SellCard(
                                  function: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => ShowProductScreen(
                                          photoUrl: merchandiseModel.photoUrl,
                                          name: merchandiseModel.name,
                                          price: merchandiseModel.price,
                                          detais: merchandiseModel.descr,
                                          woodType: merchandiseModel.woodType,
                                          size: merchandiseModel.size,
                                          productId: merchandiseModel.id,
                                          productDoc: category,
                                          productCollection: category,
                                          category: category,
                                        ),
                                      ),
                                    );
                                  },
                                  photoUrl: NetworkImage(
                                    merchandiseModel.photoUrl,
                                  ),
                                  price: merchandiseModel.price,
                                  name: merchandiseModel
                                      .name) /* Container(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  image:
                                      DecorationImage(image: NetworkImage(""))),
                            ),
                  
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                  
                                color: ColorsApp.primaryColorTheme,
                  
                                borderRadius: const BorderRadiusDirectional.only(bottomStart: Radius.circular(20), bottomEnd: Radius.circular(10))
                  
                                
                  
                              ),
                  
                              child: Column(
                                children: [
                                  Text("Flutter "),
                                  SizedBox(height: 5,),
                                  Text(data)
                  
                                ],
                              ),
                              
                            )
                  
                  
                          ],
                        ),
                      ), */
                              );
                        },
                      ),
                    );
            }

            return Center(
              child: Text(
                "Ocorreu um erro por favor tente novamente",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.black45),
              ),
            );
          }),
    );
  }
}
