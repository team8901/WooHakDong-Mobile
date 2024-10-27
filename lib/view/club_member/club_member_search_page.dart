import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ClubMemberSearchPage extends StatefulWidget {
  const ClubMemberSearchPage({super.key});

  @override
  State<ClubMemberSearchPage> createState() => _ClubMemberSearchPageState();
}

class _ClubMemberSearchPageState extends State<ClubMemberSearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SizedBox(
            height: 46,
            child: SearchBar(
              hintText: '회원 검색',
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
                    onPressed: () {
                      _searchController.clear();
                    },
                    icon: const Icon(Symbols.close_rounded),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
          )
      ),
    );
  }
}
