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
              IconButton(
                onPressed: () => _pushItemHistoryPage(context, itemId),
                icon: const Icon(Symbols.history_rounded),
              ),
              IconButton(
                onPressed: () => _pushItemEditPage(context, itemInfo),
                icon: const Icon(Symbols.border_color_rounded),
              ),
              IconButton(
                onPressed: () => _deleteItem(context, ref),
                icon: const Icon(Symbols.delete_rounded),
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
}
