import 'package:ecommerce_app/common/widgets.login_signup/form_divider.dart';
import 'package:ecommerce_app/common/widgets.login_signup/social_buttons.dart';
import 'package:ecommerce_app/features/authentication/screens/signup.widgets/signup_form.dart';
// import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/constants/text_strings.dart';
// import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //title
              Text(TTexts.signupTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: TSizes.spaceBtwSections),

              //form
              const TSignUpForm(),

              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

