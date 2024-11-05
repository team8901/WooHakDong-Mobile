import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woohakdong/model/club/current_club_account.dart';
import 'package:woohakdong/view/club_dues/components/club_dues_account_info_box.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';
import 'package:woohakdong/view_model/club/current_club_account_info_provider.dart';
import 'package:woohakdong/view_model/dues/dues_provider.dart';

import '../../model/dues/dues.dart';
import '../../service/general/general_functions.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('회비'),
      ),
      body: SafeArea(
        child: CustomMaterialIndicator(
          onRefresh: () async {
            try {
              await ref.read(duesProvider.notifier).refreshDuesList();
              await ref.refresh(duesProvider.notifier).getDuesList(null);

              await GeneralFunctions.toastMessage('회비 내역을 업데이트 했어요');
            } catch (e) {
              await GeneralFunctions.toastMessage('회비 내역 업데이트에 실패했어요');
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FutureBuilder(
                  future: ref.watch(currentClubAccountInfoProvider.notifier).getCurrentClubAccountInfo(),
                  builder: (context, currentClubAccountSnapshot) {
                    final bool isLoading = currentClubAccountSnapshot.connectionState == ConnectionState.waiting;

                    final currentClubAccount =
                        isLoading ? _generateFakeCurrentClubAccount() : currentClubAccountSnapshot.data;

                    if (!isLoading && currentClubAccount == null) {
                      return Padding(
                        padding: const EdgeInsets.all(defaultPaddingM),
                        child: Center(
                          child: Text(
                            '동아리 계좌 정보를 불러오지 못 했어요',
                            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                          ),
                        ),
                      );
                    }

                    return CustomLoadingSkeleton(
                      isLoading: isLoading,
                      child: ClubDuesAccountInfoBox(
                        currentClubAccount: currentClubAccount!,
                        duesInOutType: _duesInOutType ?? 'ALL',
                        onTypeSelect: _selectInOutType,
                      ),
                    );
                  },
                ),
                FutureBuilder(
                  future: ref.watch(duesProvider.notifier).getDuesList(null),
                  builder: (context, duesListSnapshot) {
                    final bool isLoading = duesListSnapshot.connectionState == ConnectionState.waiting;

                    List<Dues>? duesList;

                    if (isLoading) {
                      duesList = _generateFakeDues(10);
                    } else {
                      duesList = duesListSnapshot.data?.reversed.toList();

                      if (duesList != null && _duesInOutType != null && _duesInOutType != 'ALL') {
                        duesList =
                            duesList.where((dues) => dues.clubAccountHistoryInOutType == _duesInOutType).toList();
                      }
                    }

                    if (!isLoading && (duesList == null || duesList.isEmpty)) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Center(
                          child: Text(
                            '회비 사용 내역이 없어요',
                            style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                          ),
                        ),
                      );
                    }

                    return CustomLoadingSkeleton(
                      isLoading: isLoading,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                        itemCount: duesList!.length,
                        itemBuilder: (context, index) => ClubDuesListTile(dues: duesList![index]),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CurrentClubAccount _generateFakeCurrentClubAccount() {
    return CurrentClubAccount(
      clubAccountId: 1,
      clubAccountBankName: '국민은행',
      clubAccountNumber: '1234567890123456',
      clubAccountBalance: 1000000,
      clubAccountLastUpdateDate: DateTime.now(),
    );
  }

  List<Dues> _generateFakeDues(int count) {
    return List.generate(count, (index) {
      return Dues(
        clubAccountHistoryId: index,
        clubAccountHistoryTranDate: DateTime.now(),
        clubAccountHistoryInOutType: 'DEPOSIT',
        clubAccountHistoryBalanceAmount: 1000000,
        clubAccountHistoryTranAmount: 20000,
        clubAccountHistoryContent: '회비 납부',
      );
    });
  }

  void _selectInOutType(String? type) {
    setState(() {
      _duesInOutType = type;
    });

    ref.refresh(duesProvider.notifier).getDuesList(null);
  }
}
