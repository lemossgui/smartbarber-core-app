import 'dart:async';
import 'package:fancy_stream/fancy_stream.dart';

mixin FancyMixin {
  final Fancy fancy = FancyDelegate();

  Map get map => fancy.map;

  void dispose() {
    fancy.dispose();
  }

  Stream<T> streamOf<T>({dynamic key}) => fancy.streamOf(key: key);

  void dispatch<T>(T value, {dynamic key}) =>
      fancy.dispatchOn<T>(value, key: key);

  void dispatchError<T>(T value, {dynamic key}) =>
      fancy.dispatchErrorOn<T>(value as Object, key: key);

  void addTransformOn<T, S>(
    StreamTransformer<T, S> streamTransformer, {
    Object? key,
  }) =>
      fancy.addTransformOn<T, S>(streamTransformer, key: key);

  StreamSubscription<T> listen<T>(
    void Function(T) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
    Object? key,
  }) =>
      fancy.listenOn<T>(
        onData,
        onError: onError,
        onDone: onDone,
        cancelOnError: cancelOnError,
        key: key,
      );
}
