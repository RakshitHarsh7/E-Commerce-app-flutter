import 'package:ecommerce_app/common/widgets/Texts/section_heading.dart';
import 'package:ecommerce_app/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_app/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_app/common/widgets/products/product_cards/product_card_horizointal.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Sports'),
        showBackarrow: true,
        backgroundColor: dark ? TColors.black : TColors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            /// Banner
            const TRoundedImage(
                imageUrl: TImages.banner3,
                width: double.infinity,
                applyImageRadius: true),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Sub - categories
            Column(
              children: [
                /// Heading
                TSectionHeading(title: 'Sports shirts', onPressed: () {}),
                const SizedBox(height: TSizes.spaceBtwItems / 2),

                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: TSizes.spaceBtwItems),
                    itemBuilder: (context, index) =>
                        const ProductCardHorizontal(),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
