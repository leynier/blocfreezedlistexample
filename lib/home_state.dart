part of 'home_cubit.dart';

mixin PrintLoadingState {
  @override
  String toString() => "HomeState.loading()";
}

mixin PrintLoadedState {
  @override
  String toString() => "HomeState.loaded()";
}

@freezed
abstract class HomeState with _$HomeState {
  @With<PrintLoadingState>()
  const factory HomeState.loading() = HomeStateLoading;
  @With<PrintLoadedState>()
  const factory HomeState.loaded({
    required List<Model> models,
  }) = HomeStateLoaded;
}
