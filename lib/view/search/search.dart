import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
  bool _isMovie = true;
  late SearchBloc searchBloc;
  void _toggleSearchType() {
    setState(() {
      _isMovie = !_isMovie;
    });
  }

  @override
  void initState() {
    searchBloc = BlocProvider.of<SearchBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Movies/TV',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (value) {
                    if (value.isNotEmpty) {
                      if (_isMovie) {
                        searchBloc.add(SearchMovieEvent(value.trim()));
                      } else {
                        searchBloc.add(SearchTvEvent(value.trim()));
                      }
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search your favorite shows',
                    suffixIcon: Switch(
                      value: !_isMovie,
                      thumbIcon: _isMovie
                          ? const WidgetStatePropertyAll(Icon(
                              Icons.movie,
                            ))
                          : const WidgetStatePropertyAll(Icon(
                              Icons.live_tv,
                            )),
                      onChanged: (value) {
                        _toggleSearchType();
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                if (state is SearchLoadedState && state.results.isNotEmpty)
                  Text(
                    "Search Results",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                      if (state is SearchLoadingState) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is SearchLoadedState) {
                        return ShowViewBuilder(
                            onTap: (id) => context.push(
                                  _isMovie
                                      ? Routes.movieDetails(id)
                                      : Routes.seriesDetail(id),
                                ),
                            showList: state.results);
                      } else if (state is SearchErrorState) {
                        return Center(child: Text(state.error));
                      }
                      return Center(
                          child: Text(
                        'Search for movies or TV shows',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
