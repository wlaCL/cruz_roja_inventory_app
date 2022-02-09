import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreeen extends StatelessWidget {
  final List<Color> _kDefaultRainbowColors = const [
    Colors.indigo,
    Colors.indigo,
  ];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballTrianglePathColoredFilled,

        /// Required, The loading type of the widget
        colors: _kDefaultRainbowColors,

        /// Optional, The color collections
        strokeWidth: 0.5,

        /// Optional, The stroke of the line, only applicable to widget which contains line
        //backgroundColor: Colors.black,

        /// Optional, Background of the widget
        //pathBackgroundColor: Colors.black

        /// Optional, the stroke backgroundColor
      ),
    );
  }
}
