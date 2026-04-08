import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_text_field.dart';
import '../controllers/delivery_address_controller.dart';

class DeliveryAddressView extends GetView<DeliveryAddressController> {
  const DeliveryAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delivery Address'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomField(
              controller: controller.customerController,
              label: 'Customer Name',
              hintText: 'Abdul Rahman',
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CustomField(
                    controller: controller.phoneController,
                    label: 'Phone Number',
                    hintText: '+8801711111111',
                    keyboardType: TextInputType.phone,
                  ),
                ),

                const SizedBox(width: 15),

                Expanded(
                  child: CustomField(
                    controller: controller.postalCodeController,
                    label: 'Postal Code',
                    hintText: '0000',
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            CustomField(
              controller: controller.upazilaController,
              label: 'Upazila',
              hintText: 'Raipur Sada',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 15),

            CustomField(
              controller: controller.districtController,
              label: 'District',
              hintText: 'Raipur',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 15),

            CustomField(
              controller: controller.fullAddressController,
              maxLines: 4,
              label: 'Full Address',
              hintText: 'House 15, Central Road',
              keyboardType: TextInputType.multiline,
            ),
            const SizedBox(height: 15),

            Obx(() {
              return CustomButton(
                isLoading: controller.isLoading.value,
                label: 'Save Address',
                onPressed: () {
                  controller.saveDeliveryAddress();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
