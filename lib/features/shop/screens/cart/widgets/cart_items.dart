import 'package:ecommerce_app/common/widgets/Texts/product_price_text.dart';
import 'package:ecommerce_app/common/widgets/products/cart/add_remove_button.dart';
import 'package:ecommerce_app/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    this.showAddRemoveButton = true,
  });

  final bool showAddRemoveButton;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) =>
          const SizedBox(height: TSizes.spaceBtwSections),
      itemCount: 2,
      itemBuilder: (_, index) => Column(
        children: [
          CartItem(dark: dark),
          if (showAddRemoveButton) const SizedBox(height: TSizes.spaceBtwItems),
          if (showAddRemoveButton)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  const SizedBox(width: 70),

                  /// Add remove button
                  ProductQuantityAddRemoveButton(dark: dark),
                ]),
                const ProductPriceText(price: '256'),
              ],
            )
        ],
      ),
    );
  }
}
