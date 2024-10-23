import 'package:flutter/material.dart';
import 'package:the_movie_box/data/model/anime_details_model.dart';
import 'package:the_movie_box/view/widgets/cached_image.dart';

class AnimeCharacterWidget extends StatelessWidget {
  final double? height;
  final List<CharacterRole> characterList;
  const AnimeCharacterWidget({
    super.key,
    this.height = 175,
    required this.characterList,
  });

  @override
  Widget build(BuildContext context) {
    return characterList.isEmpty
        ? const SizedBox.shrink()
        : SizedBox(
            height: 175,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: characterList.length,
                padding: const EdgeInsets.only(top: 15, left: 5),
                itemBuilder: (_, i) {
                  var cast = characterList[i];
                  return Container(
                    width: 130,
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      children: [
                        CachedImageWidget(
                            imageUrl: cast.character.poster?.mainUrl ?? "",
                            fit: BoxFit.cover,
                            errorWidget: (_, __, ___) => Container(
                                  width: 75,
                                  alignment: Alignment.center,
                                  height: 75,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).splashColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                      cast.character.name.split(' ').first),
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
                          cast.character.name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          cast.rolesEn.first,
                          style: Theme.of(context).textTheme.bodySmall,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.clip,
                        ),
                      ],
                    ),
                  );
                }),
          );
  }
}
