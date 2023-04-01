import 'package:flutter/material.dart';

extension InputDecorationFunctions on InputDecoration {
  InputDecoration copyWithDefault(BuildContext context) {
    return copyWith(
      alignLabelWithHint: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      labelStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
      hintStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
      contentPadding: const EdgeInsets.all(16.0),
      counter: const Offstage(),
    );
  }
}
