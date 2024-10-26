import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/text_style.dart';

/// 주요 색상
const Color primary = Color(0xFF1A74E8);
const Color secondaryPrimary = Color(0xFFD7E8FF);
const Color red = Color(0xFFE53935);
const Color green = Color(0xFF43A047);

/// 그레이 스케일
const Color black = Color(0xFF202020);
const Color darkGray = Color(0xFF7E7E7E);
const Color gray = Color(0xFFB7B7B7);
const Color lightGray = Color(0xFFE7E7E7);
const Color white = Color(0xFFFCFCFC);

final ThemeData lightTheme = ThemeData(
  /// 기본
  brightness: Brightness.light,
  primaryColor: primary,
  scaffoldBackgroundColor: white,
  applyElevationOverlayColor: false,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

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
    backgroundColor: white,
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
    backgroundColor: white,
    elevation: 1,
    selectedItemColor: black,
    unselectedItemColor: black,
    selectedLabelStyle: CustomTextStyle.labelLarge,
    unselectedLabelStyle: CustomTextStyle.labelLarge,
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
    selectedIconTheme: const IconThemeData(size: 24),
    unselectedIconTheme: const IconThemeData(size: 24),
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
      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
    ),
    color: lightGray,
    labelTextStyle: WidgetStateProperty.all(CustomTextStyle.bodySmall),
    elevation: 1,
    menuPadding: const EdgeInsets.all(defaultPaddingS / 2),
  ),

  /// 다이어로그 테마
  dialogTheme: DialogTheme(
    backgroundColor: lightGray,
    surfaceTintColor: lightGray,
    elevation: 1,
    alignment: Alignment.center,
    insetPadding: const EdgeInsets.symmetric(horizontal: defaultPaddingM * 2),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultBorderRadiusM),
    ),
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
    elevation: 1,
    modalElevation: 1,
    showDragHandle: true,
    dragHandleColor: gray,
  ),

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
    labelPadding: const EdgeInsets.symmetric(horizontal: defaultPaddingS),
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
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultBorderRadiusL * 2),
    ),
    iconSize: 20,
    extendedTextStyle: CustomTextStyle.titleSmall.copyWith(color: white),
  ),
);
