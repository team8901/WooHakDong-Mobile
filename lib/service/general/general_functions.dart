import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_formatter/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../view/themes/custom_widget/interaction/custom_permission_denied_dialog.dart';
import '../../view/themes/custom_widget/interface/cujstom_photo_view.dart';
import '../../view_model/util/s3_image_provider.dart';

class GeneralFunctions {
  static Future<bool?> toastMessage(String msg) async {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      fontSize: 14,
      fontAsset: 'assets/fonts/pretendard/Pretendard-SemiBold.otf',
      backgroundColor: const Color(0xFF6C6E75).withOpacity(0.8),
      textColor: const Color(0xFFFCFCFC),
    );
  }

  /// 회원 정보 관련 함수
  static String formatMemberPhoneNumber(String memberPhoneNumber) {
    final formattedPhoneNumber = memberPhoneNumber.replaceFirstMapped(
      RegExp(r'^(\d{3})(\d{4})(\d{4})$'),
      (Match m) => '${m[1]}-${m[2]}-${m[3]}',
    );
    return formattedPhoneNumber;
  }

  static String formatMemberGender(String? gender) {
    if (gender == 'MAN') {
      return '남성';
    } else {
      return '여성';
    }
  }

  /// 동아리 정보 관련 함수
  static String formatClubGeneration(String clubGeneration) {
    String formattedGeneration = '$clubGeneration기';

    return formattedGeneration;
  }

  static String formatClubDues(int clubDues) {
    String formattedDues = CurrencyFormatter.format(
      clubDues.toString(),
      const CurrencyFormat(
        symbol: '원',
        symbolSide: SymbolSide.right,
        symbolSeparator: '',
        thousandSeparator: ',',
      ),
    );

    return formattedDues;
  }

  static String formatClubRole(String role) {
    switch (role) {
      case 'PRESIDENT':
        return '회장';
      case 'VICEPRESIDENT':
        return '부회장';
      case 'SECRETARY':
        return '총무';
      case 'OFFICER':
        return '임원진';
      case 'MEMBER':
        return '회원';
      default:
        return '회원';
    }
  }

  static String formatClubAssignedTerm(String term) {
    final date = DateTime.tryParse(term);

    if (date == null) return term;

    final year = date.year;
    final month = date.month;

    if (month >= 1 && month <= 6) {
      return '$year년 1학기';
    } else if (month >= 7 && month <= 12) {
      return '$year년 2학기';
    }

    return term;
  }

  /// 물품 정보 관련 함수
  static String formatItemCategory(String itemCategory) {
    switch (itemCategory) {
      case 'DIGITAL':
        return '디지털';
      case 'SPORT':
        return '스포츠';
      case 'BOOK':
        return '도서';
      case 'CLOTHES':
        return '의류';
      case 'STATIONERY':
        return '문구류';
      case 'ETC':
        return '기타';
      default:
        return '전체';
    }
  }

  /// 이미지 관련 함수
  static Future<void> requestCameraToImage(BuildContext context, S3ImageNotifier s3ImageNotifier) async {
    final status = await Permission.camera.status;

    if (status.isGranted || status.isLimited) {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imageFile = File(image.path);
        List<File> pickedImage = [imageFile];
        await s3ImageNotifier.setImage(pickedImage);
      }
    } else {
      final requestStatus = await Permission.camera.request();

      if (requestStatus.isGranted || requestStatus.isLimited) {
        final image = await ImagePicker().pickImage(source: ImageSource.camera);
        if (image != null) {
          final imageFile = File(image.path);
          List<File> pickedImage = [imageFile];
          await s3ImageNotifier.setImage(pickedImage);
        }
      } else if (requestStatus.isPermanentlyDenied) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => const CustomPermissionDeniedDialog(
              message: '카메라 접근 권한이 필요해요. 설정에서 권한을 허용해 주세요.',
            ),
          );
        }
      } else if (requestStatus.isDenied || requestStatus.isRestricted) {
        GeneralFunctions.toastMessage('카메라 접근 권한이 필요해요');
      }
    }
  }

  static Future<void> requestGalleryToImage(BuildContext context, S3ImageNotifier s3ImageNotifier) async {
    final status = await Permission.photos.status;

    if (status.isGranted || status.isLimited) {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageFile = File(image.path);
        List<File> pickedImage = [imageFile];
        await s3ImageNotifier.setImage(pickedImage);
      }
    } else {
      final requestStatus = await Permission.photos.request();

      if (requestStatus.isGranted || requestStatus.isLimited) {
        final image = await ImagePicker().pickImage(source: ImageSource.gallery);
        if (image != null) {
          final imageFile = File(image.path);
          List<File> pickedImage = [imageFile];
          await s3ImageNotifier.setImage(pickedImage);
        }
      } else if (requestStatus.isPermanentlyDenied) {
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => const CustomPermissionDeniedDialog(
              message: '앨범 접근 권한이 필요해요. 설정에서 권한을 허용해 주세요.',
            ),
          );
        }
      } else if (requestStatus.isDenied || requestStatus.isRestricted) {
        GeneralFunctions.toastMessage('앨범 접근 권한이 필요해요');
      }
    }
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
