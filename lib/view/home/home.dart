import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/data/model/movie_model.dart';
import 'package:the_movie_box/logic/bloc/home_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeBloc _homeBloc = HomeBloc();
  @override
  void initState() {
    _homeBloc.add(GetMovies());
    super.initState();
  }

  Widget _buildCard(BuildContext context, List<MovieResult> model) {
    return ListView.builder(
      itemCount: model.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[Text(model[index].name)],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("title"),
      ),
      body: BlocProvider(
        create: (_) => _homeBloc,
        child: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {},
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return _buildLoading();
              } else if (state is HomeLoaded) {
                return _buildCard(context, state.movieList);
              } else if (state is HomeError) {
                return Text(state.message ?? "Error");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
