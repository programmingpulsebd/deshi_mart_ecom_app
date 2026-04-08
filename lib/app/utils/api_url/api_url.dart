import 'package:deshi_mart_ecom_app/app/utils/app_config.dart';

class ApiUrl {


  static const String imgBase = '${AppConfig.baseUrl}/storage/';


  static const String register = '${AppConfig.baseUrl}/api/signup';
  static const String login = '${AppConfig.baseUrl}/api/login';
  static const String profile = '${AppConfig.baseUrl}/api/profile';
  static const String updateProfile = '${AppConfig.baseUrl}/api/profile-update';


  static const String changePassword = '${AppConfig.baseUrl}/api/change-password';
  static const String deleteAccount = '${AppConfig.baseUrl}/api/user/delete';


  static const String sendOtp = '${AppConfig.baseUrl}/api/forgot-password-e';
  static const String verifyOtp = '${AppConfig.baseUrl}/api/verify-otp-e';
  static const String resetPassword = '${AppConfig.baseUrl}/api/reset-password-e';


  static const String updateDeliveryAddress = '${AppConfig.baseUrl}/api/delivery-address-update';
  static const String orders = '${AppConfig.baseUrl}/api/orders';
  static const String getOrdersByStatus = '${AppConfig.baseUrl}/api/orders/by-status';






  static const String category = '${AppConfig.baseUrl}/api/categories';
  static const String products = '${AppConfig.baseUrl}/api/products';
  static const String latestProducts = '${AppConfig.baseUrl}/api/products/latest';
  static const String allProducts = '${AppConfig.baseUrl}/api/all-products';
  static const String relatedProducts = '${AppConfig.baseUrl}/api/products/';




 static const String productsByCategory = '${AppConfig.baseUrl}/api/products/category/';


  static const String banners = '${AppConfig.baseUrl}/api/banners';





}