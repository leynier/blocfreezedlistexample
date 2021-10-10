import 'package:blocfreezedlistexample/detail_page.dart';
import 'package:blocfreezedlistexample/home_cubit.dart';
import 'package:blocfreezedlistexample/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..setData(),
      child: const HomeWiew(),
    );
  }
}

class HomeWiew extends StatelessWidget {
  const HomeWiew({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.map(
          loading: (_) {
            return const HomeLoading();
          },
          loaded: (state) {
            return HomeLoaded(state: state);
          },
        );
      },
    );
  }
}

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({
    Key? key,
    required this.state,
  }) : super(key: key);

  final HomeStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final model in state.models)
          HomeItem(
            model: model,
            state: state,
          ),
      ],
    );
  }
}

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key,
    required this.model,
    required this.state,
  }) : super(key: key);

  final Model model;
  final HomeStateLoaded state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(model.name),
      subtitle: Text(model.isSelected.toString()),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailPage(
              bloc: context.read<HomeCubit>(),
              id: model.id,
            ),
          ),
        );
      },
    );
  }
}

class HomeLoading extends StatelessWidget {
  const HomeLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
