import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/order_details_controller.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final order = controller.order;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. অর্ডার স্ট্যাটাস এবং আইডি
            _buildSectionCard(
              context,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Order ID: #${order.id ?? 'N/A'}",
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        "Placed on: ${order.orderDate?.split('T')[0] ?? 'N/A'}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  _buildStatusBadge(context, order.orderStatus),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ২. অর্ডার আইটেমস
            Text(
              "Order Items",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSectionCard(
              context,
              padding: EdgeInsets.zero,
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: order.orderItems?.length ?? 0,
                separatorBuilder: (_, __) => Divider(color: theme.dividerColor),
                itemBuilder: (context, index) {
                  final item = order.orderItems![index];
                  final String name =
                      item.name ?? "Product ID: ${item.productId ?? item.pId ?? 'N/A'}";
                  final int quantity = item.quantity ?? item.qty ?? 0;
                  final int price = item.price ?? 0;
                  final int totalItemPrice = quantity * price;

                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    title: Text(
                      name,
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text("Qty: $quantity x TK $price",
                        style: theme.textTheme.bodySmall),
                    trailing: Text(
                      "TK $totalItemPrice",
                      style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // ৩. ডেলিভারি অ্যাড্রেস
            Text(
              "Delivery Address",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSectionCard(
              context,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on,),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.user?.fullName ??
                              order.user?.customerName ??
                              "Customer Name",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (order.deliveryAddress?.address != null)
                          Text("${order.deliveryAddress?.address}",
                              style: theme.textTheme.bodySmall),
                        if (order.deliveryAddress?.city != null ||
                            order.deliveryAddress?.area != null)
                          Text(
                            "${order.deliveryAddress?.area ?? ''}${order.deliveryAddress?.area != null ? ', ' : ''}${order.deliveryAddress?.city ?? ''}",
                            style: theme.textTheme.bodySmall,
                          ),
                        if (order.deliveryAddress?.zip != null)
                          Text("Zip Code: ${order.deliveryAddress?.zip}",
                              style: theme.textTheme.bodySmall),
                        const SizedBox(height: 8),
                        Text(
                          "Phone: ${order.user?.phone ?? 'N/A'}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ৪. Payment Summary
            Text(
              "Payment Summary",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildSectionCard(
              context,
              child: Column(
                children: [
                  _buildSummaryRow(context, "Subtotal", "TK ${order.totalAmount ?? 0}"),
                  Divider(color: theme.dividerColor, height: 25),
                  _buildSummaryRow(context, "Total Amount", "TK ${order.totalAmount ?? 0}",
                      isBold: true),
                  _buildSummaryRow(
                    context,
                    "Payment Status",
                    order.paymentStatus?.toUpperCase() ?? "N/A",
                    isStatus: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context,
      {required Widget child, EdgeInsets? padding}) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildSummaryRow(BuildContext context, String title, String value,
      {bool isBold = false, bool isStatus = false}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                color: isBold ? null : theme.textTheme.bodySmall?.color,
                fontSize: isBold ? 16 : 14,
              )),
          Text(value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: isBold ? 17 : 14,
                color: isStatus ? Colors.green : null,
              )),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context, String? status) {
    final theme = Theme.of(context);
    Color color = theme.colorScheme.secondary; // default accent color
    if (status == 'completed') color = Colors.green;
    if (status == 'cancelled') color = Colors.red;
    if (status == 'shipping') color = Colors.purple;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status?.toUpperCase() ?? "PENDING",
        style: theme.textTheme.bodySmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}