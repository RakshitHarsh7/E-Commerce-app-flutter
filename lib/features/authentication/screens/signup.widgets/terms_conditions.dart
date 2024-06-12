import 'package:ecommerce_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/constants/text_strings.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TTermsandConditionsCheckBox extends StatelessWidget {
  const TTermsandConditionsCheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Obx(() => Checkbox(
              value: controller.privacypolicy.value,
              onChanged: (value) => controller.privacypolicy.value =
                  !controller.privacypolicy.value)),
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '${TTexts.iAgreeTo} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: '${TTexts.privacyPolicy} ',
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
                TextSpan(
                    text: '${TTexts.and} ',
                    style: Theme.of(context).textTheme.bodySmall),
                TextSpan(
                  text: TTexts.termsOfUse,
                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                        color: dark ? TColors.white : TColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
