import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FlagImage extends StatelessWidget {
  final String flagUrl;

  const FlagImage({
    super.key,
    required this.flagUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: flagUrl,
      progressIndicatorBuilder: (context, child, loadingProgress) {
        return SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, error, stackTrace) {
        return Center(
            child: Text('Error loading the image',
                style: TextStyle(fontSize: 25)));
      },
    );
  }
}
