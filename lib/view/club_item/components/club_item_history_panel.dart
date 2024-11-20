import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/club_member/club_member_provider.dart';
import '../../../view_model/item/item_history_list_provider.dart';
import '../../club_item/components/list_tile/club_item_history_list_tile.dart';
import '../../club_member/club_member_detail_page.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import '../../themes/spacing.dart';

class ClubItemHistoryPanel extends ConsumerStatefulWidget {
  final String itemName;
  final int itemId;

  const ClubItemHistoryPanel({
    super.key,
    required this.itemName,
    required this.itemId,
  });

  @override
  ConsumerState<ClubItemHistoryPanel> createState() => _ClubItemHistoryPanelState();
}

class _ClubItemHistoryPanelState extends ConsumerState<ClubItemHistoryPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final itemHistoryData = ref.watch(itemHistoryListProvider(widget.itemId));

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.surfaceContainer),
        borderRadius: BorderRadius.circular(defaultBorderRadiusM),
      ),
      clipBehavior: Clip.antiAlias,
      child: ExpansionPanelList(
        elevation: 0,
        expandedHeaderPadding: EdgeInsets.zero,
        expansionCallback: (_, __) => _handleExpansion(!_isExpanded),
        children: [
          ExpansionPanel(
            backgroundColor: Colors.transparent,
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPaddingS,
                  vertical: defaultPaddingXS,
                ),
                child: Row(
                  children: [
                    Icon(
                      Symbols.history_rounded,
                      size: 16,
                      color: context.colorScheme.outline,
                    ),
                    const Gap(defaultGapM),
                    Expanded(
                      child: Text(
                        '${widget.itemName} 대여 내역 보기',
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              );
            },
            body: itemHistoryData.when(
              data: (itemHistoryList) {
                if (itemHistoryList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(defaultPaddingM),
                    child: Center(
                      child: Text(
                        '아직 대여 내역이 없어요',
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: itemHistoryList.length,
                  itemBuilder: (context, index) => ClubItemHistoryListTile(
                    itemHistory: itemHistoryList[index],
                    onTap: () => _pushMemberDetailPage(ref, context, itemHistoryList[index].clubMemberId!),
                  ),
                );
              },
              loading: () => CustomProgressIndicator(
                indicatorColor: context.colorScheme.surfaceContainer,
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(defaultPaddingM),
                child: Center(
                  child: Text(
                    '대여 내역을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            isExpanded: _isExpanded,
          ),
        ],
      ),
    );
  }

  Future<void> _pushMemberDetailPage(WidgetRef ref, BuildContext context, int clubMemberId) async {
    await ref.read(clubMemberProvider.notifier).getClubMemberInfo(clubMemberId);

    if (context.mounted) {
      Navigator.of(context).push(
        CupertinoPageRoute(
          builder: (context) => const ClubMemberDetailPage(),
        ),
      );
    }
  }

  void _handleExpansion(bool isExpanded) {
    setState(
      () {
        _isExpanded = isExpanded;
        if (isExpanded) {
          ref.read(itemHistoryListProvider(widget.itemId).notifier).getItemHistoryList(widget.itemId);
        }
      },
    );
  }
}
