import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomLoadingSkeleton extends StatelessWidget {
  final bool isLoading;
  final bool ignoreContainers;
  final Widget child;

  const CustomLoadingSkeleton({
    super.key,
    required this.isLoading,
    this.ignoreContainers = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: false,
      ignoreContainers: ignoreContainers,
      effect: ShimmerEffect(
        baseColor: context.colorScheme.surfaceContainer.withOpacity(0.6),
        highlightColor: context.colorScheme.surfaceContainer.withOpacity(0.3),
        duration: const Duration(milliseconds: 1000),
      ),
      child: child,
    );
  }
}
