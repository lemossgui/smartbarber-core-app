import 'package:flutter/material.dart';
import 'package:core/core.dart';

class MyCard extends StatelessWidget {
  final Object? error;
  final Function? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final Widget content;

  const MyCard({
    Key? key,
    this.error,
    this.onTap,
    this.contentPadding,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasError = error != null;
    return SeparatedColumn(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: hasError
                ? Border.all(color: Theme.of(context).colorScheme.error)
                : null,
            color: Theme.of(context).colorScheme.background,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
            onTap: onTap != null ? () => onTap?.call() : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            title: content,
            minVerticalPadding: 0.0,
          ),
        ),
        Visibility(
          visible: hasError,
          child: Text(
            error?.toString() ?? '',
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ],
    );
  }
}
