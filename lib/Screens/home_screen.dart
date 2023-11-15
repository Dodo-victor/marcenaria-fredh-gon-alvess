import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Screens/request_product_screen.dart';
import 'package:fredh_lda/Screens/show_product_screen.dart';
import 'package:fredh_lda/Screens/view_all_screen.dart';
import 'package:fredh_lda/Widgets/HomeScrren/sell_card.dart';
import 'package:fredh_lda/Widgets/HomeScrren/show_merchandise_card.dart';
import 'package:fredh_lda/main.dart';
import 'package:fredh_lda/utilis/colors.dart';
import 'package:fredh_lda/utilis/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ColorsApp.primaryColorTheme,
        title: const Text("Marcenaria ACG Gonçalves"),
        actions: [
          Consumer(builder: (context, WidgetRef ref, child) {
            final requestSize = ref.watch(requestProvider).size;
            return requestSize == 0
                ? IconButton(
                    onPressed: () {
                      // await FirestoreMethods().createAndSetMercadory(
                      //  mercadoryCollection: 'mesas', mercadoryDoc: "mesa");
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const RequestProductScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.shopping_cart),
                  )
                : Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Badge(
                      label: Text(requestSize.toString()),
                      alignment: Alignment.topRight,
                      offset: const Offset(0, 0),
                      child: IconButton(
                        onPressed: () {
                          // await FirestoreMethods().createAndSetMercadory(
                          //  mercadoryCollection: 'mesas', mercadoryDoc: "mesa");
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const RequestProductScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.shopping_cart),
                      ),
                    ),
                  );
          })
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: RefreshIndicator.adaptive(
            color: ColorsApp.primaryColorTheme,
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 2));
              for (var e in GlobalVariables.category) {
                await FirestoreMethods().getMechandiseData(
                    merchandiseDoc: e, merchandiseCollection: e);
              }
            },
            child: ListView(
              children: GlobalVariables.category.map((e) {
                return Column(
                  children: [
                    // const SizedBox(height: 15,),
                    ShowMerchandiseCard(
                      viewAll: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAllScreen(category: e)));
                      },
                      title: e,
                      productList: StreamBuilder<dynamic>(
                          stream: FirestoreMethods().getMechandiseData(
                              merchandiseDoc: e, merchandiseCollection: e),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: Container(
                                  height: 296,
                                  child: SpinKitCircle(
                                      color: ColorsApp.primaryColorTheme),
                                ),
                              );
                            }

                            // final List d = [].length

                            if (snapshot.hasData) {
                              final merchandiseData = snapshot.data!.docs;
                              return SizedBox(
                                height: 296,
                                child: snapshot.data!.docs.length == 0
                                    ? Center(
                                        child: Text(
                                          "Sem artigos a venda de momento",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall?.copyWith(fontSize: 20),
                                        ),
                                      )
                                    : ListView.builder(
                                        // padding: const EdgeInsets.all(8),
                                        itemCount: snapshot.data!.docs.length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final _merchansieData =
                                              merchandiseData[index];

                                          return Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SellCard(
                                              function: () async {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ShowProductScreen(
                                                      photoUrl: _merchansieData[
                                                          "foto"],
                                                      name: _merchansieData[
                                                          "nome"],
                                                      price: _merchansieData[
                                                          "preço"],
                                                      detais: _merchansieData[
                                                          "descrição"],
                                                      woodType: _merchansieData[
                                                          "tipoMadeira"],
                                                      size: _merchansieData[
                                                          "medida"],
                                                      productId:
                                                          _merchansieData["id"],
                                                      productDoc: e,
                                                      productCollection: e,
                                                      category: e,
                                                    ),
                                                  ),
                                                );

                                                /*   await _firestoreMethods
                                              .createAndSetMercadory(); */
                                              },
                                              name: _merchansieData["nome"],
                                              price: _merchansieData["preço"],
                                              photoUrl: NetworkImage(
                                                _merchansieData["foto"],
                                              ),
                                            ),
                                          );
                                        }),
                              );
                            }

                            return const Center(
                              child: Text(
                                "Ocorreu um erro, por favor verifica a sua conexão á internet",
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),
                    ),
                    //  const SizedBox(height: 25,),
                  ],
                );
              }).toList(),
            ),
          )),
    );
  }
}
