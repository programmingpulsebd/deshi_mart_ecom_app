import 'package:deshi_mart_ecom_app/app/data/common/widgets/custom_loading.dart';
import 'package:deshi_mart_ecom_app/app/utils/themes/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_track_controller.dart';

class OrderTrackView extends GetView<OrderTrackController> {
  const OrderTrackView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> statusList = ['pending', 'processing', 'shipping', 'completed', 'cancelled'];
    final theme = Theme.of(context);

    return DefaultTabController(
      length: statusList.length,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: const Text('Order Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: theme.scaffoldBackgroundColor,
          foregroundColor: theme.textTheme.bodyLarge?.color,
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            dividerColor: Colors.transparent,
            indicatorColor: AppColor.primary,
            labelColor:AppColor.primary,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            onTap: (index) => controller.fetchOrdersByStatus(statusList[index]),
            tabs: statusList.map((status) => Tab(text: status.capitalizeFirst)).toList(),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CustomLoading(size: 40, color: AppColor.primary));
          }

          if (controller.errorMessage.value.isNotEmpty) {
            return Center(child: Text(controller.errorMessage.value, style: theme.textTheme.bodyMedium));
          }

          if (controller.orderList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_basket_outlined, size: 60, color: theme.dividerColor),
                  const SizedBox(height: 10),
                  Text('No orders found', style: theme.textTheme.bodyMedium?.copyWith(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.orderList.length,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            itemBuilder: (context, index) {
              final order = controller.orderList[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: theme.shadowColor.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () => controller.goToOrderDetails(order),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Order ID: #${order.id}",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Placed on: ${order.orderDate?.split('T')[0] ?? 'N/A'}",
                                  style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios, size: 16, color: theme.dividerColor),
                          ],
                        ),
                        Divider(color: theme.dividerColor, height: 25, thickness: 0.5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Status Chip
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(order.orderStatus).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(radius: 4, backgroundColor: _getStatusColor(order.orderStatus)),
                                  const SizedBox(width: 6),
                                  Text(
                                    order.orderStatus?.toUpperCase() ?? "",
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontSize: 11,
                                      color: _getStatusColor(order.orderStatus),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "TK ${order.totalAmount}",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: theme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipping':
        return Colors.purple;
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}