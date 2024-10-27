import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class ClubItemSearchPage extends StatefulWidget {
  const ClubItemSearchPage({super.key});

  @override
  State<ClubItemSearchPage> createState() => _ClubItemSearchPageState();
}

class _ClubItemSearchPageState extends State<ClubItemSearchPage> {
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
            hintText: '물품 검색',
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
