import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/club_dues/components/club_dues_account_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/current_club_account_info_provider.dart';
import 'package:woohakdong/view_model/dues/dues_list_provider.dart';

import '../../model/club_member/club_member_me.dart';
import '../../model/dues/dues.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/club_member/club_member_me_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import '../themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'components/club_dues_in_out_type_bottom_sheet.dart';
import 'components/club_dues_list_tile.dart';

class ClubDuesPage extends ConsumerStatefulWidget {
  const ClubDuesPage({super.key});

  @override
  ConsumerState<ClubDuesPage> createState() => _ClubDuesPageState();
}

class _ClubDuesPageState extends ConsumerState<ClubDuesPage> {
  String? _duesInOutType;

  @override
  Widget build(BuildContext context) {
    final clubAccountInfo = ref.watch(currentClubAccountInfoProvider);
    final duesListData = ref.watch(duesListProvider(null));
    final clubMemberMe = ref.watch(clubMemberMeProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: () async => await _refreshDuesList(clubMemberMe),
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              const SliverAppBar(
                title: Text('회비'),
                floating: true,
                snap: true,
              ),
              SliverToBoxAdapter(
                child: ClubDuesAccountInfoBox(
                  clubMemberMe: clubMemberMe,
                  currentClubAccount: clubAccountInfo,
                  duesInOutType: _duesInOutType ?? 'ALL',
                  onRefresh: _refreshDuesList,
                  onTap: () => showModalBottomSheet(
                    useSafeArea: true,
                    context: context,
                    builder: (context) => ClubDuesInOutTypeBottomSheet(
                      onTypeSelect: _selectInOutType,
                      duesInOutType: _duesInOutType ?? 'ALL',
                    ),
                  ),
                ),
              ),
              duesListData.when(
                data: (duesList) {
                  final filteredDuesList = _filterDuesList(duesList, _duesInOutType);

                  if (filteredDuesList.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          '${_getFilterText(_duesInOutType)} 내역이 없어요',
                          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                        ),
                      ),
                    );
                  }

                  return SliverList.separated(
                    itemCount: filteredDuesList.length,
                    separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                    itemBuilder: (context, index) => ClubDuesListTile(dues: filteredDuesList[index]),
                  );
                },
                loading: () => SliverList.separated(
                  itemCount: 50,
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemBuilder: (context, index) => CustomLoadingSkeleton(
                    isLoading: true,
                    child: ClubDuesListTile(
                      dues: Dues(
                        clubAccountHistoryId: index,
                        clubAccountHistoryTranDate: DateTime.now(),
                        clubAccountHistoryInOutType: 'DEPOSIT',
                        clubAccountHistoryBalanceAmount: 1000000,
                        clubAccountHistoryTranAmount: 20000,
                        clubAccountHistoryContent: '회비 납부',
                      ),
                    ),
                  ),
                ),
                error: (error, stack) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text(
                      '회비 사용 내역을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _refreshDuesList(ClubMemberMe clubMemberMe) async {
    if (clubMemberMe.clubMemberRole != 'PRESIDENT' && clubMemberMe.clubMemberRole != 'SECRETARY') {
      await GeneralFunctions.toastMessage('회장 및 총무만 회비 내역을 업데이트할 수 있어요');
      return;
    }

    try {
      await ref.read(duesListProvider(null).notifier).refreshDuesList();
      ref.invalidate(duesListProvider(null));
      await ref.read(currentClubAccountInfoProvider.notifier).getCurrentClubAccountInfo();

      await GeneralFunctions.toastMessage('회비 내역을 새로 불러왔어요');
    } catch (e) {
      await GeneralFunctions.toastMessage('새로운 회비 내역을 불러오지 못했어요');
    }
  }

  List<Dues> _filterDuesList(List<Dues> duesList, String? duesInOutType) {
    if (duesInOutType == null || duesInOutType == 'ALL') {
      return duesList;
    }
    return duesList.where((dues) => dues.clubAccountHistoryInOutType == duesInOutType).toList();
  }

  void _selectInOutType(String? type) {
    setState(() {
      _duesInOutType = type;
    });
  }

  String _getFilterText(String? type) {
    switch (type) {
      case 'DEPOSIT':
        return '입금';
      case 'WITHDRAW':
        return '출금';
      default:
        return '회비 사용';
    }
  }
}
