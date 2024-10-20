import 'package:flutter/material.dart';
import 'package:the_movie_box/core/config/api_config.dart';

import 'package:the_movie_box/data/model/platform_model.dart';
import 'package:the_movie_box/view/view.dart';

class WatchProviderWidget extends StatelessWidget {
  final List<Buy> watchProvider;
  const WatchProviderWidget({
    super.key,
    required this.watchProvider,
  });

  @override
  Widget build(BuildContext context) {
    return watchProvider.isEmpty
        ? const SizedBox.shrink()
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            itemCount: watchProvider.length,
            itemBuilder: (_, i) {
              var buyer = watchProvider[i];
              return ListTile(
                leading: CachedImageWidget(
                  width: 50,
                  height: 50,
                  imageUrl: APIConfig.imageURL + buyer.logoPath,
                ),
                title: Text(
                  buyer.providerName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              );
            });
  }
}
