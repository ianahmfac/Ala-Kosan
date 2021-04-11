import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CityLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      scrollDirection: Axis.horizontal,
      itemCount: 2,
      itemBuilder: (context, index) => Shimmer.fromColors(
        child: Container(
          height: 200,
          margin: const EdgeInsets.only(right: 16),
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
        ),
        baseColor: Colors.grey[300],
        highlightColor: Colors.grey[100],
      ),
    );
  }
}
