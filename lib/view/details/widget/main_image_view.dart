import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MainImageView extends StatelessWidget {
  final String imageurl;
  const MainImageView({
    super.key,
    required this.imageurl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 270,
      fit: BoxFit.cover,
      placeholder: (_, __) => const Center(child: CircularProgressIndicator()),
      imageUrl: imageurl,
      imageBuilder: (_, imageProvider) => Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 270,
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image:
                    DecorationImage(image: imageProvider, fit: BoxFit.cover)),
          ),
          // Gradient overlay for fading effect
          Positioned.fill(
            child: Container(
              height: 270,
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent, // Start with transparent
                    Theme.of(context).scaffoldBackgroundColor.withOpacity(0.3),
                    Theme.of(context).scaffoldBackgroundColor,
                  ],
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
