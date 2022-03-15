import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCachedImage extends StatelessWidget {
  final String image;
  final BoxFit? boxFit;
  const CustomCachedImage({Key? key, required this.image, this.boxFit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => Center(child: Image.asset("assets/images/flags/placeholder.jpeg")),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit??BoxFit.fill,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Center(child: Image.asset("assets/images/flags/placeholder.jpeg")),
      ),
    );
  }
}
