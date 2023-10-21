import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fredh_lda/utilis/colors.dart';

class SubmitButton extends StatelessWidget {
  final String title;
  final BorderRadius? borderRadius;
  final Color? color;
  final Color? loaderColor;
  final double? height;
  final double? width;
  final Widget? icon;
  final bool isLoading;
  final VoidCallback? function;
  const SubmitButton({
    super.key,
    required this.title,
    this.borderRadius,
    this.color,
    this.height,
    this.width,
    this.function,
    this.isLoading = false,
    this.icon,
    this.loaderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        alignment: Alignment.center,
        height: height ?? 45,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
            color: color ?? Colors.red.shade600,
            borderRadius: borderRadius ?? BorderRadius.circular(15)),
        child: isLoading
            ? SpinKitChasingDots(
                color: loaderColor ?? ColorsApp.primaryColorTheme,
                size: 25,
              )
            : icon ??
                Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                ),
      ),
    );
  }
}
