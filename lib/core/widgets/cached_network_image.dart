import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/constant_api.dart';
import 'package:shimmer/shimmer.dart';
class CachedNetworkCustom extends StatelessWidget {
  const CachedNetworkCustom({super.key, required this.url,   this.height,   this.width});
final String url;
final double? height;
final double? width;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height??AppSize.defaultSize!*4.2,
      width: width??AppSize.defaultSize!*4.2,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.defaultSize!),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
              // colorFilter:
              // const ColorFilter.mode(Colors.red, BlendMode.colorBurn)
           ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[850]!,
        highlightColor: Colors.grey[800]!,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(AppSize.defaultSize!),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
