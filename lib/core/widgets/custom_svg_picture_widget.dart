import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPictureWidget extends StatelessWidget {
  const CustomSvgPictureWidget({
    this.height,
    this.width, 
    super.key,
    required this.assetName,
    this.isWithColorFilter = true,
  });

  const CustomSvgPictureWidget.withOutColorFilter({
    required this.assetName,
    this.height,
    this.width,
    super.key,
  }) : isWithColorFilter = false;

  final String assetName;
  final bool isWithColorFilter;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: height,
      width: width,
      colorFilter: isWithColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
    );
  }
}
