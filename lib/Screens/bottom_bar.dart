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

  @override
  void initState() {
    _initGetUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items[_index],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: ColorsApp.primaryColorTheme,
        items: const [
          BottomNavigationBarItem(
            label: 'Início',
            icon: Icon(CupertinoIcons.home),
          ),
          BottomNavigationBarItem(
            label: 'Definicões',
            icon: Icon(CupertinoIcons.settings),
          ),
        ],
        currentIndex: _index,
        onTap: _navigateToPage,
      ),
    );
  }
}
