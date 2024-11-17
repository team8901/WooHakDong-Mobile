import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:woohakdong/oss_licenses.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

import '../themes/spacing.dart';

class OssLicenseInfoDetailPage extends StatelessWidget {
  final Package package;

  const OssLicenseInfoDetailPage({
    super.key,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${package.name} ${package.version}'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(defaultPaddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (package.description.isNotEmpty)
                Text(
                  package.description,
                  style: context.textTheme.headlineSmall,
                ),
              const Gap(defaultGapXL),
              if (package.license != null)
                Text(
                  package.license!,
                  style: context.textTheme.bodyLarge,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
