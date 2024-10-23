import 'package:flutter/material.dart';

import 'package:the_movie_box/data/model/anime_details_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimeExternallinkWidget extends StatelessWidget {
  final List<ExternalLink> externalLinks;
  const AnimeExternallinkWidget({
    super.key,
    required this.externalLinks,
  });

  @override
  Widget build(BuildContext context) {
    return externalLinks.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade400,
              ),
              Text(
                "View In Socials",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 5,
                children: List.generate(externalLinks.length, (i) {
                  var external = externalLinks[i];
                  return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).splashColor,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        await launchUrl(Uri.parse(external.url));
                      },
                      child: Text(
                        external.kind,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ));
                }),
              ),
            ],
          );
  }
}
