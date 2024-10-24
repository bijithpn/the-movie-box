import 'package:flutter/material.dart';
import 'package:the_movie_box/core/config/api_config.dart';
import 'package:the_movie_box/data/model/cast_and_crew_model.dart';
import 'package:the_movie_box/view/view.dart';

class CastWidget extends StatelessWidget {
  final double? height;
  final List<Cast> castList;
  const CastWidget({
    super.key,
    this.height = 175,
    required this.castList,
  });

  @override
  Widget build(BuildContext context) {
    return castList.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: height,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: castList.length,
                padding: const EdgeInsets.only(top: 15, left: 5),
                itemBuilder: (_, i) {
                  var cast = castList[i];
                  return Container(
                    width: 130,
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        CachedImageWidget(
                            imageUrl: APIConfig.imageURL + cast.profilePath,
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => Container(
                                  width: 75,
                                  alignment: Alignment.center,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(cast.name.split(' ').first),
                                ),
                            placeholder: (_, __) => Container(
                                  width: 75,
                                  alignment: Alignment.center,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                ),
                            imageBuilder: (_, imageProvider) => Container(
                                  width: 75,
                                  height: 75,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: imageProvider)),
                                )),
                        const SizedBox(height: 9),
                        Text(
                          cast.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cast.character,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}
