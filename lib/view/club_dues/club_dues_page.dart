import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/view/club_dues/components/club_dues_account_info_box.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/current_club_account_info_provider.dart';
import 'package:woohakdong/view_model/dues/dues_list_provider.dart';

import '../../model/dues/dues.dart';
import '../../service/general/general_functions.dart';
import '../../view_model/club_member/club_member_me_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_loading_skeleton.dart';
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
      appBar: AppBar(
        title: const Text('회비'),
      ),
      body: SafeArea(
        child: CustomMaterialIndicator(
          onRefresh: () async {
            if (clubMemberMe.clubMemberRole != 'PRESIDENT') {
              await GeneralFunctions.toastMessage('동아리 회장만 회비 내역을 업데이트할 수 있어요');
              return;
            }

            try {
              await ref.read(duesListProvider(null).notifier).refreshDuesList();
              await ref.read(currentClubAccountInfoProvider.notifier).getCurrentClubAccountInfo();

              await GeneralFunctions.toastMessage('회비 내역을 새로 불러왔어요');
            } catch (e) {
              await GeneralFunctions.toastMessage('새로운 회비 내역을 불러오지 못했어요');
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ClubDuesAccountInfoBox(
                  currentClubAccount: clubAccountInfo,
                  duesInOutType: _duesInOutType ?? 'ALL',
                  onTypeSelect: _selectInOutType,
                ),
                duesListData.when(
                  data: (duesList) {
                    final filteredDuesList = _filterDuesList(duesList, _duesInOutType);

                    filteredDuesList.sort(
                      (a, b) => b.clubAccountHistoryTranDate!.compareTo(a.clubAccountHistoryTranDate!),
                    );

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
                  error: (error, stack) => Center(
                    child: Text(
                      '회비 사용 내역을 불러오는 중 오류가 발생했어요\n다시 시도해 주세요',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
