import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoading extends StatelessWidget {
  final double size;
  final Color color;

  const CustomLoading({super.key, required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(color: color, size: size);
  }
}
