import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_member/components/list_tile/club_member_item_history_list_tile.dart';
import 'package:woohakdong/view/themes/custom_widget/interaction/custom_circular_progress_indicator.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../view_model/item/item_history_list_by_member_provider.dart';
import '../../../view_model/item/item_provider.dart';
import '../../club_item/club_item_detail_page.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/spacing.dart';

class ClubMemberItemHistoryPanel extends ConsumerStatefulWidget {
  final String clubMemberName;
  final int clubMemberId;

  const ClubMemberItemHistoryPanel({
    super.key,
    required this.clubMemberName,
    required this.clubMemberId,
  });

  @override
  ConsumerState<ClubMemberItemHistoryPanel> createState() => _ClubMemberItemHistoryPanelState();
}

class _ClubMemberItemHistoryPanelState extends ConsumerState<ClubMemberItemHistoryPanel> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final itemHistoryDataByMember = ref.watch(itemHistoryListByMemberProvider(widget.clubMemberId));

    return Container(
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
            isExpanded: _isExpanded,
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
                        '${widget.clubMemberName}님의 물품 대여 내역 보기',
                        style: context.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
              );
            },
            body: itemHistoryDataByMember.when(
              data: (itemHistoryList) {
                if (itemHistoryList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(defaultPaddingM),
                    child: Center(
                      child: Text(
                        '아직 대여한 내역이 없어요',
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
                  itemBuilder: (context, index) {
                    final itemHistory = itemHistoryList[index];
                    bool itemOverdue = itemHistory.itemOverdue!;

                    if (itemHistory.itemReturnDate != null) {
                      itemOverdue = false;
                    }
                    return ClubMemberItemHistoryListTile(
                      clubMemberItemHistory: itemHistory,
                      onTap: () => _pushItemDetailPage(
                        ref,
                        context,
                        itemHistory.itemId!,
                        itemOverdue,
                      ),
                    );
                  },
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
          ),
        ],
      ),
    );
  }

  Future<void> _pushItemDetailPage(WidgetRef ref, BuildContext context, int itemId, bool itemOverdue) async {
    await ref.read(itemProvider.notifier).getItemInfo(itemId);

    if (context.mounted) {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => ClubItemDetailPage(itemOverdue: itemOverdue),
        ),
      );
    }
  }

  void _handleExpansion(bool isExpanded) {
    setState(
      () {
        _isExpanded = isExpanded;

        if (isExpanded) {
          ref
              .read(itemHistoryListByMemberProvider(widget.clubMemberId).notifier)
              .getItemHistoryListByMember(widget.clubMemberId);
        }
      },
    );
  }
}
