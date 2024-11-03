import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_item/club_item_edit_page.dart';
import 'package:woohakdong/view/club_item/components/club_item_rental_state_box.dart';
import 'package:woohakdong/view/themes/custom_widget/interface/custom_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/item/item.dart';
import '../../view_model/item/item_provider.dart';
import '../themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import '../themes/custom_widget/interface/custom_info_content.dart';
import '../themes/spacing.dart';
import 'club_item_history_page.dart';
import 'components/dialog/club_item_delete_dialog.dart';

class ClubItemDetailPage extends ConsumerWidget {
  final int itemId;

  const ClubItemDetailPage({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(itemProvider.notifier).getItemById(itemId),
      builder: (context, itemSnapshot) {
        if (itemSnapshot.connectionState != ConnectionState.done) {
          return const Scaffold(body: CustomCircularProgressIndicator());
        } else if (itemSnapshot.hasError || itemSnapshot.data == null) {
          return const Scaffold(body: CustomCircularProgressIndicator());
        }

        final itemInfo = itemSnapshot.data!;
        final CachedNetworkImageProvider itemPhoto = CachedNetworkImageProvider(itemInfo.itemPhoto!);

        return Scaffold(
          appBar: AppBar(
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Symbols.more_vert_rounded, grade: 600,),
                onSelected: (value) async {
                  switch (value) {
                    case 'available':
                      await _toggleItemRentAvailable(context, ref, itemInfo.itemAvailable!);
                      break;
                    case 'history':
                      _pushItemHistoryPage(context, itemId);
                      break;
                    case 'edit':
                      _pushItemEditPage(context, itemInfo);
                      break;
                    case 'delete':
                      await _deleteItem(context, ref);
                      break;
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'available',
                    child: Row(
                      children: [
                        const Icon(Symbols.swap_horiz_rounded, size: 16),
                        const Gap(defaultGapS),
                        Text(
                          '대여 가능 여부 변경',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'history',
                    child: Row(
                      children: [
                        const Icon(Symbols.history_rounded, size: 16),
                        const Gap(defaultGapS),
                        Text(
                          '대여 이력',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'edit',
                    child: Row(
                      children: [
                        const Icon(Symbols.border_color_rounded, size: 16),
                        const Gap(defaultGapS),
                        Text(
                          '물품 수정',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      children: [
                        const Icon(Symbols.delete_rounded, size: 16),
                        const Gap(defaultGapS),
                        Text(
                          '물품 삭제',
                          style: context.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => GeneralFunctions.pushImageView(context, itemPhoto),
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
                            GeneralFunctions.formatItemCategory(itemInfo.itemCategory!),
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
                        if (itemInfo.itemAvailable != null && !itemInfo.itemAvailable!)
                          Column(
                            children: [
                              const Gap(defaultGapS),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: defaultPaddingS - 8,
                                  vertical: defaultPaddingXS - 8,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.error,
                                  borderRadius: BorderRadius.circular(defaultBorderRadiusM / 2),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Symbols.block_rounded,
                                      size: 16,
                                      color: context.colorScheme.inversePrimary,
                                    ),
                                    const Gap(defaultGapS),
                                    Text(
                                      '대여 불가',
                                      style: context.textTheme.titleSmall?.copyWith(
                                        color: context.colorScheme.inversePrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
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
                                infoContent: '${itemInfo.itemRentalMaxDay!.toString()}일 대여 가능',
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
      },
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

  void _pushItemEditPage(BuildContext context, Item itemInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubItemEditPage(itemInfo: itemInfo),
      ),
    );
  }

  Future<void> _deleteItem(BuildContext context, WidgetRef ref) async {
    try {
      final bool? isDelete = await showDialog<bool>(
        context: context,
        builder: (context) => const ClubItemDeleteDialog(),
      );

      if (isDelete == true) {
        await ref.read(itemProvider.notifier).deleteItem(itemId);

        if (context.mounted) {
          GeneralFunctions.toastMessage('물품이 삭제되었어요');
          Navigator.pop(context);
        }
      }
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }

  Future<void> _toggleItemRentAvailable(BuildContext context, WidgetRef ref, bool itemAvailable) async {
    try {
      await ref.read(itemProvider.notifier).toggleItemRentAvailable(itemId, !itemAvailable);
      GeneralFunctions.toastMessage('대여 가능 여부가 변경되었어요');
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
