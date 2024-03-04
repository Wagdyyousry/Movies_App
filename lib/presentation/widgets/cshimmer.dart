import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CShimmerEffect extends StatelessWidget {
  const CShimmerEffect(
      {super.key,
      this.itemCount = 4,
      this.itemHeight = 180,
      this.itemWidth = 150,
      this.boxHeight = 180,
      this.isHorizontal = true});

  final int itemCount;
  final double itemHeight;
  final double itemWidth;
  final double boxHeight;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: isHorizontal ? Axis.horizontal : Axis.vertical,
        itemCount: itemCount,
        itemBuilder: (context, index) => Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.white,
          child: Container(
            margin: const EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: itemHeight,
                height: itemWidth,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
