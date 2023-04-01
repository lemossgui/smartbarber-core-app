import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  final String message;

  const EmptyListWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset(
            'assets/json/empty.json',
            height: 250.0,
          ),
          Text(message),
        ],
      ),
    );
  }
}
