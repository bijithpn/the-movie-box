import 'package:flutter/material.dart';

import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/core/constants/image.dart';
import 'package:the_movie_box/data/model/movie_model.dart';

import '../../widgets/widgets.dart';

class ShowViewBuilder extends StatelessWidget {
  final List<Show> showList;
  final Function(int id) onTap;
  final ScrollController? scrollController;

  const ShowViewBuilder({
    super.key,
    required this.showList,
    required this.onTap,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return showList.isEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AppImages.satellite,
                width: MediaQuery.of(context).size.width / 1.6,
              ),
              const SizedBox(height: 15),
              Text(
                "Whoops! Movie Not Found 😕",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "Yikes! That show slipped through the cracks. Try another shows!",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              )
            ],
          )
        : GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: .6,
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemCount: showList.length,
            padding: const EdgeInsets.all(12.0),
            itemBuilder: (context, index) {
              var show = showList[index];
              return InkWell(
                onTap: () => onTap(show.id),
                child: CachedImageWidget(
                    key: ValueKey(show.id),
                    fit: BoxFit.cover,
                    imageUrl: APIConfig.imageURL + show.posterPath),
              );
            },
          );
  }
}
