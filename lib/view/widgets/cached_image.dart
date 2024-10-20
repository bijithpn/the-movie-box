import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    this.placeholder,
    this.errorWidget,
    this.imageBuilder,
    this.border,
    this.borderRadius,
    this.decoration,
    this.height,
    required this.imageUrl,
    this.width,
    this.fit,
  });

  final Widget Function(BuildContext, String)? placeholder;
  final Widget Function(BuildContext, String, Object)? errorWidget;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final BoxDecoration? decoration;
  final double? height;
  final String imageUrl;
  final double? width;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: imageUrl,
      fit: fit,
      placeholder: placeholder ??
          (context, url) => Container(
              width: width,
              height: height,
              decoration: decoration ??
                  BoxDecoration(
                    border: border ??
                        Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(10)),
                  ),
              child: const Center(child: CircularProgressIndicator())),
      errorWidget: errorWidget ??
          (context, url, error) => Container(
              width: width,
              height: height,
              decoration: decoration ??
                  BoxDecoration(
                    border: border ??
                        Border.all(color: Colors.grey.shade400, width: 1),
                    borderRadius: borderRadius ??
                        const BorderRadius.all(Radius.circular(10)),
                  ),
              child: const Center(child: Icon(Icons.error))),
      imageBuilder: imageBuilder ??
          (context, imageProvider) => Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border:
                    border ?? Border.all(color: Colors.grey.shade400, width: 1),
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              )),
    );
  }
}
