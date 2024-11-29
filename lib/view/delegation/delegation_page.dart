import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/service/general/general_functions.dart';
import 'package:woohakdong/view/themes/spacing.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/delegation/delegate_club_member_search_provider.dart';
import '../../view_model/delegation/delegation_provider.dart';
import '../themes/custom_widget/button/custom_bottom_button.dart';
import '../themes/custom_widget/dialog/custom_interaction_dialog.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_progress_indicator.dart';
import 'components/delegate_club_member_search_list_tile.dart';

class DelegationPage extends ConsumerStatefulWidget {
  const DelegationPage({super.key});

  @override
  ConsumerState createState() => _DelegationPageState();
}

class _DelegationPageState extends ConsumerState<DelegationPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  int? _selectedClubMemberId;
  String? _selectedClubMemberName;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delegateClubMemberSearchedList = ref.watch(delegateClubMemberSearchProvider(_searchController.text));

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
              child: Text(
                '새로운 회장님을 선택해 주세요',
                style: context.textTheme.headlineSmall,
              ),
            ),
            const Gap(defaultGapXL * 2),
            Container(
              height: 40.h,
              margin: const EdgeInsets.symmetric(horizontal: defaultPaddingM),
              child: SearchBar(
                hintText: '회원 이름 검색',
                textInputAction: TextInputAction.search,
                keyboardType: TextInputType.text,
                controller: _searchController,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                trailing: [
                  if (_searchController.text.isEmpty)
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Symbols.search_rounded),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    )
                  else
                    IconButton(
                      onPressed: () => _searchController.clear(),
                      icon: const Icon(Symbols.close_rounded),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      visualDensity: VisualDensity.compact,
                    ),
                ],
              ),
            ),
            Expanded(
              child: delegateClubMemberSearchedList.when(
                data: (searchedClubMemberData) {
                  searchedClubMemberData =
                      searchedClubMemberData.where((member) => member.clubMemberRole != 'PRESIDENT').toList();

                  searchedClubMemberData.sort((a, b) => a.memberName!.compareTo(b.memberName!));

                  if (searchedClubMemberData.isEmpty) {
                    return Center(
                      child: Text(
                        '회원 검색 결과가 없어요',
                        style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                      ),
                    );
                  }

                  return ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                    itemCount: searchedClubMemberData.length,
                    itemBuilder: (context, index) => DelegateClubMemberSearchListTile(
                      searchedClubMember: searchedClubMemberData[index],
                      selectedClubMemberId: _selectedClubMemberId,
                      onChanged: (value) {
                        setState(
                          () {
                            _selectedClubMemberId = value;
                            _selectedClubMemberName = searchedClubMemberData[index].memberName;
                          },
                        );
                      },
                    ),
                  );
                },
                loading: () => CustomProgressIndicator(indicatorColor: context.colorScheme.surfaceContainer),
                error: (err, stack) => Center(
                  child: Text(
                    '검색 중 오류가 발생했어요\n다시 시도해 주세요',
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
      bottomNavigationBar: SafeArea(
        child: CustomBottomButton(
          onTap: () async {
            if (_selectedClubMemberId == null) {
              await GeneralFunctions.toastMessage('회장을 위임할 회원을 선택해 주세요');
              return;
            }

            try {
              final bool? isDelegate = await showDialog<bool>(
                context: context,
                builder: (context) => CustomInteractionDialog(
                  dialogTitle: '회장 위임',
                  dialogContent: '$_selectedClubMemberName님으로 회장이 위임돼요.',
                  dialogButtonText: '확인',
                  dialogButtonColor: context.colorScheme.primary,
                ),
              );

              if (isDelegate == true) {
                await ref.read(delegationProvider.notifier).delegateClubPresident(_selectedClubMemberId!);

                if (context.mounted) {
                  Navigator.of(context).pop();
                  await Phoenix.rebirth(context);
                }
              }
            } catch (e) {
              await GeneralFunctions.toastMessage('오류가 발생했어요\n다시 시도해 주세요');
            }
          },
          buttonText: '위임하기',
          buttonColor: Theme.of(context).colorScheme.primary,
          buttonTextColor: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {
      setState(() {});
    });
  }
}
