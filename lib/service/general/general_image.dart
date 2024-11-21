import 'dart:io';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../view/themes/custom_widget/interaction/custom_permission_denied_dialog.dart';
import '../../view/themes/custom_widget/interface/cujstom_photo_view.dart';
import '../../view_model/util/s3_image_provider.dart';
import 'general_functions.dart';

class GeneralImage {
  static Future<void> convertWidgetToPng({
    required GlobalKey key,
    required String fileName,
  }) async {
    final boundary = key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final bytes = byteData!.buffer.asUint8List();

    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = await File(filePath).writeAsBytes(bytes);

    await ImageGallerySaverPlus.saveFile(file.path, name: fileName);

    if (await file.exists()) {
      await file.delete();
    }
  }

  static Future<void> requestGalleryToImage(BuildContext context, S3ImageNotifier s3ImageNotifier) async {
    final status = await Permission.photos.status;

    if (status.isGranted || status.isLimited) {
      await _pickAndSetImage(s3ImageNotifier, ImageSource.gallery);
      return;
    }

    final requestStatus = await Permission.photos.request();

    if (requestStatus.isDenied || requestStatus.isRestricted) {
      GeneralFunctions.toastMessage('앨범 접근 권한이 필요해요');
      return;
    }

    if (requestStatus.isPermanentlyDenied) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const CustomPermissionDeniedDialog(
            message: '앨범 접근 권한이 필요해요. 설정에서 권한을 허용해 주세요.',
          ),
        );
      }
      return;
    }

    if (requestStatus.isGranted || requestStatus.isLimited) {
      await _pickAndSetImage(s3ImageNotifier, ImageSource.gallery);
      return;
    }
  }

  static Future<void> requestCameraToImage(BuildContext context, S3ImageNotifier s3ImageNotifier) async {
    final status = await Permission.camera.status;

    if (status.isGranted || status.isLimited) {
      await _pickAndSetImage(s3ImageNotifier, ImageSource.camera);
      return;
    }

    final requestStatus = await Permission.camera.request();

    if (requestStatus.isDenied || requestStatus.isRestricted) {
      GeneralFunctions.toastMessage('카메라 접근 권한이 필요해요');
      return;
    }

    if (requestStatus.isPermanentlyDenied) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const CustomPermissionDeniedDialog(
            message: '카메라 접근 권한이 필요해요. 설정에서 권한을 허용해 주세요.',
          ),
        );
      }
      return;
    }

    if (requestStatus.isGranted || requestStatus.isLimited) {
      await _pickAndSetImage(s3ImageNotifier, ImageSource.camera);
      return;
    }
  }

  static Future<void> _pickAndSetImage(S3ImageNotifier s3ImageNotifier, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageFile = File(image.path);
    int imageSize = await imageFile.length();

    int maxSizeInBytes = 10 * 1024 * 1024;

    if (imageSize > maxSizeInBytes) {
      GeneralFunctions.toastMessage('10MB 이하의 이미지만 업로드 가능해요');
      return;
    }

    List<File> pickedImage = [imageFile];
    await s3ImageNotifier.setImage(pickedImage);
  }

  static void pushImageView(BuildContext context, CachedNetworkImageProvider image) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => CustomPhotoView(image: image),
        transitionDuration: const Duration(milliseconds: 150),
        reverseTransitionDuration: const Duration(milliseconds: 150),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var curve = CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
            reverseCurve: Curves.fastOutSlowIn,
          );
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curve),
            child: child,
          );
        },
      ),
    );
  }
}
