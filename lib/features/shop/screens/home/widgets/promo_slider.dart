import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce_app/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:ecommerce_app/common/widgets/images/t_rounded_image.dart';
import 'package:ecommerce_app/features/shop/controllers/home_controller.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class TPromoSlider extends StatelessWidget {
  const TPromoSlider({
    super.key, required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
          ),
          items: banners.map((url) => TRoundedImage(imageUrl: url)).toList(),
        ),

        // ---Carousal Slider---
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < banners.length; i++)
                  TCircularContainer(
                    width: 20,
                    height: 4,
                    backgroundcolor: controller.carousalCurrentIndex.value == i
                        ? TColors.primary
                        : TColors.grey,
                    margin: const EdgeInsets.only(right: 10),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
