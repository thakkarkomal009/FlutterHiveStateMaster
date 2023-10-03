import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingCard extends StatelessWidget {
  final double? height;
  final Color? color;

  const LoadingCard({Key? key, required this.height, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: color ?? Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5)),
              height: height,
              width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
      ),
    );
  }
}