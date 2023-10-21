import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/Methods/firestore_methods.dart';
import 'package:fredh_lda/Screens/request_product_screen.dart';
import 'package:fredh_lda/Screens/show_product_screen.dart';
import 'package:fredh_lda/Widgets/HomeScrren/sell_card.dart';
import 'package:fredh_lda/Widgets/HomeScrren/show_merchandise_card.dart';
import 'package:fredh_lda/utilis/colors.dart';

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
        title: const Text("Marçenária Fredh Gonçalves"),
        actions: [
          IconButton(
            onPressed: () async {
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
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
         
              ShowMerchandiseCard(
                title: 'Portas',
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getDoorData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: ListView.builder(
                              // padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final _merchansieData = merchandiseData[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SellCard(
                                    function: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShowProductScreen(
                                            photoUrl: _merchansieData["foto"],
                                            name: _merchansieData["nome"],
                                            price: _merchansieData["preço"],
                                            detais:
                                                _merchansieData["descrição"],
                                            woodType:
                                                _merchansieData["tipoMadeira"],
                                            size: _merchansieData["mediada"],
                                            productId: _merchansieData["id"], productDoc: 'porta', productCollection: 'portas',

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

              /* SizedBox(height: 50,),
              SellCard() */

              const SizedBox(
                height: 20,
              ),
              ShowMerchandiseCard(
                title: "Janelas",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getWindowsData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: ListView.builder(
                              // padding: const EdgeInsets.all(8),
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final _merchansieData = merchandiseData[index];

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SellCard(
                                    function: () async {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ShowProductScreen(
                                            photoUrl: _merchansieData["foto"],
                                            name: _merchansieData["nome"],
                                            size: _merchansieData["medida"],
                                            woodType:
                                                _merchansieData["tipoMadeira"],
                                            price: _merchansieData["preço"],
                                            detais:
                                                _merchansieData["descrição"],
                                            productId: _merchansieData["id"], productDoc: 'janela', productCollection: 'janelas',

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
              ShowMerchandiseCard(
                title: "Camas",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getBedData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: snapshot.data!.docs.length == 0
                              ? const Center(
                                  child: Text("Sem artigos a venda de momento"),
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
                                                photoUrl:
                                                    _merchansieData["foto"],
                                                name: _merchansieData["nome"],
                                                size: _merchansieData["medida"],
                                                woodType: _merchansieData[
                                                    "tipoMadeira"],
                                                price: _merchansieData["preço"],
                                                detais: _merchansieData[
                                                    "descrição"],
                                                productId:
                                                    _merchansieData["id"], productDoc: "cama", productCollection: 'camas',

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
              ShowMerchandiseCard(
                title: "Ranks da Sala",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getRanksData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: snapshot.data!.docs.length == 0
                              ? const Center(
                                  child: Text("Sem artigos a venda de momento"),
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
                                                photoUrl:
                                                    _merchansieData["foto"],
                                                name: _merchansieData["nome"],
                                                size: _merchansieData["medida"],
                                                woodType: _merchansieData[
                                                    "tipoMadeira"],
                                                price: _merchansieData["preço"],
                                                detais: _merchansieData[
                                                    "descrição"],
                                                productId:
                                                    _merchansieData["id"], productDoc: 'rank', productCollection: 'ranks',

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
              ShowMerchandiseCard(
                title: "Cadeiras Corridas",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getChairData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: snapshot.data!.docs.length == 0
                              ? const Center(
                                  child: Text("Sem artigos a venda de momento"),
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
                                                photoUrl:
                                                    _merchansieData["foto"],
                                                name: _merchansieData["nome"],
                                                size: _merchansieData["medida"],
                                                woodType: _merchansieData[
                                                    "tipoMadeira"],
                                                price: _merchansieData["preço"],
                                                detais: _merchansieData[
                                                    "descrição"],
                                                productId:
                                                    _merchansieData["id"], productDoc: 'cadeira', productCollection: 'cadeiras',

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
              ShowMerchandiseCard(
                title: "Mesas",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getTableData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: snapshot.data!.docs.length == 0
                              ? const Center(
                                  child: Text("Sem artigos a venda de momento"),
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
                                                photoUrl:
                                                    _merchansieData["foto"],
                                                name: _merchansieData["nome"],
                                                size: _merchansieData["medida"],
                                                woodType: _merchansieData[
                                                    "tipoMadeira"],
                                                price: _merchansieData["preço"],
                                                detais: _merchansieData[
                                                    "descrição"],
                                                productId:
                                                    _merchansieData["id"], productDoc: 'mesa', productCollection: 'mesas',

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
              ShowMerchandiseCard(
                title: "Armário de Cozinha ",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getCabinetData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: snapshot.data!.docs.length == 0
                              ? const Center(
                                  child: Text("Sem artigos a venda de momento"),
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
                                                photoUrl:
                                                    _merchansieData["foto"],
                                                name: _merchansieData["nome"],
                                                size: _merchansieData["medida"],
                                                woodType: _merchansieData[
                                                    "tipoMadeira"],
                                                price: _merchansieData["preço"],
                                                detais: _merchansieData[
                                                    "descrição"],
                                                productId:
                                                    _merchansieData["id"], productDoc: 'armario', productCollection: 'armarios',

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
              ShowMerchandiseCard(
                title: "Pulpito",
                productList: StreamBuilder<dynamic>(
                    stream: FirestoreMethods().getPulpitData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: SpinKitSpinningCircle(
                              color: ColorsApp.primaryColorTheme),
                        );
                      }

                      // final List d = [].length

                      if (snapshot.hasData) {
                        final merchandiseData = snapshot.data!.docs;
                        return SizedBox(
                          height: 296,
                          child: snapshot.data!.docs.length == 0
                              ? const Center(
                                  child: Text("Sem artigos a venda de momento"),
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
                                                photoUrl:
                                                    _merchansieData["foto"],
                                                name: _merchansieData["nome"],
                                                size: _merchansieData["medida"],
                                                woodType: _merchansieData[
                                                    "tipoMadeira"],
                                                price: _merchansieData["preço"],
                                                detais: _merchansieData[
                                                    "descrição"],
                                                productId:
                                                    _merchansieData["id"], productDoc: 'pulpito', productCollection: 'pulpitos',

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
            ],
          ),
        ),
      ),
    );
  }
}
