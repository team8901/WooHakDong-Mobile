import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../view_model/item/item_provider.dart';
import '../themes/custom_widget/custom_circular_progress_indicator.dart';
import '../themes/custom_widget/custom_divider.dart';
import '../themes/spacing.dart';

class ClubItemHistoryPage extends ConsumerWidget {
  final int itemId;

  const ClubItemHistoryPage({
    super.key,
    required this.itemId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('대여 내역'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: FutureBuilder(
            future: ref.watch(itemProvider.notifier).getItemHistoryList(itemId),
            builder: (context, itemListSnapshot) {
              if (itemListSnapshot.connectionState == ConnectionState.waiting) {
                return const CustomCircularProgressIndicator();
              } else {
                final itemHistoryList = itemListSnapshot.data;

                if (itemHistoryList!.isEmpty) {
                  return Center(
                    child: Text(
                      '아직 대여한 내역이 없어요',
                      style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                    ),
                  );
                }

                return CustomMaterialIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(milliseconds: 750));
                    ref.refresh(itemProvider);
                  },
                  child: ListView.separated(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => const CustomDivider(),
                    itemCount: itemHistoryList.length,
                    itemBuilder: (context, index) {
                      final reversedItemHistoryList = itemHistoryList[itemHistoryList.length - 1 - index];

                      final CachedNetworkImageProvider itemReturnImageProvider =
                          CachedNetworkImageProvider(reversedItemHistoryList.itemReturnImage!);

                      return Padding(
                        padding: const EdgeInsets.all(defaultPaddingM),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 72.r,
                              height: 72.r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(defaultBorderRadiusM),
                                image: DecorationImage(
                                  image: itemReturnImageProvider,
                                  fit: BoxFit.cover,
                                ),
                                border: Border.all(
                                  color: context.colorScheme.surfaceContainer,
                                  width: 1,
                                ),
                              ),
                            ),
                            const Gap(defaultGapM),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reversedItemHistoryList.memberName!,
                                    style: context.textTheme.bodyLarge,
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Gap(defaultGapS / 2),
                                  Row(
                                    children: [
                                      Icon(
                                        Symbols.output_rounded,
                                        size: 20,
                                        color: context.colorScheme.onSurface,
                                      ),
                                      const Gap(defaultGapS / 4),
                                      Text(
                                        _formatRentalDate(reversedItemHistoryList.itemRentalDate),
                                        style: context.textTheme.bodySmall?.copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Gap(defaultGapS / 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Symbols.input_rounded,
                                        size: 20,
                                        color: context.colorScheme.onSurface,
                                      ),
                                      const Gap(defaultGapS / 4),
                                      Text(
                                        (reversedItemHistoryList.itemReturnDate == null)
                                            ? '아직 반납하지 않았어요'
                                            : _formatRentalDate(reversedItemHistoryList.itemReturnDate),
                                        style: context.textTheme.bodySmall?.copyWith(
                                          color: context.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  String _formatRentalDate(DateTime? itemRentalDate) {
    String dateString = itemRentalDate.toString();

    DateTime dateTime = DateTime.parse(dateString).toLocal();

    int currentYear = DateTime.now().year;
    bool isCurrentYear = dateTime.year == currentYear;

    String dateFormat = isCurrentYear ? 'M월 d일, H:mm a' : 'yyyy년 M월 d일, H:mm a';

    return DateFormat(dateFormat).format(dateTime);
  }
}
