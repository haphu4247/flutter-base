import 'package:flutter/material.dart';

class DefaultDivider extends StatelessWidget {
  const DefaultDivider({super.key, this.padding = 15, this.height = 1});
  final double padding;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      thickness: 0.3,
      indent: padding,
      endIndent: padding,
      color: Colors.grey,
    );
  }
}
