import 'package:flutter/material.dart';
import 'package:discovret1_0/Constants/discovret_constants.dart';

class DiscovretBackground extends StatelessWidget {
  DiscovretBackground({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
            center: Alignment.topCenter,
            colors: [Color(0xFF0045FF), Color(0x4D0044FF)],
            stops: [-2.5, 2.0],
            radius: 1.5,
            focalRadius: 2.0,
            tileMode: TileMode.clamp),
      ),
      constraints: BoxConstraints.expand(),
      child: SafeArea(child: child),
    );
  }
}


// class DiscovretBackground extends StatelessWidget {
//   DiscovretBackground({@required this.child});
//   final Widget child;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         decoration: BoxDecoration(
//           gradient: RadialGradient(
//               center: Alignment.topCenter,
//               colors: [Color(0xFF0045FF), Color(0x4D0044FF)],
//               stops: [-1.5, 2.0],
//               radius: 1.5,
//               focalRadius: 2.0,
//               tileMode: TileMode.clamp),
//         ),
//         constraints: BoxConstraints.expand(),
//         child: child);
//   }
// }
