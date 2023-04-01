import 'package:core/core.dart';
import 'package:flutter/material.dart';

class StreamDropdownButtonFormField<T extends Searchable>
    extends StatelessWidget {
  final String hintText;
  final Stream<List<T>> streamItems;
  final Stream<T?> streamSelected;
  final Function(T?) onSelected;
  final bool requiredField;
  final bool enable;
  final bool closeKeyboardAfterSelect;
  final Widget Function(T)? buildItem;

  const StreamDropdownButtonFormField({
    Key? key,
    required this.hintText,
    required this.streamItems,
    required this.streamSelected,
    required this.onSelected,
    required this.requiredField,
    this.enable = true,
    this.closeKeyboardAfterSelect = true,
    this.buildItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      stream: streamItems,
      builder: (_, snapshotList) {
        final list = snapshotList.data ?? List.empty();
        return StreamBuilder<T?>(
          stream: streamSelected,
          builder: (_, snapshot) {
            final selectedItem = snapshot.data;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<T?>(
                  items: _buildItems(list, context),
                  value: selectedItem,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
                    alignLabelWithHint: true,
                    labelText: hintText,
                    errorText: snapshot.error?.toString(),
                    counter: const Offstage(),
                  ),
                  onChanged: (value) => onChanged(value, context),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void onChanged(T? value, context) {
    if (enable) {
      onSelected(value);
      return;
    }
    null;
  }

  List<DropdownMenuItem<T>> _buildItems(List<T> items, BuildContext context) {
    return items.map((i) => _buildItem(i, context)).toList();
  }

  DropdownMenuItem<T> _buildItem(T item, BuildContext context) {
    return DropdownMenuItem<T>(
      value: item,
      child: buildItem?.call(item) ??
          Text(
            item.searchable,
          ),
    );
  }
}
