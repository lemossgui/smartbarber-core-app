abstract class ScreenState {}

class EmptyState<T> extends ScreenState {
  final T? data;
  EmptyState({this.data});
}

class LoadingState<T> extends ScreenState {
  final T? data;
  LoadingState({this.data});
}

class StableState<T> extends ScreenState {
  final T? data;
  StableState({this.data});
}

class ErrorState<T> extends ScreenState {
  final T? data;
  ErrorState({this.data});
}
