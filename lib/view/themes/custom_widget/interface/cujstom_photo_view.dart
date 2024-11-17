import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class CustomPhotoView extends StatelessWidget {
  final CachedNetworkImageProvider image;

  const CustomPhotoView({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Color(0xFFEEEEF0)),
      ),
      body: PhotoView(
        imageProvider: image,
        backgroundDecoration: const BoxDecoration(color: Color(0xFF111111)),
        maxScale: PhotoViewComputedScale.covered * 3,
        minScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
