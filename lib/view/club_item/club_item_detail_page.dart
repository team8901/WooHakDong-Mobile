import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/model/item/item.dart';
import 'package:woohakdong/view/club_item/components/club_item_rental_state_box.dart';
import 'package:woohakdong/view/themes/custom_widget/custom_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../themes/custom_widget/custom_info_content.dart';
import '../themes/spacing.dart';
import 'club_item_history_page.dart';

class ClubItemDetailPage extends ConsumerWidget {
  final Item itemInfo;

  const ClubItemDetailPage({
    super.key,
    required this.itemInfo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _pushItemDetailPage(context, itemInfo.itemId!),
            icon: const Icon(Symbols.history_rounded),
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
              AspectRatio(
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
                      child: Text(
                        itemInfo.itemDescription!,
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                    const Gap(defaultGapXL),
                    CustomInfoBox(
                      infoTitle: '물품 추가 정보',
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomInfoContent(infoContent: itemInfo.itemLocation!),
                          const Gap(defaultGapM),
                          CustomInfoContent(infoContent: '${itemInfo.itemRentalMaxDay!.toString()} 일'),
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

  void _pushItemDetailPage(BuildContext context, int itemId) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubItemHistoryPage(itemId: itemId),
      ),
    );
  }
}
