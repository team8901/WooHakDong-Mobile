import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/util/s3_image_provider.dart';

class ClubItemImageDialog extends StatelessWidget {
  final S3ImageNotifier s3ImageNotifier;

  const ClubItemImageDialog({
    super.key,
    required this.s3ImageNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.only(
          top: defaultPaddingS * 2,
          left: defaultPaddingS * 2,
          right: defaultPaddingS * 2,
          bottom: defaultPaddingXS * 2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadiusL),
          color: context.colorScheme.surfaceDim,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('물품 사진 추가', style: context.textTheme.titleMedium),
            const Gap(defaultPaddingXS * 2),
            InkWell(
              highlightColor: context.colorScheme.surfaceContainer,
              onTap: () {
                _shootItemImage(context);
                Navigator.pop(context);
              },
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPaddingS / 2),
                  child: Row(
                    children: [
                      const Icon(Symbols.camera_alt_rounded),
                      const Gap(defaultGapXL),
                      Text(
                        '사진 촬영',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(defaultGapS / 2),
            InkWell(
              highlightColor: context.colorScheme.surfaceContainer,
              onTap: () {
                _pickItemImage(context);
                Navigator.pop(context);
              },
              child: Ink(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultPaddingS / 2),
                  child: Row(
                    children: [
                      const Icon(Symbols.photo_library_rounded),
                      const Gap(defaultGapXL),
                      Text(
                        '사진 선택',
                        style: context.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shootItemImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);

    if (image != null) {
      final imageFile = File(image.path);
      await _setImage(imageFile, s3ImageNotifier);
    }
  }

  Future<void> _pickItemImage(BuildContext context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      final imageFile = File(image.path);
      await _setImage(imageFile, s3ImageNotifier);
    }
  }

  Future<void> _setImage(File imageFile, S3ImageNotifier s3ImageNotifier) async {
    List<File> pickedImage = [imageFile];
    await s3ImageNotifier.setImage(pickedImage);
  }
}
