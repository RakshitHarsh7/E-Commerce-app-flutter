import 'package:ecommerce_app/common/widgets/Texts/section_heading.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widget/bottom_add_to_cart.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widget/product_attributes.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widget/product_details_image_slider.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widget/product_meta_data.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widget/rating_and_share.dart';
import 'package:ecommerce_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: const BottomAddCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///1- Product Image Slider
            const ProductImageSlider(),

            ///2 - Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating and Share button
                  const RatingAndShare(),

                  ///Price, Title, Stock and brand
                  const ProductMetaData(),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  /// Attributes
                  const ProductAttribute(),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// --Checkout Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text('Checkout')),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  ///-- Description
                  const TSectionHeading(
                      title: 'Description', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  const ReadMoreText(
                    'This is a product description of blue Nike shoes. There are more things that can be added but im out of words.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),

                  /// Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(
                          title: 'Reviews(199)', showActionButton: false),
                      IconButton(
                        onPressed: () => Get.to(() => const ProductReviews()),
                        icon: const Icon(Iconsax.arrow_right_3, size: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
