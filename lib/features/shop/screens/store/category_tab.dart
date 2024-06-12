import 'package:ecommerce_app/common/widgets/Cards/brands_showcase.dart';
import 'package:ecommerce_app/common/widgets/Texts/section_heading.dart';
import 'package:ecommerce_app/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce_app/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // --Brands
              const BrandShowCase(
                images: [
                  TImages.productImage3,
                  TImages.productImage2,
                  TImages.productImage1,
                ],
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              /// ---Products
              TSectionHeading(
                title: 'You might like',
                showActionButton: true,
                onPressed: () {},
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              GridLayout(
                  itemcount: 4,
                  itemBuilder: (_, index) => const TProductCardVertical()),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
