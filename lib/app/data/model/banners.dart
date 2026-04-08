class Banners {
  int? id;
  int? categoryId;
  String? categoryName;
  String? bannerImage;
  String? createdAt;
  String? updatedAt;

  Banners({
    this.id,
    this.categoryId,
    this.categoryName,
    this.bannerImage,
    this.createdAt,
    this.updatedAt,
  });

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());

    categoryId = json['category_id'] is int
        ? json['category_id']
        : int.tryParse(json['category_id'].toString());

    categoryName = json['category_name']?.toString();
    bannerImage = json['banner_image']?.toString();
    createdAt = json['created_at']?.toString();
    updatedAt = json['updated_at']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['banner_image'] = this.bannerImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}