import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:blocfreezedlistexample/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState.loading());

  void setData() {
    final models = [
      Model(
        id: "1",
        name: "name1",
        isSelected: false,
      ),
      Model(
        id: "2",
        name: "name2",
        isSelected: false,
      ),
      Model(
        id: "3",
        name: "name3",
        isSelected: false,
      ),
    ];
    emit(HomeState.loaded(models: models));
  }

  void changeItem(HomeStateLoaded state, String id) {
    emit(
      HomeState.loaded(
        models: state.models
            .map((model) => model.id == id
                ? model.copyWith(isSelected: !model.isSelected)
                : model)
            .toList(),
      ),
    );
  }

  @override
  void onChange(Change<HomeState> change) {
    super.onChange(change);
    final current = change.currentState.map(
      loading: (_) => "Loading",
      loaded: (_) => "Loaded",
    );
    final next = change.nextState.map(
      loading: (_) => "Loading",
      loaded: (_) => "Loaded",
    );
    log("Change { currentState: $current, nextState: $next }");
  }
}
