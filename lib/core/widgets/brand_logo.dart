import 'package:consumer/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.tertiary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          stops: [0.4, 0.9, 1.0],
        ).createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: SvgPicture.asset(
        AppAssets.brandLogo,
        width: width ?? MediaQuery.of(context).size.width * 0.35,
        height: height ?? MediaQuery.of(context).size.width * 0.35,
        fit: BoxFit.contain,
      ),
    );
  }
}
