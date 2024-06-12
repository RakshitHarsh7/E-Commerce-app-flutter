import 'package:ecommerce_app/common/widgets/Cards/brand_card.dart';
import 'package:ecommerce_app/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_app/common/widgets/products/sortable/sortable_products.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        title: const Text('Nike'),
        showBackarrow: true,
        backgroundColor: dark ? TColors.black : TColors.white,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Brand detail
              BrandCard(showBorder: true),
              SizedBox(height: TSizes.spaceBtwSections),

              SortableProducts(),
            ],
          ),
        ),
      ),
    );
  }
}
