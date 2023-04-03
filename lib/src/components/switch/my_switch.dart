import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter/material.dart';

class MySwitch extends StatelessWidget {
  final Stream<bool> stream;
  final Function(bool) onChange;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const MySwitch({
    super.key,
    required this.stream,
    required this.onChange,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool?>(
      stream: stream,
      builder: (_, snapshot) {
        final value = snapshot.data ?? false;
        return FlutterSwitch(
          height: 32.0,
          width: 64.0,
          toggleSize: 24.0,
          value: value,
          borderRadius: 48.0,
          padding: 2.0,
          activeToggleColor: Theme.of(context).colorScheme.background,
          inactiveToggleColor: Theme.of(context).colorScheme.background,
          activeSwitchBorder: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2.0,
          ),
          inactiveSwitchBorder: Border.all(
            color: Theme.of(context).colorScheme.outline,
            width: 2.0,
          ),
          activeColor: Theme.of(context).colorScheme.primary,
          inactiveColor: Theme.of(context).colorScheme.outline,
          activeIcon: Icon(
            activeIcon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          inactiveIcon: Icon(
            inactiveIcon,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onToggle: onChange,
        );
      },
    );
  }
}
