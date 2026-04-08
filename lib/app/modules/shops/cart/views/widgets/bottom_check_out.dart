import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../../../data/common/widgets/custom_button.dart';
import '../../../../../utils/themes/app_color.dart';
import '../../controllers/cart_controller.dart';

class BottomCheckOut extends StatelessWidget {
  const BottomCheckOut({
    super.key,
    required this.theme,
    required this.controller,
  });

  final ThemeData theme;
  final CartController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total', style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey)),
              Obx(() => Text(
                '৳${controller.totalPrice.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primary,
                ),
              )),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SizedBox(
              height: 52,
              child: CustomButton(
                label: "Go to Checkout",
                onPressed: () => controller.openCheckout(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
