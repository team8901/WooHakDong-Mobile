import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/util/s3_image_url.dart';
import '../../repository/util/s3_image_url_info.dart';
import 'components/s3_image_state.dart';

final s3ImageProvider = StateNotifierProvider<S3ImageNotifier, S3ImageState>((ref) {
  return S3ImageNotifier();
});

class S3ImageNotifier extends StateNotifier<S3ImageState> {
  S3ImageUrlInfo s3ImageUrlInfo = S3ImageUrlInfo();

  S3ImageNotifier()
      : super(
          S3ImageState(
            pickedImages: [],
            s3ImageUrls: [],
          ),
        );

  Future<void> setPickedImages(List<File> pickedImages, String imageCount) async {
    List<S3ImageUrl> imageUrls = await s3ImageUrlInfo.getS3ImageUrl(imageCount);

    state = S3ImageState(
      pickedImages: pickedImages,
      s3ImageUrls: imageUrls.map((url) => url.imageUrl).toList(),
    );
  }

  Future<void> resetPickedImages() async {
    state = S3ImageState(
      pickedImages: [],
      s3ImageUrls: [],
    );
  }
}
