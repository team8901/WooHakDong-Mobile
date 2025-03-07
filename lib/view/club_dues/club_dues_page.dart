import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/club_dues/components/club_dues_account_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/current_club_account_info_provider.dart';
import 'package:woohakdong/view_model/dues/dues_list_provider.dart';

import '../../model/club_member/club_member_me.dart';
import '../../model/dues/dues.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/club_member/club_member_me_provider.dart';
import '../../view_model/dues/components/dues_refresh_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_loading_skeleton.dart';
import '../themes/custom_widget/interaction/custom_refresh_indicator.dart';
import 'club_dues_search_page.dart';
import 'components/club_dues_in_out_type_bottom_sheet.dart';
import 'components/club_dues_list_tile.dart';
import 'components/club_dues_month_picker.dart';

class ClubDuesPage extends ConsumerStatefulWidget {
  const ClubDuesPage({super.key});

  @override
  ConsumerState<ClubDuesPage> createState() => _ClubDuesPageState();
}

class _ClubDuesPageState extends ConsumerState<ClubDuesPage> {
  String? _duesInOutType;
  DateTime _duesDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final clubAccountInfo = ref.watch(currentClubAccountInfoProvider);
    final duesListData = ref.watch(duesListProvider(DateFormat('yyyy-MM-dd').format(_duesDateTime)));
    final clubMemberMe = ref.watch(clubMemberMeProvider);
    final isLoading = ref.watch(duesRefreshProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('회비'),
        actions: [
          IconButton(
            onPressed: () => _pushItemSearchPage(context),
            icon: const Icon(Symbols.search_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: CustomRefreshIndicator(
          onRefresh: () async => await _refreshDuesList(clubMemberMe),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  ClubDuesAccountInfoBox(
                    clubMemberMe: clubMemberMe,
                    currentClubAccount: clubAccountInfo,
                    duesInOutType: _duesInOutType ?? 'ALL',
                    duesDateTime: _duesDateTime,
                    onRefresh: _refreshDuesList,
                    isLoading: isLoading,
                    onInOutTypeTap: () {
                      showModalBottomSheet(
                        useSafeArea: true,
                        context: context,
                        builder: (context) => ClubDuesInOutTypeBottomSheet(
                          onTypeSelect: _selectInOutType,
                          duesInOutType: _duesInOutType ?? 'ALL',
                        ),
                      );
                    },
                    onDateTimeTap: () async {
                      final scheduleDate = await clubDuesMonthPicker(context, _duesDateTime);

                      if (scheduleDate != null) {
                        setState(() => _duesDateTime = scheduleDate);
                      }
                    },
                  ),
                  duesListData.when(
                    data: (duesList) {
                      final filteredDuesList = _filterDuesList(duesList, _duesInOutType);

                      if (filteredDuesList.isEmpty) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: Center(
                            child: Text(
                              '${_getFilterText(_duesInOutType)} 내역이 없어요',
                              style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                            ),
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                        itemCount: filteredDuesList.length,
                        itemBuilder: (context, index) => ClubDuesListTile(dues: filteredDuesList[index]),
                      );
                    },
                    loading: () => CustomLoadingSkeleton(
                      isLoading: true,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                        itemCount: 10,
                        itemBuilder: (context, index) => ClubDuesListTile(
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
                    error: (error, stack) => SizedBox(
                      height: MediaQuery.of(context).size.height * 0.5,
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
        ),
      ),
    );
  }

  void _pushItemSearchPage(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(builder: (context) => const ClubDuesSearchPage()),
    );
  }

  Future<void> _refreshDuesList(ClubMemberMe clubMemberMe) async {
    if (clubMemberMe.clubMemberRole != 'PRESIDENT') {
      await GeneralFunctions.toastMessage('회장만 회비 내역을 업데이트할 수 있어요');
      return;
    }

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      await ref.read(duesListProvider(DateFormat('yyyy-MM-dd').format(_duesDateTime)).notifier).refreshDuesList();
      ref.invalidate(duesListProvider(DateFormat('yyyy-MM-dd').format(_duesDateTime)));
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

  void _selectInOutType(String? duesInOutType) {
    setState(() {
      _duesInOutType = duesInOutType;
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
