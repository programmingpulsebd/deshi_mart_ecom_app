class Data {
  int? id;
  int? userId;
  List<OrderItems>? orderItems;
  DeliveryAddress? deliveryAddress;
  int? totalAmount;
  String? paymentStatus;
  String? orderStatus;
  String? orderDate;
  String? createdAt;
  String? updatedAt;
  User? user;

  Data({
    this.id,
    this.userId,
    this.orderItems,
    this.deliveryAddress,
    this.totalAmount,
    this.paymentStatus,
    this.orderStatus,
    this.orderDate,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json) {
    // Safe Integer Parsing
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    userId = json['user_id'] is int ? json['user_id'] : int.tryParse(json['user_id'].toString());

    if (json['order_items'] != null) {
      orderItems = <OrderItems>[];
      json['order_items'].forEach((v) {
        orderItems!.add(OrderItems.fromJson(v));
      });
    }

    deliveryAddress = json['delivery_address'] != null
        ? DeliveryAddress.fromJson(json['delivery_address'])
        : null;

    totalAmount = json['total_amount'] is int
        ? json['total_amount']
        : int.tryParse(json['total_amount'].toString());

    paymentStatus = json['payment_status']?.toString();
    orderStatus = json['order_status']?.toString();
    orderDate = json['order_date']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();

    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    if (orderItems != null) {
      data['order_items'] = orderItems!.map((v) => v.toJson()).toList();
    }
    if (deliveryAddress != null) {
      data['delivery_address'] = deliveryAddress!.toJson();
    }
    data['total_amount'] = totalAmount;
    data['payment_status'] = paymentStatus;
    data['order_status'] = orderStatus;
    data['order_date'] = orderDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class OrderItems {
  int? productId;
  int? quantity;
  int? price;
  int? pId;
  String? name;
  int? qty;

  OrderItems({
    this.productId,
    this.quantity,
    this.price,
    this.pId,
    this.name,
    this.qty,
  });

  OrderItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] is int ? json['product_id'] : int.tryParse(json['product_id'].toString());
    quantity = json['quantity'] is int ? json['quantity'] : int.tryParse(json['quantity'].toString());
    price = json['price'] is int ? json['price'] : int.tryParse(json['price'].toString());
    pId = json['p_id'] is int ? json['p_id'] : int.tryParse(json['p_id'].toString());
    name = json['name']?.toString();
    qty = json['qty'] is int ? json['qty'] : int.tryParse(json['qty'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;
    data['p_id'] = pId;
    data['name'] = name;
    data['qty'] = qty;
    return data;
  }
}

class DeliveryAddress {
  String? address;
  String? city;
  String? area;
  String? zip;

  DeliveryAddress({this.address, this.city, this.area, this.zip});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    address = json['address']?.toString();
    city = json['city']?.toString();
    area = json['area']?.toString();
    zip = json['zip']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['area'] = area;
    data['zip'] = zip;
    return data;
  }
}

class User {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? customerName;
  String? fullAddress;
  String? upazila;
  String? district;
  String? postalCode;
  String? profileImage;
  String? createdAt;
  String? updatedAt;

  User({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.customerName,
    this.fullAddress,
    this.upazila,
    this.district,
    this.postalCode,
    this.profileImage,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    fullName = json['full_name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    customerName = json['customer_name']?.toString();
    fullAddress = json['full_address']?.toString();
    upazila = json['upazila']?.toString();
    district = json['district']?.toString();
    postalCode = json['postal_code']?.toString();
    profileImage = json['profile_image']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['customer_name'] = customerName;
    data['full_address'] = fullAddress;
    data['upazila'] = upazila;
    data['district'] = district;
    data['postal_code'] = postalCode;
    data['profile_image'] = profileImage;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}