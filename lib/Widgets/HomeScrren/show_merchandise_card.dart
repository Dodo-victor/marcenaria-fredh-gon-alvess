import 'package:flutter/material.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Widgets/HomeScrren/sell_card.dart';

class ShowMerchandiseCard extends StatelessWidget {
  final Widget? productList;
  final String title;

  const ShowMerchandiseCard({super.key, this.productList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       const SizedBox(height: 25,),
        Row(
          children: [
             Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: const [
                Text("Ver Tudo"),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.navigate_next_outlined),
              ],
            )
          ],
        ),
        productList ??
            SizedBox(
               height: 296,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return  SellCard(
                        price: "Demo",
                        name: 'Demo',
                        function: ()  {
                         
                          
                        },
                      );
                    }))
      ],
    );
  }
}