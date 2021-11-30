import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerShape extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shapeBorder;

  const ShimmerShape({
    Key? key,
    required this.height,
    required this.width,
    required this.shapeBorder,
  }) : super(key: key);

  const ShimmerShape.rectangular(
      {Key? key,
      required this.height,
      required this.width,
      //double? borderRadius,
      this.shapeBorder = const RoundedRectangleBorder()})
      : super(key: key);

  const ShimmerShape.circular({
    Key? key,
    required this.height,
    required this.width,
    this.shapeBorder = const CircleBorder(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(shape: shapeBorder),
      ),
    );
  }
}
