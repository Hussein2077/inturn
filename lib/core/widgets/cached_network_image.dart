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
      imageUrl: 'https://www.gannett-cdn.com/-mm-/e2ac46bf6bf629d94619497199c0026ab22dc692/c=0-95-1955-1200/local/-/media/2017/10/17/WIGroup/Appleton/636438397538841392-2017-Toyota-Corolla-iM-5-door-hatchback.jpg?width=3200&height=1680&fit=crop',
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
