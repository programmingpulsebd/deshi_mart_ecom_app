import 'package:deshi_mart_ecom_app/app/data/model/products.dart';

class FavouriteModel {
  final int id;
  final String productName;
  final String productImage;
  final int price;
  final int? offerPrice;
  final String? categoryName;
  final int? stock;

  FavouriteModel({
    required this.id,
    required this.productName,
    required this.productImage,
    required this.price,
    this.offerPrice,
    this.categoryName,
    this.stock,
  });

  factory FavouriteModel.fromProduct(Products product) => FavouriteModel(
    id: product.id!,
    productName: product.productName!,
    productImage: product.productImage!,
    price: product.price!,
    offerPrice: product.offerPrice,
    categoryName: product.categoryName,
    stock: product.stock,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_name': productName,
    'product_image': productImage,
    'price': price,
    'offer_price': offerPrice,
    'category_name': categoryName,
    'stock': stock,
  };

  factory FavouriteModel.fromJson(Map<String, dynamic> json) => FavouriteModel(
    id: json['id'],
    productName: json['product_name'],
    productImage: json['product_image'],
    price: json['price'],
    offerPrice: json['offer_price'],
    categoryName: json['category_name'],
    stock: json['stock'],
  );

  int get effectivePrice => offerPrice ?? price;
}