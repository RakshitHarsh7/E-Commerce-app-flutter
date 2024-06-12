import 'package:ecommerce_app/common/widgets/Texts/product_price_text.dart';
import 'package:ecommerce_app/common/widgets/Texts/product_title_text.dart';
import 'package:ecommerce_app/common/widgets/Texts/section_heading.dart';
import 'package:ecommerce_app/common/widgets/chip/chipchoice.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductAttribute extends StatelessWidget {
  const ProductAttribute({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// --- Selected Attribute pricing and description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Column(
            children: [
              //// Titlte, Price and  stock status
              Row(
                children: [
                  const TSectionHeading(
                      title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ProductTitleText(
                              text: 'Price : ', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          const ProductPriceText(price: '20'),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const ProductTitleText(
                              text: 'Stock : ', smallSize: true),
                          Text('In stock',
                              style: Theme.of(context).textTheme.titleMedium)
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const ProductTitleText(
                text:
                    'The is the description of the productna and it can go up to max 4 lines',
                smallSize: true,
                maxLines: 4,
              ),
            ],
          ),
        ),

        const SizedBox(height: TSizes.spaceBtwItems),

        /// -- Attribbutes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Colors',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                Choicechip(
                    text: 'Green', selected: true, onSeleted: (value) {}),
                Choicechip(
                  text: 'Blue',
                  selected: false,
                  onSeleted: (value) {},
                ),
                Choicechip(
                  text: 'Yellow',
                  selected: false,
                  onSeleted: (value) {},
                ),
              ],
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(
              title: 'Size',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                Choicechip(
                    text: 'EU 34', selected: true, onSeleted: (value) {}),
                Choicechip(
                    text: 'EU 36', selected: false, onSeleted: (value) {}),
                Choicechip(
                    text: 'EU 38', selected: false, onSeleted: (value) {}),
              ],
            )
          ],
        ),
      ],
    );
  }
}
