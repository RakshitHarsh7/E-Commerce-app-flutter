import 'package:ecommerce_app/common/widgets/Texts/section_heading.dart';
import 'package:ecommerce_app/common/widgets/appbar/appbar.dart';
import 'package:ecommerce_app/common/widgets/images/circular_image.dart';
import 'package:ecommerce_app/features/personalisation/controllers/user_controller.dart';
import 'package:ecommerce_app/features/personalisation/screens/profile/widgets/change_name.dart';
import 'package:ecommerce_app/features/personalisation/screens/profile/widgets/profile_menu.dart';
import 'package:ecommerce_app/utils/Shimmer/shimmer.dart';
import 'package:ecommerce_app/utils/constants/colors.dart';
import 'package:ecommerce_app/utils/constants/image_strings.dart';
import 'package:ecommerce_app/utils/constants/sizes.dart';
import 'package:ecommerce_app/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: TAppBar(
        showBackarrow: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        backgroundColor: dark ? TColors.black : TColors.white,
        actions: const [],
      ),

      /// Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : TImages.user;
                        return controller.imageUploading.value
                            ? const ShimmerEffect(
                                width: 80, height: 80, radius: 80)
                            : CircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty);
                      },
                    ),
                    TextButton(
                        onPressed: () => controller.uploadProfilePicture(),
                        child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              //Details
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Personal Info
              ProfileMenu(
                title: 'Name',
                value: controller.user.value.fullName,
                onPressed: () => Get.to(() => const ChangeName()),
              ),
              ProfileMenu(
                title: 'Username',
                value: controller.user.value.userName,
                onPressed: () {},
              ),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              const TSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),

              ProfileMenu(
                title: 'User ID',
                value: controller.user.value.id,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'E-mail',
                value: controller.user.value.email,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Phone Number',
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'Male',
                onPressed: () {},
              ),
              ProfileMenu(
                title: 'Date of Birth',
                value: '6 Aug, 2002',
                onPressed: () {},
              ),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: Colors.red),
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
