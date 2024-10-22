import 'package:flutter/material.dart';
import 'package:the_movie_box/data/model/external_id_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalLinkWidget extends StatelessWidget {
  final ExternalIds? externalIds;
  const ExternalLinkWidget({super.key, required this.externalIds});

  @override
  Widget build(BuildContext context) {
    return externalIds == null
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
                children: [
                  if (externalIds!.facebookId.isNotEmpty)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          await launchUrl(Uri.parse(
                              'https://www.facebook.com/${externalIds!.facebookId}'));
                        },
                        child: Text(
                          "FACEBOOK",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  if (externalIds!.instagramId.isNotEmpty)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          launchUrl(Uri.parse(
                              'https://www.instagram.com/${externalIds!.instagramId}'));
                        },
                        child: Text(
                          "INSTAGRAM",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  if (externalIds!.imdbId.isNotEmpty)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          launchUrl(Uri.parse(
                              'https://www.imdb.com/title/${externalIds!.imdbId}'));
                        },
                        child: Text(
                          "IMDB",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  if (externalIds!.twitterId.isNotEmpty)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          launchUrl(Uri.parse(
                              'https://x.com/${externalIds!.twitterId}'));
                        },
                        child: Text(
                          "X",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  if (externalIds!.wikidataId.isNotEmpty)
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).splashColor,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          launchUrl(Uri.parse(
                              'https://www.wikidata.org/wiki/${externalIds!.wikidataId}'));
                        },
                        child: Text(
                          "WIKIPEDIA",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 7),
                width: double.infinity,
                height: 1,
                color: Colors.grey.shade400,
              ),
            ],
          );
  }
}
