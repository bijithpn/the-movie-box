import 'package:flutter/material.dart';
import 'package:the_movie_box/data/model/video_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/widgets.dart';

class VideosWidget extends StatelessWidget {
  final List<Videos> videos;
  const VideosWidget({
    super.key,
    required this.videos,
  });

  @override
  Widget build(BuildContext context) {
    return videos.isEmpty
        ? const SizedBox.shrink()
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: videos.length,
            padding: const EdgeInsets.only(top: 15, left: 5),
            itemBuilder: (_, i) {
              var video = videos[i];
              return ListTile(
                onTap: () async {
                  await launchUrl(
                      Uri.parse('http://www.youtube.com/watch?v=${video.key}'));
                },
                leading: CachedImageWidget(
                  width: 90,
                  fit: BoxFit.cover,
                  height: 100,
                  imageUrl:
                      "https://img.youtube.com/vi/${video.key}/hqdefault.jpg",
                ),
                title: Text(
                  video.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.clip,
                ),
                subtitle: Text(
                  "Platform: ${video.site}",
                  style: Theme.of(context).textTheme.bodySmall,
                  overflow: TextOverflow.clip,
                ),
                trailing: const Icon(Icons.arrow_forward_ios),
              );
            });
  }
}
