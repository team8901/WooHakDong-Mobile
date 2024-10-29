import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/item/item.dart';
import '../../../view_model/item/item_provider.dart';
import '../../themes/custom_widget/custom_circular_progress_indicator.dart';
import '../../themes/custom_widget/custom_divider.dart';
import '../../themes/spacing.dart';
import '../club_item_detail_page.dart';

class ClubItemPageView extends ConsumerWidget {
  final String? filterCategory;

  const ClubItemPageView({
    super.key,
    this.filterCategory,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: FutureBuilder(
        future: ref.watch(itemProvider.notifier).getItemList(),
        builder: (context, itemListSnapshot) {
          if (itemListSnapshot.connectionState == ConnectionState.waiting) {
            return const CustomCircularProgressIndicator();
          } else {
            final itemList = itemListSnapshot.data;

            final filteredList = filterCategory != null
                ? itemList!.where((item) => item.itemCategory == filterCategory).toList()
                : itemList;

            if (itemList!.isEmpty) {
              return Center(
                child: Text(
                  '아직 등록된 물품이 없어요',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                ),
              );
            } else if (filteredList!.isEmpty) {
              return Center(
                child: Text(
                  '${_translateItemCategory(filterCategory!)} 카테고리에 등록된 물품이 없어요',
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                ),
              );
            }

            return CustomMaterialIndicator(
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 750));
                ref.refresh(itemProvider);
              },
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) => const CustomDivider(),
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  final CachedNetworkImageProvider imageProvider =
                      CachedNetworkImageProvider(filteredList[index].itemPhoto!);

                  return InkWell(
                    onTap: () => _pushItemDetailPage(context, filteredList[index]),
                    highlightColor: context.colorScheme.surfaceContainer,
                    child: Ink(
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPaddingM),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 72.r,
                              height: 72.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: context.colorScheme.surfaceContainer,
                                  width: 1,
                                ),
                              ),
                            ),
                            const Gap(defaultGapM),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredList[index].itemName!,
                                    style: context.textTheme.bodyLarge,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Gap(defaultGapS / 4),
                                  Row(
                                    children: [
                                      Text(
                                        _translateItemCategory(filteredList[index].itemCategory!),
                                        style: context.textTheme.bodySmall?.copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                      const Gap(defaultGapS),
                                      SizedBox(
                                        height: 8,
                                        child: VerticalDivider(
                                          color: context.colorScheme.outline,
                                          width: 1,
                                        ),
                                      ),
                                      const Gap(defaultGapS),
                                      Text(
                                        filteredList[index].itemLocation!,
                                        style: context.textTheme.bodySmall?.copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(defaultGapS / 2),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      (filteredList[index].itemUsing!)
                                          ? Icon(
                                              Symbols.lock_clock_rounded,
                                              color: context.colorScheme.primary,
                                              size: 16,
                                            )
                                          : Icon(
                                              Symbols.lock_open_rounded,
                                              color: context.colorScheme.onSurface,
                                              size: 16,
                                            ),
                                      const Gap(defaultGapS / 2),
                                      (filteredList[index].itemUsing!)
                                          ? Text(
                                              '대여 중',
                                              style: context.textTheme.labelLarge?.copyWith(
                                                color: context.colorScheme.onSurface,
                                              ),
                                            )
                                          : Text(
                                              '보관 중',
                                              style: context.textTheme.labelLarge?.copyWith(
                                                color: context.colorScheme.onSurface,
                                              ),
                                            ),
                                      const Gap(defaultGapS),
                                      Icon(
                                        Symbols.history_rounded,
                                        color: context.colorScheme.onSurface,
                                        size: 16,
                                      ),
                                      const Gap(defaultGapS / 2),
                                      Text(
                                        filteredList[index].itemRentalTime!.toString(),
                                        style: context.textTheme.labelLarge?.copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
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

  void _pushItemDetailPage(BuildContext context, Item itemInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubItemDetailPage(itemInfo: itemInfo),
      ),
    );
  }
}
