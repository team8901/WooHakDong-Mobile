import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../../oss_licenses.dart';
import '../themes/custom_widget/etc/custom_horizontal_divider.dart';
import '../themes/spacing.dart';
import 'oss_license_info_detail_page.dart';

class OssLicenseListPage extends StatelessWidget {
  const OssLicenseListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('오픈소스 라이선스'),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Package>>(
          future: loadLicenses(),
          builder: (context, snapshot) {
            return ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              separatorBuilder: (context, index) => const CustomHorizontalDivider(),
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                final package = snapshot.data![index];
                return InkWell(
                  onTap: () => _pushOssLicenseInfoDetailPage(context, package),
                  highlightColor: context.colorScheme.surfaceContainer,
                  child: Ink(
                    padding: const EdgeInsets.all(defaultPaddingM),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${package.name} ${package.version}',
                                style: context.textTheme.bodyLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(defaultGapS / 4),
                              if (package.description.isNotEmpty)
                                Text(
                                  package.description,
                                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurface),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                        const Gap(defaultGapM),
                        Icon(
                          Symbols.chevron_right_rounded,
                          color: context.colorScheme.outline,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  static Future<List<Package>> loadLicenses() async {
    final ossKeys = allDependencies.toList();
    return ossKeys..sort((a, b) => a.name.compareTo(b.name));
  }

  void _pushOssLicenseInfoDetailPage(BuildContext context, Package package) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OssLicenseInfoDetailPage(package: package),
      ),
    );
  }
}
