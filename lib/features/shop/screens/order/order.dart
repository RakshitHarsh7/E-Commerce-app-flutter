import 'package:ecommerce_app/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_app/features/shop/screens/order/widgets/orders_list.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      /// Appbar
      appBar: TAppBar(
        title:
            Text('My Orders', style: Theme.of(context).textTheme.headlineSmall),
        showBackarrow: true,
        backgroundColor: dark ? TColors.black : TColors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// Orders
        child: OrderListItems(),
      ),
    );
  }
}
