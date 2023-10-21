import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/utilis/colors.dart';

class Loader extends StatelessWidget {
  final Color? color;
  final double? size;
  const Loader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(color: color?? ColorsApp.primaryColorTheme,);
  }
}