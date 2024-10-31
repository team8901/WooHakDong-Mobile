import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:woohakdong/view/themes/theme_context.dart';

class CustomLoadingSkeleton extends StatelessWidget {
  final bool isLoading;
  final Widget child;

  const CustomLoadingSkeleton({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      enableSwitchAnimation: true,
      ignoreContainers: true,
      effect: ShimmerEffect(
        baseColor: context.colorScheme.surfaceContainer.withOpacity(0.6),
        highlightColor: context.colorScheme.surfaceContainer.withOpacity(0.3),
        duration: const Duration(milliseconds: 1000),
      ),
      child: child,
    );
  }
}
