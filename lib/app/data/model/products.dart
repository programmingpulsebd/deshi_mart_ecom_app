class Products {
  int? id;

  String? categoryName;
  String? productName;
  String? productImage;
  int? price;
  int? offerPrice;
  String? description;
  List<String>? imageGallery;
  int? stock;


  String? createdAt;
  String? updatedAt;
  List<String>? colors;
  List<String>? sizes;
  int? categoryId;
  Products(
      {this.id,
        this.categoryId,
        this.categoryName,
        this.productName,
        this.productImage,
        this.price,
        this.offerPrice,
        this.description,
        this.colors,
        this.sizes,
        this.imageGallery,
        this.stock,
        this.createdAt,
        this.updatedAt});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'] is int ? json['id'] : int.tryParse(json['id'].toString());
    categoryId = json['category_id'] is int ? json['category_id'] : int.tryParse(json['category_id'].toString());

    categoryName = json['category_name'];
    productName = json['product_name'];
    productImage = json['product_image'];

    price = json['price'] is int ? json['price'] : int.tryParse(json['price'].toString());
    offerPrice = json['offer_price'] is int ? json['offer_price'] : int.tryParse(json['offer_price'].toString());

    description = json['description'];

    colors = json['colors'] != null ? List<String>.from(json['colors']) : [];
    sizes = json['sizes'] != null ? List<String>.from(json['sizes']) : [];
    imageGallery = json['image_gallery'] != null ? List<String>.from(json['image_gallery']) : [];

    stock = json['stock'] is int ? json['stock'] : int.tryParse(json['stock'].toString());
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['product_name'] = this.productName;
    data['product_image'] = this.productImage;
    data['price'] = this.price;
    data['offer_price'] = this.offerPrice;
    data['description'] = this.description;
    data['colors'] = this.colors;
    data['sizes'] = this.sizes;
    data['image_gallery'] = this.imageGallery;
    data['stock'] = this.stock;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}