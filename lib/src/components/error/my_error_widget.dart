import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final Stream<String?> stream;

  const MyErrorWidget({
    Key? key,
    required this.stream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: stream,
      builder: (context, snapshot) {
        final error = snapshot.data;
        return Visibility(
          visible: snapshot.hasData,
          replacement: const SizedBox.shrink(),
          child: Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Theme.of(context).colorScheme.errorContainer),
            child: Text(
              '$error',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ),
        );
      },
    );
  }
}
