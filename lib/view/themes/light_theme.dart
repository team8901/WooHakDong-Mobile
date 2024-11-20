import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/text_style.dart';

/// 주요 색상
const Color primary = Color(0xFF1A74E8);
const Color secondaryPrimary = Color(0xFFE6EFFC);
const Color red = Color(0xFFE53935);
const Color green = Color(0xFF43A047);

/// 그레이 스케일
const Color background = Color(0xFFFCFCFC);
const Color black = Color(0xFF202020);
const Color darkGray = Color(0xFF7E7E7E);
const Color gray = Color(0xFFB7B7B7);
const Color lightGray = Color(0xFFE7E7E7);
const Color white = Color(0xFFF5F5F5);

final ThemeData lightTheme = ThemeData(
  /// 기본
  brightness: Brightness.light,
  primaryColor: primary,
  scaffoldBackgroundColor: background,
  applyElevationOverlayColor: false,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

  extensions: const [SkeletonizerConfigData()],

  /// 컬러 스키마
  colorScheme: const ColorScheme.light(
    primary: primary,
    inversePrimary: white,
    secondary: secondaryPrimary,
    surfaceContainer: lightGray,
    onSurface: darkGray,
    inverseSurface: black,
    outline: gray,
    error: red,
    onError: white,
    tertiary: green,
    onTertiary: white,
    surfaceDim: white,
    surfaceBright: white,
    onInverseSurface: lightGray,
    surfaceContainerHighest: background,
  ),

  /// 텍스트 테마
  textTheme: TextTheme(
    headlineLarge: CustomTextStyle.headerLarge,
    headlineSmall: CustomTextStyle.headerSmall,
    titleLarge: CustomTextStyle.titleLarge,
    titleMedium: CustomTextStyle.titleMedium,
    titleSmall: CustomTextStyle.titleSmall,
    bodyLarge: CustomTextStyle.bodyLarge,
    bodyMedium: CustomTextStyle.bodyMedium,
    bodySmall: CustomTextStyle.bodySmall,
    labelLarge: CustomTextStyle.labelLarge,
  ),

  /// 텍스트 선택 테마
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: black,
    selectionColor: gray,
    selectionHandleColor: primary,
  ),

  /// 쿠퍼티노 텍스트 선택 테마
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
  ),

  /// 앱바 테마
  appBarTheme: AppBarTheme(
    backgroundColor: background,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: CustomTextStyle.titleLarge,
    iconTheme: const IconThemeData(color: black),
    actionsIconTheme: const IconThemeData(color: black),
  ),

  /// 아이콘 테마
  iconTheme: const IconThemeData(
    color: black,
  ),

  /// 바텀 네비게이션바 테마
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: background,
    elevation: 1,
    selectedItemColor: black,
    unselectedItemColor: gray,
    selectedLabelStyle: CustomTextStyle.labelLarge.copyWith(fontWeight: FontWeight.w600),
    unselectedLabelStyle: CustomTextStyle.labelLarge,
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
    selectedIconTheme: const IconThemeData(fill: 1),
    unselectedIconTheme: const IconThemeData(fill: 0),
  ),

  /// 서치바 태마
  searchBarTheme: SearchBarThemeData(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: const WidgetStatePropertyAll(lightGray),
    surfaceTintColor: const WidgetStatePropertyAll(lightGray),
    side: const WidgetStatePropertyAll(BorderSide.none),
    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadiusM)),
    )),
    textStyle: WidgetStatePropertyAll(CustomTextStyle.titleSmall),
    hintStyle: WidgetStatePropertyAll(CustomTextStyle.titleSmall.copyWith(color: gray)),
  ),

  /// 스낵바 테마
  snackBarTheme: SnackBarThemeData(
    backgroundColor: lightGray,
    contentTextStyle: CustomTextStyle.bodySmall.copyWith(color: black),
  ),

  /// 팝업 메뉴 버튼 테마
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultBorderRadiusL),
    ),
    color: white,
    elevation: 3,
    menuPadding: const EdgeInsets.all(defaultPaddingS / 2),
  ),

  /// 바텀 시트 테마
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: white,
    modalBackgroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(defaultBorderRadiusL),
        topRight: Radius.circular(defaultBorderRadiusL),
      ),
    ),
    showDragHandle: true,
    dragHandleColor: gray,
  ),

  /// 다이얼로그 테마
  dialogBackgroundColor: white,
  dialogTheme: const DialogTheme(backgroundColor: white),

  /// 탭바 테마
  tabBarTheme: TabBarTheme(
    indicator: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: black,
          width: 2,
        ),
      ),
    ),
    indicatorColor: black,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    dividerHeight: 0,
    labelColor: black,
    labelStyle: CustomTextStyle.bodyMedium,
    unselectedLabelColor: black,
    unselectedLabelStyle: CustomTextStyle.bodySmall,
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    tabAlignment: TabAlignment.center,
  ),

  /// 플로팅 액션 버튼 테마
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: primary,
    foregroundColor: white,
    shape: const CircleBorder(),
    extendedTextStyle: CustomTextStyle.titleSmall.copyWith(color: white),
  ),

  /// 스크롤바 테마
  scrollbarTheme: ScrollbarThemeData(
    thickness: WidgetStateProperty.all(2),
    radius: const Radius.circular(4),
    thumbColor: WidgetStateProperty.all(lightGray),
  ),

  /// 텍스트 버튼 테마
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(CustomTextStyle.bodyMedium),
      foregroundColor: WidgetStateProperty.all(primary),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.all(lightGray),
    ),
  ),
);
