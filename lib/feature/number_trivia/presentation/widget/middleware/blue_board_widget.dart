import 'package:flutter/material.dart';

class BlueBoardWidget extends StatelessWidget {
  final Widget child;

  const BlueBoardWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.blue.shade400,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 8,
          ),
        ],
      ),
      child: Center(
        child: child,
      ),
    );
  }
}
