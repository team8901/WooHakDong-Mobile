import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/text_style.dart';

/// 주요 색상
const Color primary = Color(0xFF3D63DD);
const Color secondaryPrimary = Color(0xFF172448);
const Color red = Color(0xFFE53935);
const Color green = Color(0xFF43A047);

/// 그레이 스케일
const Color background = Color(0xFF111111);
const Color black = Color(0xFF19191B);
const Color darkGray = Color(0xFF393A40);
const Color gray = Color(0xFF5F606A);
const Color lightGray = Color(0xFFB2B3BD);
const Color white = Color(0xFFEEEEF0);

final ThemeData darkTheme = ThemeData(
  /// 기본
  brightness: Brightness.dark,
  primaryColor: primary,
  scaffoldBackgroundColor: background,
  applyElevationOverlayColor: false,
  splashColor: Colors.transparent,
  highlightColor: Colors.transparent,

  extensions: const [SkeletonizerConfigData.dark()],

  /// 컬러 스키마
  colorScheme: const ColorScheme.dark(
    primary: primary,
    inversePrimary: white,
    secondary: secondaryPrimary,
    surfaceContainer: darkGray,
    onSurface: lightGray,
    inverseSurface: white,
    outline: gray,
    error: red,
    onError: white,
    tertiary: green,
    onTertiary: white,
    surfaceDim: black,
    surfaceBright: darkGray,
    onInverseSurface: gray,
    surfaceContainerHighest: background,
  ),

  /// 텍스트 테마
  textTheme: TextTheme(
    headlineLarge: CustomTextStyle.headerLarge.copyWith(color: white),
    headlineSmall: CustomTextStyle.headerSmall.copyWith(color: white),
    titleLarge: CustomTextStyle.titleLarge.copyWith(color: white),
    titleMedium: CustomTextStyle.titleMedium.copyWith(color: white),
    titleSmall: CustomTextStyle.titleSmall.copyWith(color: white),
    bodyLarge: CustomTextStyle.bodyLarge.copyWith(color: white),
    bodyMedium: CustomTextStyle.bodyMedium.copyWith(color: white),
    bodySmall: CustomTextStyle.bodySmall.copyWith(color: white),
    labelLarge: CustomTextStyle.labelLarge.copyWith(color: white),
  ),

  /// 텍스트 선택 테마
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: white,
    selectionColor: lightGray,
    selectionHandleColor: primary,
  ),

  /// 쿠퍼티노 텍스트 선택 테마
  cupertinoOverrideTheme: const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: primary,
  ),

  /// 앱바 테마
  appBarTheme: AppBarTheme(
    backgroundColor: background,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: false,
    titleTextStyle: CustomTextStyle.titleLarge.copyWith(color: white),
    iconTheme: const IconThemeData(color: white),
    actionsIconTheme: const IconThemeData(color: white),
  ),

  /// 아이콘 테마
  iconTheme: const IconThemeData(
    color: white,
  ),

  /// 바텀 네비게이션바 테마
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: background,
    elevation: 1,
    selectedItemColor: white,
    unselectedItemColor: gray,
    selectedLabelStyle: CustomTextStyle.labelLarge.copyWith(fontWeight: FontWeight.w600),
    unselectedLabelStyle: CustomTextStyle.labelLarge.copyWith(color: white),
    type: BottomNavigationBarType.fixed,
    enableFeedback: false,
    selectedIconTheme: const IconThemeData(fill: 1),
    unselectedIconTheme: const IconThemeData(fill: 0),
  ),

  /// 서치바 태마
  searchBarTheme: SearchBarThemeData(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: const WidgetStatePropertyAll(darkGray),
    surfaceTintColor: const WidgetStatePropertyAll(darkGray),
    side: const WidgetStatePropertyAll(BorderSide.none),
    shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadiusM)),
    )),
    textStyle: WidgetStatePropertyAll(CustomTextStyle.titleSmall.copyWith(color: white)),
    hintStyle: WidgetStatePropertyAll(CustomTextStyle.titleSmall.copyWith(color: lightGray)),
  ),

  /// 스낵바 테마
  snackBarTheme: SnackBarThemeData(
    backgroundColor: black,
    contentTextStyle: CustomTextStyle.bodySmall.copyWith(color: white),
  ),

  /// 팝업 메뉴 버튼 테마
  popupMenuTheme: PopupMenuThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(defaultBorderRadiusL),
    ),
    color: black,
    elevation: 3,
    menuPadding: const EdgeInsets.all(defaultPaddingS / 2),
  ),

  /// 바텀 시트 테마
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: black,
    modalBackgroundColor: black,
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
  dialogBackgroundColor: black,
  dialogTheme: const DialogTheme(backgroundColor: black),

  /// 탭바 테마
  tabBarTheme: TabBarTheme(
    indicator: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: white,
          width: 2,
        ),
      ),
    ),
    indicatorColor: white,
    indicatorSize: TabBarIndicatorSize.tab,
    dividerColor: Colors.transparent,
    dividerHeight: 0,
    labelColor: white,
    labelPadding: const EdgeInsets.symmetric(horizontal: defaultPaddingS),
    labelStyle: CustomTextStyle.bodyMedium.copyWith(color: white),
    unselectedLabelColor: white,
    unselectedLabelStyle: CustomTextStyle.bodySmall.copyWith(color: white),
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
    thumbColor: WidgetStateProperty.all(darkGray),
  ),

  /// 텍스트 버튼 테마
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: WidgetStateProperty.all(CustomTextStyle.bodyMedium),
      foregroundColor: WidgetStateProperty.all(primary),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.all(darkGray),
    ),
  ),
);
