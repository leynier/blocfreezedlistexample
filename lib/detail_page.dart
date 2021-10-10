import 'package:blocfreezedlistexample/home_cubit.dart';
import 'package:blocfreezedlistexample/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    Key? key,
    required this.bloc,
    required this.id,
  }) : super(key: key);

  final HomeCubit bloc;
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: DetailWiew(id: id),
    );
  }
}

class DetailWiew extends StatelessWidget {
  const DetailWiew({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: DetailBody(id: id),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.map(
          loading: (_) {
            return const DetailLoading();
          },
          loaded: (state) {
            return DetailLoaded(state: state, id: id);
          },
        );
      },
    );
  }
}

class DetailLoaded extends StatelessWidget {
  const DetailLoaded({
    Key? key,
    required this.state,
    required this.id,
  }) : super(key: key);

  final HomeStateLoaded state;
  final String id;

  Model get model => state.models.firstWhere((model) => model.id == id);

  @override
  Widget build(BuildContext context) {
    return DetailItem(
      model: model,
      state: state,
    );
  }
}

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.model,
    required this.state,
  }) : super(key: key);

  final Model model;
  final HomeStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(model.name),
      value: model.isSelected,
      onChanged: (_) => context.read<HomeCubit>().changeItem(state, model.id),
    );
  }
}

class DetailLoading extends StatelessWidget {
  const DetailLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
