import 'dart:io';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:string_mask/string_mask.dart';

enum Mask { cpf, phoneNumber }

class DelegateMask {
  final String mask;
  final String? escapeCharacter;

  late TextEditingController _fieldController;
  var _lastTextSize = 0;

  @protected
  DelegateMask({
    required this.mask,
    this.escapeCharacter = "#",
  });

  static DelegateMask? fromType(Mask? type) {
    switch (type) {
      case Mask.cpf:
        return CpfMask();
      case Mask.phoneNumber:
        return PhoneNumberMask();
      default:
        return null;
    }
  }

  void apply(TextEditingController fieldController) {
    _fieldController = fieldController;
    updateText();
    _fieldController.addListener(_onChange);
  }

  void updateText() {
    final value = _fieldController.text;
    if (value.isNotEmpty) {
      var formatter = StringMask(mask);

      _fieldController.text = formatter.apply(value);
    }
  }

  void _onChange([String? text]) {
    text ??= _fieldController.text;
    // its deleting text
    if (text.length <= _lastTextSize) {
      if (mask[text.length] != escapeCharacter && Platform.isAndroid) {
        _fieldController.selection = TextSelection.fromPosition(
            TextPosition(offset: _fieldController.text.length));
      }
    } else {
      // its typing
      if (text.length >= _lastTextSize) {
        var position = text.length;
        if (position == 0 || position == mask.length) {
          return;
        }

        if ((mask[position - 1] != escapeCharacter) &&
            (text[position - 1] != mask[position - 1])) {
          _fieldController.text = _buildText(text);
        }

        if (mask[position] != escapeCharacter) {
          _fieldController.text = '${_fieldController.text}${mask[position]}';
        }
      }

      // Android on change resets cursor position(cursor goes to 0)
      // so you have to check if it reset, then put in the end(just on android)
      // as IOS bugs if you simply put it in the end
      if (_fieldController.selection.start < _fieldController.text.length &&
          Platform.isAndroid) {
        _fieldController.selection = TextSelection.fromPosition(
            TextPosition(offset: _fieldController.text.length));
      }
    }

    // update cursor position
    _lastTextSize = _fieldController.text.length;
  }

  String _buildText(String text) {
    var result = "";

    for (int i = 0; i < text.length - 1; i++) {
      result += text[i];
    }

    result += mask[text.length - 1];
    result += text[text.length - 1];

    return result;
  }
}
