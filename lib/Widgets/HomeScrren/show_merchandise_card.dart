import 'package:flutter/material.dart';
import 'package:fredh_lda/Widgets/HomeScrren/sell_card.dart';

class ShowMerchandiseCard extends StatelessWidget {
  final Widget? productList;
  final String title;
  final VoidCallback viewAll;

  const ShowMerchandiseCard({
    super.key,
    this.productList,
    required this.title,
    required this.viewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 20, fontWeight: FontWeight.bold)

              ),
            ),
            InkWell(
              onTap: viewAll,
              child:  Row(
                children: [
                  Text("Ver Tudo", style: Theme.of(context).textTheme.titleMedium?.copyWith( fontSize: 14) ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.navigate_next_outlined),
                ],
              ),
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
                      return SellCard(
                        price: "Demo",
                        name: 'Demo',
                        function: () {},
                      );
                    }))
      ],
    );
  }
}
