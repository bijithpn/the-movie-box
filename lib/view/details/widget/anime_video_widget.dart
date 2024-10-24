import 'package:flutter/material.dart';
import 'package:the_movie_box/data/model/anime_details_model.dart';
import 'package:the_movie_box/view/widgets/cached_image.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeVideoWidget extends StatelessWidget {
  final List<Video> animeVideos;
  const AnimeVideoWidget({
    super.key,
    required this.animeVideos,
  });

  @override
  Widget build(BuildContext context) {
    return animeVideos.isEmpty
        ? const SizedBox.shrink()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: animeVideos.length,
            padding: const EdgeInsets.only(top: 15, left: 5),
            itemBuilder: (_, i) {
              var video = animeVideos[i];
              return ListTile(
                onTap: () async {
                  await launchUrl(Uri.parse(video.url));
                },
                leading: CachedImageWidget(
                  width: 90,
                  fit: BoxFit.cover,
                  height: 100,
                  imageUrl: 'https:${video.imageUrl}',
                ),
                title: Text(
                  video.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.clip,
                ),
                subtitle: Text(
                  video.kind,
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.clip,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            });
  }
}
