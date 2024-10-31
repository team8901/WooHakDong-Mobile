import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/view/club_item/components/club_item_rental_state_box.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../themes/custom_widget/interface/custom_info_content.dart';
import '../themes/spacing.dart';
import 'club_item_history_page.dart';
import 'components/club_item_photo_view.dart';

class ClubItemDetailPage extends ConsumerWidget {
  final Item itemInfo;

  const ClubItemDetailPage({
    super.key,
    required this.itemInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CachedNetworkImageProvider itemPhoto = CachedNetworkImageProvider(itemInfo.itemPhoto!);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _pushItemHistoryPage(context, itemInfo.itemId!),
            icon: const Icon(Symbols.history_rounded),
          ),

          /// TODO 물품 편집 추가하기
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.edit_rounded),
          ),

          /// TODO 물품 삭제 추가하기
          IconButton(
            onPressed: () {},
            icon: const Icon(Symbols.delete_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => _pushItemPhotoView(context, itemPhoto),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: CachedNetworkImage(
                    imageUrl: itemInfo.itemPhoto!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          width: double.infinity,
                          color: context.colorScheme.surfaceContainer,
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPaddingM),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        _translateItemCategory(itemInfo.itemCategory!),
                        style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
                      ),
                    ),
                    const Gap(defaultGapS),
                    Center(
                      child: Text(
                        itemInfo.itemName!,
                        style: context.textTheme.titleLarge,
                      ),
                    ),
                    const Gap(defaultGapS),
                    ClubItemRentalStateBox(isRented: itemInfo.itemUsing!),
                    const Gap(defaultGapXL * 2),
                    CustomInfoBox(
                      infoTitle: '물품 설명',
                      child: CustomInfoContent(
                        infoContent: itemInfo.itemDescription!,
                        icon: Icon(
                          Symbols.info_rounded,
                          size: 16,
                          color: context.colorScheme.outline,
                        ),
                      ),
                    ),
                    const Gap(defaultGapXL),
                    CustomInfoBox(
                      infoTitle: '물품 추가 정보',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInfoContent(
                            infoContent: itemInfo.itemLocation!,
                            icon: Icon(
                              Symbols.pin_drop_rounded,
                              size: 16,
                              color: context.colorScheme.outline,
                            ),
                          ),
                          const Gap(defaultGapM),
                          CustomInfoContent(
                            infoContent: '${itemInfo.itemRentalMaxDay!.toString()} 일',
                            icon: Icon(
                              Symbols.hourglass_rounded,
                              size: 16,
                              color: context.colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _translateItemCategory(String itemCategory) {
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

  void _pushItemPhotoView(BuildContext context, CachedNetworkImageProvider itemPhoto) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => ClubItemPhotoView(itemPhoto: itemPhoto),
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

  void _pushItemHistoryPage(BuildContext context, int itemId) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubItemHistoryPage(itemId: itemId),
      ),
    );
  }
}
