import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:the_movie_box/data/model/anime_details_model.dart';
import 'package:the_movie_box/view/view.dart';

class AnimeImageSlider extends StatefulWidget {
  final List<Screenshot> imgList;

  const AnimeImageSlider({super.key, required this.imgList});

  @override
  State<AnimeImageSlider> createState() => _AnimeImageSliderState();
}

class _AnimeImageSliderState extends State<AnimeImageSlider> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          CarouselSlider(
            items: widget.imgList
                .map((item) => CachedImageWidget(
                    imageUrl: item.originalUrl, fit: BoxFit.cover))
                .toList(),
            options: CarouselOptions(
              height: 250,
              viewportFraction: 1,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: widget.imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _currentIndex = entry.key;
                  }),
                  child: Container(
                    width: 90.0,
                    height: 60.0,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: _currentIndex == entry.key
                              ? Theme.of(context).splashColor
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: CachedImageWidget(
                      imageUrl: entry.value.originalUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
