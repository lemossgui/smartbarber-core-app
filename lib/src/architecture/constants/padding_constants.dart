import 'package:flutter/material.dart';

EdgeInsets getBasePadding(BuildContext context, {double? value}) =>
    EdgeInsets.only(
      left: value ?? 16.0,
      right: value ?? 16.0,
      top: value ?? 16.0,
      bottom: MediaQuery.of(context).padding.bottom,
    );
