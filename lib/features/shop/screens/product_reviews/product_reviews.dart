import 'package:ecommerce_app/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_app/common/widgets/products/rating/rating_bar_indicator.dart';
import 'package:ecommerce_app/features/shop/screens/product_details/widget/overall_rating_indicator.dart';
import 'package:ecommerce_app/features/shop/screens/product_reviews/user_review_card.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ProductReviews extends StatelessWidget {
  const ProductReviews({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      /// AppBar
      appBar: TAppBar(
        title: const Text('Reviews and Ratings'),
        showBackarrow: true,
        backgroundColor: dark ? TColors.black : TColors.white,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Ratings and reviews are verified and are from people who use the same type of device that you use'),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///overall product rating
              const OverallProductRating(),

              const RatingbarIndicator(rating: 3.5),

              Text('12,696', style: Theme.of(context).textTheme.bodySmall),
              const SizedBox(height: TSizes.spaceBtwSections),

              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(), 
            ],
          ),
        ),
      ),
    );
  }
}
