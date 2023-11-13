import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fredh_lda/utilis/colors.dart';
import 'package:fredh_lda/utilis/pages.dart';

import '../main.dart';

class BottomBar extends ConsumerStatefulWidget {
  const BottomBar({super.key});

  @override
  ConsumerState<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends ConsumerState<BottomBar> {
  int _index = 0;

  _navigateToPage(int page) {
    setState(() {
      _index = page;
    });
  }

  _initGetUser() async {
    await ref.read(userProvider).getUser();
  }

  _initGetRequestSize() async {
    await ref.read(requestProvider).getRequestSize();
  }

  @override
  void initState() {
    _initGetUser();
    _initGetRequestSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[_index],
      bottomNavigationBar: NavigationBar(
        // fixedColor: ColorsApp.primaryColorTheme,
        destinations: [
          InkWell(
            onTap: () => _navigateToPage(0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  border: _index == 0
                      ? const Border(top: BorderSide(width: 2))
                      : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.home),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Início",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () => _navigateToPage(1),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                  border: _index == 1
                      ? const Border(top: BorderSide(width: 2))
                      : null),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.person),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Perfil",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          ),
        ],
        selectedIndex: _index,
      ),
    );
  }
}
