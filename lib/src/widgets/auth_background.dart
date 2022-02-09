import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _buildBoxDecoration(),
        child: child);
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(color: Colors.black.withOpacity(0.05));
  }
}
