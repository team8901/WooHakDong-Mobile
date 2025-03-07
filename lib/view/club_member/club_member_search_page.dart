import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/club_member/club_member_provider.dart';
import '../../view_model/club_member/club_member_search_provider.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/custom_widget/interaction/custom_progress_indicator.dart';
import 'club_member_detail_page.dart';
import 'components/list_tile/club_member_search_list_tile.dart';

class ClubMemberSearchPage extends ConsumerStatefulWidget {
  const ClubMemberSearchPage({super.key});

  @override
  ConsumerState<ClubMemberSearchPage> createState() => _ClubMemberSearchPageState();
}

class _ClubMemberSearchPageState extends ConsumerState<ClubMemberSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

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
    final clubMemberSearchedResults = ref.watch(clubMemberSearchProvider(_searchController.text));

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 40.h,
          child: SearchBar(
            hintText: '회원 이름 검색',
            textInputAction: TextInputAction.search,
            keyboardType: TextInputType.text,
            controller: _searchController,
            onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
            autoFocus: true,
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
      ),
      body: _searchController.text.isEmpty
          ? const SizedBox()
          : clubMemberSearchedResults.when(
              data: (searchedClubMember) {
                if (searchedClubMember.isEmpty) {
                  return Center(
                    child: Text(
                      '회원 검색 결과가 없어요',
                      style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                    ),
                  );
                }

                searchedClubMember.sort((a, b) => a.memberName!.compareTo(b.memberName!));

                return ListView.separated(
                  physics: const AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (context, index) => const CustomHorizontalDivider(),
                  itemCount: searchedClubMember.length,
                  itemBuilder: (context, index) => ClubMemberSearchListTile(
                    searchedClubMember: searchedClubMember[index],
                    onTap: () => _pushMemberDetailPage(ref, context, searchedClubMember[index].clubMemberId!),
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
    );
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {
      setState(() {});
    });
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
}
