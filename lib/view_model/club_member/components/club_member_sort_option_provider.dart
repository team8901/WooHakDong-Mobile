import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'club_member_sort_option.dart';

final clubMemberSortOptionProvider = StateProvider<ClubMemberSortOption>((ref) => ClubMemberSortOption.oldest);
