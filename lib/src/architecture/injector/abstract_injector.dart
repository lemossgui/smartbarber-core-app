import 'package:get/instance_manager.dart';

final _instance = GetInstance();

abstract class AbstractInjector {
  T call<T>() {
    return _instance.call<T>();
  }

  void create<S>(
    InstanceBuilderCallback<S> builder, {
    String? tag,
    bool permanent = true,
  }) {
    _instance.create<S>(
      builder,
      tag: tag,
      permanent: permanent,
    );
  }

  bool delete<S>({
    String? tag,
    String? key,
    bool force = false,
  }) {
    return _instance.delete<S>(
      tag: tag,
      key: key,
      force: force,
    );
  }

  void deleteAll({bool force = false}) {
    return _instance.deleteAll(force: true);
  }

  S find<S>({String? tag}) {
    return _instance.find<S>(tag: tag);
  }

  InstanceInfo getInstanceInfo<S>({String? tag}) {
    return _instance.getInstanceInfo<S>(tag: tag);
  }

  void injector<S>(InjectorBuilderCallback<S> fn,
      {String? tag, bool fenix = false}) {
    return _instance.injector<S>(fn, tag: tag, fenix: fenix);
  }

  bool isPrepared<S>({String? tag}) {
    return _instance.isPrepared<S>(tag: tag);
  }

  bool isRegistered<S>({String? tag}) {
    return _instance.isRegistered<S>(tag: tag);
  }

  void lazyPut<S>(
    InstanceBuilderCallback<S> builder, {
    String? tag,
    bool? fenix,
    bool permanent = false,
  }) {
    _instance.lazyPut<S>(
      builder,
      tag: tag,
      fenix: fenix,
      permanent: permanent,
    );
  }

  void markAsDirty<S>({String? tag, String? key}) {
    _instance.markAsDirty<S>(tag: tag, key: key);
  }

  S put<S>(
    S dependency, {
    String? tag,
    bool permanent = false,
  }) {
    return _instance.put<S>(
      dependency,
      tag: tag,
      permanent: permanent,
    );
  }

  Future<S> putAsync<S>(
    AsyncInstanceBuilderCallback<S> builder, {
    String? tag,
    bool permanent = false,
  }) {
    return _instance.putAsync<S>(
      builder,
      tag: tag,
      permanent: permanent,
    );
  }

  S putOrFind<S>(InstanceBuilderCallback<S> dep, {String? tag}) {
    return _instance.putOrFind<S>(dep, tag: tag);
  }

  void reload<S>({
    String? tag,
    String? key,
    bool force = false,
  }) {
    _instance.reload(tag: tag, key: key, force: force);
  }

  void reloadAll({bool force = false}) {
    _instance.reloadAll(force: force);
  }

  bool resetInstance({bool clearRouteBindings = true}) {
    return _instance.resetInstance(clearRouteBindings: true);
  }
}
