import 'package:ecommerce_app/common/styles/spacing_styles.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
// import 'package:ecommerce_app/features/authentication/screens/login/login.dart';
// import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/constants/text_strings.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});


  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeigtht * 2,
          child: Column(
            children: [
              //Image
              Image(
                image: AssetImage(image),
                width: THelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Title and subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: TSizes.spaceBtwItems),

              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(TColors.primary),
                  ),
                  child: const Text(
                    TTexts.tContinue,
                    style: TextStyle(color: Colors.white),
                   ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
