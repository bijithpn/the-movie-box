import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:the_movie_box/logic/details/details_bloc.dart';
import 'package:the_movie_box/utils/utils.dart';

import '../widgets/widgets.dart';
import 'widget/widget.dart';

class AnimeDetailsView extends StatefulWidget {
  final String animeId;
  const AnimeDetailsView({
    super.key,
    required this.animeId,
  });

  @override
  State<AnimeDetailsView> createState() => _AnimeDetailsViewState();
}

class _AnimeDetailsViewState extends State<AnimeDetailsView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DetailsBloc>(context).add(GetAnimeDetails(widget.animeId));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => context.pop(context),
                  icon: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.arrow_back, size: 20))),
            ),
            backgroundColor: Colors.transparent,
            actions: [
              IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Utils.deeplinkCreater(
                        route: 'animedetails', showId: widget.animeId);
                  },
                  icon: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          shape: BoxShape.circle),
                      child: const Icon(Icons.share, size: 20))),
            ],
          ),
          body:
              BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
            if (state is DetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is AnimeDetailsLoaded) {
              var anime = state.anime;

              return SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MainImageView(
                        title: anime.poster.mainUrl,
                        imageurl: anime.poster.mainUrl,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        anime.english,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      if (anime.studios.isNotEmpty)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Studios ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  top: 2, bottom: 7),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                anime.studios
                                                    .map((e) => e.name)
                                                    .join(', '),
                                                maxLines: 4,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      height: 1.5,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                              anime.releasedOn.year.toString()),
                                          if (anime.duration > 0)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Text(
                                                  "Duration: ${anime.duration} min"),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                CachedImageWidget(
                                  width: 120,
                                  height: 140,
                                  imageUrl: anime.poster.mainUrl,
                                )
                              ],
                            ),
                            const SizedBox(height: 7),
                            Wrap(spacing: 10, children: [
                              ...anime.genres.map((e) => Chip(
                                      label: Text(
                                    e.name,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ))),
                            ]),
                            if (anime.description.isNotEmpty)
                              Column(
                                children: [
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey.shade400,
                                  ),
                                  Text(
                                    anime.description,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 7),
                                    width: double.infinity,
                                    height: 1,
                                    color: Colors.grey.shade400,
                                  ),
                                ],
                              ),
                            ScrollableTab(
                              isScrollable: true,
                              tabAlignment: TabAlignment.start,
                              tabs: [
                                if (anime.characterRoles.isNotEmpty &&
                                    anime.personRoles.isNotEmpty)
                                  const Tab(
                                    text: "CHARACTERS + CREW",
                                  ),
                                if (anime.videos.isNotEmpty)
                                  const Tab(
                                    text: "VIDEOS",
                                  ),
                                if (anime.screenshots.isNotEmpty)
                                  const Tab(
                                    text: "SCREENSHOTS",
                                  )
                              ],
                              children: [
                                if (anime.characterRoles.isNotEmpty &&
                                    anime.personRoles.isNotEmpty)
                                  Column(
                                    children: [
                                      AnimeCharacterWidget(
                                          characterList: anime.characterRoles),
                                      AnimeCrewWidget(
                                          crewList: anime.personRoles)
                                    ],
                                  ),
                                if (anime.videos.isNotEmpty)
                                  AnimeVideoWidget(animeVideos: anime.videos),
                                if (anime.screenshots.isNotEmpty)
                                  AnimeImageSlider(
                                    imgList: anime.screenshots,
                                  ),
                              ],
                            ),
                            AnimeExternallinkWidget(
                                externalLinks: anime.externalLinks),
                            AnimeRelatedWidget(relatedAnime: anime.related)
                          ],
                        ),
                      ),
                    ]),
              );
            }
            return Center(
                child: Text(
              "Opps something went wrong!",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ));
          })),
    );
  }
}
