// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    Key? key,
     this.color= primaryColor,
    required this.child,
    this.borderRadius=0,
    this.onTap
  }) : super(key: key);
  final Color color;
  final Widget child;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(borderRadius)),
      child: Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child:
            InkWell(
              onTap: onTap,
              child: Padding(padding: EdgeInsets.all(10), child: Center(child: child))),
      ),
    );
  }
}
