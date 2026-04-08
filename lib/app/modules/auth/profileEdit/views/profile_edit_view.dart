import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_loading.dart';
import 'package:deshi_mart_ecom_app/app/utils/themes/app_color.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../data/common/widgets/custom_button.dart';
import '../../../../data/common/widgets/custom_text_field.dart';
import '../../../../utils/api_url/api_url.dart';
import '../controllers/profile_edit_controller.dart';

class ProfileEditView extends GetView<ProfileEditController> {
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Center(
                child: ProfilePick(controller: controller),
              ),

              const SizedBox(height: 20),

              CustomField(
                controller: controller.fullNameController,
                label: 'Full Name',
                hintText: 'Abdul Rahman',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),

              CustomField(
                controller: controller.emailController,
                label: 'Email',
                hintText: 'example@gmail.com',
                keyboardType: TextInputType.emailAddress,
                readOnly: true,

              ),
              const SizedBox(height: 15),

              CustomField(
                controller: controller.phoneController,
                label: 'Phone',
                hintText: '017xxxxxxxx',
                keyboardType: TextInputType.phone,
              ),


              const SizedBox(height: 30),

              Obx(() {
                return CustomButton(
                  label: "Edit Profile",
                  onPressed: () {
                    controller.updateProfile();
                  },
                  isLoading: controller.isLoading.value,
                );
              }),


            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePick extends StatelessWidget {
  const ProfilePick({
    super.key,
    required this.controller,
  });

  final ProfileEditController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            )
          ),
          child: Obx(() {

            final file = controller.pickedImage.value;
            final profileImage = "${ApiUrl.imgBase}${controller.userData.profileImage}";

            if(file != null){
              return ClipOval(
                child: Image.file(
                  file,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                ),
              );
            }

            if(controller.userData.profileImage != null){
              return ClipOval(
                child: Image.network(
                  profileImage,
                  fit: BoxFit.cover,
                  width: 100,
                  height: 100,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CustomLoading(size: 20, color: AppColor.primary

                      ),);
                  }

                ),
              );
            }
            return  Icon(
              Icons.person,
              size: 50,
              color: Colors.white,
            );
          }

          ),
        ),

        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {

              controller.pickImage();
            },
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                size: 20,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
