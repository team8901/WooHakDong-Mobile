import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/club_item/club_item_edit_page.dart';
import 'package:woohakdong/view/club_item/components/club_item_history_panel.dart';
import 'package:woohakdong/view/themes/custom_widget/dialog/custom_interaction_dialog.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../model/item/item.dart';
import '../../view_model/item/item_provider.dart';
import '../themes/spacing.dart';
import 'components/club_item_info_box.dart';

class ClubItemDetailPage extends ConsumerWidget {
  const ClubItemDetailPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemInfo = ref.watch(itemProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async => await _toggleItemRentAvailable(
              context,
              ref,
              itemInfo.itemId!,
              itemInfo.itemAvailable!,
            ),
            icon:
                itemInfo.itemAvailable! ? const Icon(Symbols.block_rounded) : const Icon(Symbols.check_circle_rounded),
          ),
          IconButton(
            onPressed: () => _pushItemEditPage(context, itemInfo),
            icon: const Icon(Symbols.edit_rounded),
          ),
          IconButton(
            onPressed: () async => await _deleteItem(context, ref, itemInfo),
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
                onTap: () {
                  CachedNetworkImageProvider itemImage = CachedNetworkImageProvider(itemInfo.itemPhoto!);
                  GeneralFunctions.pushImageView(context, itemImage);
                },
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
              const Gap(defaultGapXL),
              ClubItemInfoBox(itemInfo: itemInfo),
              const Gap(defaultGapXL),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
                child: Text(
                  '대여 내역',
                  style: context.textTheme.labelLarge,
                ),
              ),
              const Gap(defaultGapM),
              ClubItemHistoryPanel(
                itemName: itemInfo.itemName!,
                itemId: itemInfo.itemId!,
              ),
              const Gap(defaultGapXL),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _toggleItemRentAvailable(BuildContext context, WidgetRef ref, int itemId, bool itemAvailable) async {
    try {
      final bool? isAvailable = await showDialog<bool>(
        context: context,
        builder: (context) => CustomInteractionDialog(
          dialogTitle: '대여 가능 여부 변경',
          dialogContent: itemAvailable ? '다음 대여부터 대여 불가로 변경할게요.' : '대여 가능으로 변경할게요.',
          dialogButtonText: '변경',
          dialogButtonColor: context.colorScheme.primary,
        ),
      );

      if (isAvailable != true) return;

      await ref.read(itemProvider.notifier).toggleItemRentAvailable(itemId, !itemAvailable);
      GeneralFunctions.toastMessage('대여 가능 여부가 변경되었어요');
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }

  void _pushItemEditPage(BuildContext context, Item itemInfo) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => ClubItemEditPage(itemInfo: itemInfo),
      ),
    );
  }

  Future<void> _deleteItem(BuildContext context, WidgetRef ref, Item item) async {
    try {
      if (item.itemUsing!) {
        GeneralFunctions.toastMessage('현재 대여 중인 물품은 삭제할 수 없어요');
        return;
      }

      final bool? isDelete = await showDialog<bool>(
        context: context,
        builder: (context) => const CustomInteractionDialog(
          dialogTitle: '물품 삭제',
          dialogContent: '물품을 삭제하면 되돌릴 수 없어요.',
        ),
      );

      if (isDelete != true) return;

      await ref.read(itemProvider.notifier).deleteItem(item.itemId!);
      GeneralFunctions.toastMessage('물품이 삭제되었어요');

      if (!context.mounted) return;
      Navigator.pop(context);
    } catch (e) {
      GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
    }
  }
}
