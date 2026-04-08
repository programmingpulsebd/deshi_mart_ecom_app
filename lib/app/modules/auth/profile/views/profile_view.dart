import 'package:deshi_mart_ecom_app/app/data/helper/contact_helper.dart';
import 'package:deshi_mart_ecom_app/app/modules/auth/profile/views/shimmer/profile.dart';
import 'package:deshi_mart_ecom_app/app/modules/auth/profile/views/widgets/menu_card.dart';
import 'package:deshi_mart_ecom_app/app/modules/auth/profile/views/widgets/profile_tyle.dart';
import 'package:deshi_mart_ecom_app/app/modules/auth/profile/views/widgets/section_level.dart';
import 'package:deshi_mart_ecom_app/app/utils/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../data/common/widgets/custom_dialog.dart';
import '../../../../data/common/widgets/custom_loading.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/api_url/api_url.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: () => controller.loadUserData(),
            child: SingleChildScrollView(
              child: Obx(() {
                if (controller.isLoading.value ||
                    controller.isLoggedIn.value == null) {
                  return ProfileShimmer(theme);
                }

                if (!controller.isLoggedIn.value!) {
                  return _guestUI(theme, controller);
                }

                return _loggedInUI(theme, controller);
              }),
            ),
          ),
        ),
      ),
    );
  }

}

Widget _guestUI(ThemeData theme, ProfileController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.primary, width: 2),
            ),
            child: const Icon(Icons.person, size: 44, color: AppColor.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome, Guest!",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Login to access your profile",
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 36,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed(Routes.LOGIN),
                    icon: const Icon(
                      Iconsax.login,
                      size: 16,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),

      SectionLabel(label: "General"),
      const SizedBox(height: 8),
      MenuCard(
        children: [
          ProfileTile(
            icon: Iconsax.moon,
            title: "Themes",
            onTap: () {
              Get.toNamed(Routes.THEME);
            },
          ),
          ProfileTile(icon: Iconsax.star, title: "Rate the App", onTap: () {
ContactHelper.rateApp();
          }),
          ProfileTile(icon: Iconsax.share, title: "Share App", onTap: () {
            ContactHelper.shareApp();

          }),
          ProfileTile(
            icon: Iconsax.shield_tick,
            title: "Privacy Policy",
            onTap: () {
              ContactHelper.openPrivacyPolicy();
            },
          ),
          ProfileTile(
            icon: Iconsax.document_text,
            title: "Terms & Conditions",
            onTap: () {
              Get.toNamed(Routes.TERMS_CONDITION);
            },
          ),
          ProfileTile(
            icon: Iconsax.message_question,
            title: "Help & Support",
            onTap: () {
              Get.toNamed(Routes.HELP_SUPPORT);
            },
          ),
          ProfileTile(
            icon: Iconsax.info_circle,
            title: "About",
            onTap: () {
              Get.toNamed(Routes.ABOUT);
            },
            showDivider: false,
          ),
        ],
      ),
    ],
  );
}

Widget _loggedInUI(ThemeData theme, ProfileController controller) {


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Stack(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColor.primary.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColor.primary, width: 2),
                ),
                child: ClipOval(
                  child: controller.userData.value.profileImage == null
                      ? const Icon(Icons.person, size: 50, color: Colors.grey)
                      : Image.network(
                          "${ApiUrl.imgBase}${controller.userData.value.profileImage}",

                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(
                              child: CustomLoading(
                                size: 20,
                                color: AppColor.primary,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.person,
                                size: 50,
                                color: Colors.grey,
                              ),
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: InkWell(
                    onTap: () => Get.toNamed(
                      Routes.PROFILE_EDIT,
                      arguments: controller.userData.value,
                    ),
                    child: const Icon(
                      Iconsax.edit_2,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.userData.value.fullName ?? "Guest",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Iconsax.sms, size: 13, color: Colors.grey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        controller.userData.value.email ?? "Guest",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      const SizedBox(height: 10),

      if (controller.isLoggedIn.value == true) ...[
        const SizedBox(height: 20),
        SectionLabel(label: "Account"),
        const SizedBox(height: 8),
        MenuCard(
          children: [
            ProfileTile(
              icon: Iconsax.box,
              title: "My Orders",
              onTap: () {
                Get.toNamed(Routes.ORDER_TRACK);
              },
            ),
            ProfileTile(
              icon: Iconsax.location,
              title: "Delivery Address",
              onTap: () {
                Get.toNamed(Routes.DELIVERY_ADDRESS, arguments: controller.userData.value);},
            ),
            ProfileTile(
              icon: Iconsax.password_check,
              title: "Change Password",
              onTap: () {
                Get.toNamed(Routes.CHANGE_PASSWORD);
              },
              showDivider: false,
            ),
          ],
        ),

        SizedBox(height: 20),
        SectionLabel(label: "General"),
        const SizedBox(height: 8),
        MenuCard(
          children: [
            ProfileTile(
              icon: Iconsax.moon,
              title: "Themes",
              onTap: () {
                Get.toNamed(Routes.THEME);
              },
            ),
            ProfileTile(icon: Iconsax.star, title: "Rate the App", onTap: () {
              ContactHelper.rateApp();
            }),
            ProfileTile(icon: Iconsax.share, title: "Share App", onTap: () {
              ContactHelper.shareApp();

            }),
            ProfileTile(
              icon: Iconsax.shield_tick,
              title: "Privacy Policy",
              onTap: () {
                ContactHelper.openPrivacyPolicy();
              },
            ),
            ProfileTile(
              icon: Iconsax.document_text,
              title: "Terms & Conditions",
              onTap: () {
                Get.toNamed(Routes.TERMS_CONDITION);
              },
            ),
            ProfileTile(
              icon: Iconsax.message_question,
              title: "Help & Support",
              onTap: () {
                Get.toNamed(Routes.HELP_SUPPORT);
              },
            ),
            ProfileTile(
              icon: Iconsax.info_circle,
              title: "About",
              onTap: () {
                Get.toNamed(Routes.ABOUT);
              },
              showDivider: false,
            ),
          ],
        ),

        const SizedBox(height: 20),

        SectionLabel(label: "Danger Zone"),
        const SizedBox(height: 8),
        MenuCard(
          children: [
            ProfileTile(
              icon: Iconsax.profile_delete,
              title: "Delete Account",
              iconColor: Colors.red,
              titleColor: Colors.red,
              onTap: () {
                DialogUtils.showConfirmDialog(
                  title: "Delete Account",
                  message: "Are you sure you want to delete your account? This action cannot be undone!",
                  icon: Icons.delete_forever,
                  iconColor: Colors.red,
                  cancelText: "Cancel",
                  confirmText: "Delete",
                  onConfirm: () {
                    controller.deleteAccount();
                  },
                );
              },
            ),


            ProfileTile(
              icon: Iconsax.logout,
              title: "Logout",
              iconColor: Colors.red,
              titleColor: Colors.red,

              showDivider: false,

              onTap: () {
                DialogUtils.showConfirmDialog(
                  title: 'Logout',
                  message: 'Are you sure you want to logout?',
                  icon: Icons.logout,
                  iconColor: Colors.red,
                  cancelText: 'Cancel',
                  confirmText: 'Logout',
                  onConfirm: () {
                    controller.logout();
                  },
                );
              },

            ),


          ],
        ),
      ],

      const SizedBox(height: 40),
    ],
  );


}
