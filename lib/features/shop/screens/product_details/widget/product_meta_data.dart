import 'package:ecommerce_app/common/widgets/Texts/brand_title_with_verified_icon.dart';
import 'package:ecommerce_app/common/widgets/Texts/product_price_text.dart';
import 'package:ecommerce_app/common/widgets/Texts/product_title_text.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/common/widgets/images/circular_image.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/enums.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price and Sale Price
        Row(
          children: [
            /// Sale Tag
            TRoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.sm),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),

            ///Price
            Text(
              '\$250',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            const ProductPriceText(price: '175', isLarge: true),

            const SizedBox(height: TSizes.spaceBtwItems / 2),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        const ProductTitleText(text: 'Green Nike Sports Shoe'),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock status
        Row(
          children: [
            const ProductTitleText(text: 'Status'),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text('In Stock', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Brand
        Row(
          children: [
            CircularImage(
              image: TImages.shoeIcon ,
              width: 32,
              height: 32,
              overlayColor: darkMode ? TColors.white : TColors.black,
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 1.5),
            const BrandTitleWithVerifiedIcon(
                title: 'Nike', brandTextSizes: TextSizes.medium),
          ],
        ),
      ],
    );
  }
}
