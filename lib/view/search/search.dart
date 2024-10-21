import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:the_movie_box/logic/search/search_bloc.dart';
import 'package:the_movie_box/view/view.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isMovie = true; // Toggle between movie and TV
  final searchBloc = SearchBloc();
  void _toggleSearchType() {
    setState(() {
      _isMovie = !_isMovie;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies/TV'),
      ),
      body: BlocProvider(
        create: (context) => searchBloc,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: _searchController,
                keyboardType: TextInputType.text,
                autofocus: true,
                textInputAction: TextInputAction.search,
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    if (_isMovie) {
                      searchBloc.add(SearchMovieEvent(value));
                    } else {
                      searchBloc.add(SearchTvEvent(value));
                    }
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Search your favorite shows',
                  suffixIcon: Switch(
                    value: !_isMovie,
                    thumbIcon: _isMovie
                        ? const WidgetStatePropertyAll(Icon(Icons.movie))
                        : const WidgetStatePropertyAll(Icon(Icons.live_tv)),
                    onChanged: (value) {
                      _toggleSearchType();
                    },
                  ),
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.search),
                  //   onPressed: () {
                  //     final query = _searchController.text;
                  //     if (query.isNotEmpty) {
                  //       if (_isMovie) {
                  //         searchBloc.add(SearchMovieEvent(query));
                  //       } else {
                  //         searchBloc.add(SearchTvEvent(query));
                  //       }
                  //     }
                  //   },
                  // ),
                ),
              ),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchLoadedState) {
                      return ShowViewBuilder(
                          onTap: (id) => Navigator.of(context).pushNamed(
                              _isMovie
                                  ? Routes.movieDetails
                                  : Routes.seriesDetail,
                              arguments: id),
                          showList: state.results);
                    } else if (state is SearchErrorState) {
                      return Center(child: Text(state.error));
                    }
                    return const Center(
                        child: Text('Search for movies or TV shows'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
