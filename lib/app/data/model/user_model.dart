class UserData {
  int? id;
  String? fullName;
  String? email;
  String? phone;
  String? profileImage;
  String? customerName;
  String? fullAddress;
  String? upazila;
  String? district;
  String? postalCode;

  UserData({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.profileImage,
    this.customerName,
    this.fullAddress,
    this.upazila,
    this.district,
    this.postalCode,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());

    fullName = json['full_name']?.toString();
    email = json['email']?.toString();
    phone = json['phone']?.toString();
    profileImage = json['profile_image']?.toString();
    customerName = json['customer_name']?.toString();
    fullAddress = json['full_address']?.toString();
    upazila = json['upazila']?.toString();
    district = json['district']?.toString();

    postalCode = json['postal_code']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['profile_image'] = profileImage;
    data['customer_name'] = customerName;
    data['full_address'] = fullAddress;
    data['upazila'] = upazila;
    data['district'] = district;
    data['postal_code'] = postalCode;
    return data;
  }
}