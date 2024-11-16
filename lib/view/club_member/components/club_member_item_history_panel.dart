import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../../model/item/item_history.dart';
import '../../../view_model/item/item_history_list_by_member_provider.dart';
import '../../club_item/components/list_tile/club_item_history_list_tile.dart';
import '../../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../../themes/custom_widget/interaction/custom_loading_skeleton.dart';
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

                /// TODO API 만들어지면 리스트 타일 수정 => 아이템 이름, 아이템 ID

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: itemHistoryList.length,
                  itemBuilder: (context, index) => ClubItemHistoryListTile(
                    itemHistory: itemHistoryList[index],
                  ),
                );
              },
              loading: () => CustomLoadingSkeleton(
                isLoading: true,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: 3,
                  itemBuilder: (context, index) => ClubItemHistoryListTile(
                    itemHistory: ItemHistory(
                      memberName: '우학동',
                      itemRentalDate: DateTime.now(),
                      itemReturnDate: DateTime.now(),
                    ),
                  ),
                ),
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
