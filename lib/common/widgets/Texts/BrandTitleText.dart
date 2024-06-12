import 'package:ecommerce_app/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class BrandTitleText extends StatelessWidget {
  const BrandTitleText(
      {super.key,
      this.color,
      required this.title,
      required this.maxLines,
      this.textAlign,
      required this.brandTextsize});

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes brandTextsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: brandTextsize == TextSizes.small
          ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
          : brandTextsize == TextSizes.medium
              ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
              : brandTextsize == TextSizes.large
                  ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
                  : Theme.of(context).textTheme.bodyMedium !.apply(color: color),
    );
  }
}
