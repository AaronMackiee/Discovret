import 'package:discovret1_0/Constants/discovret_constants.dart';
import 'package:flutter/material.dart';

class InitMediaQuery extends StatelessWidget {
  final Widget? child;

  const InitMediaQuery({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    deviceHeight = MediaQuery.of(context).size.height;
    deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      child: child,
    );
  }
}
