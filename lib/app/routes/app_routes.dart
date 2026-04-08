part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const HOME = _Paths.HOME;
  static const REGISTER = _Paths.REGISTER;
  static const LOGIN = _Paths.LOGIN;
  static const PROFILE = _Paths.PROFILE;
  static const PROFILE_EDIT = _Paths.PROFILE_EDIT;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const VERIFY_OTP = _Paths.VERIFY_OTP;
  static const RESET_PASSWORD = _Paths.RESET_PASSWORD;
  static final SHOP = _Paths.SHOP;
  static const EXPLORE = _Paths.EXPLORE;
  static const CART = _Paths.CART;
  static const FAVOURITE = _Paths.FAVOURITE;
  static const SPLASH = _Paths.SPLASH;
  static const PRODUCT_DETAILS = _Paths.PRODUCT_DETAILS;
  static const PRODUCT = _Paths.PRODUCT;
  static const CHECKOUT = _Paths.CHECKOUT;
  static const ORDER_SUCCESS = _Paths.ORDER_SUCCESS;
  static const DELIVERY_ADDRESS = _Paths.DELIVERY_ADDRESS;
  static const ORDER_TRACK = _Paths.ORDER_TRACK;
  static const ORDER_DETAILS = _Paths.ORDER_DETAILS;
  static const CHANGE_PASSWORD = _Paths.CHANGE_PASSWORD;
  static const THEME =  _Paths.THEME;
  static const PRIVACY_POLICY = _Paths.PRIVACY_POLICY;
  static const HELP_SUPPORT = _Paths.HELP_SUPPORT;
  static const TERMS_CONDITION = _Paths.TERMS_CONDITION;
  static const ABOUT =  _Paths.ABOUT;
}

abstract class _Paths {
  _Paths._();

  static const HOME = '/home';
  static const REGISTER = '/register';
  static const LOGIN = '/login';
  static const PROFILE = '/profile';
  static const PROFILE_EDIT = '/profile-edit';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const VERIFY_OTP = '/verify-otp';
  static const RESET_PASSWORD = '/reset-password';
  static const SHOP = '/shops';
  static const EXPLORE = '/explore';
  static const CART = '/cart';
  static const FAVOURITE = '/favourite';
  static const SPLASH = '/splash';
  static const PRODUCT_DETAILS = '/product-details';
  static const PRODUCT = '/product';
  static const CHECKOUT = '/checkout';
  static const ORDER_SUCCESS = '/order-success';
  static const DELIVERY_ADDRESS = '/delivery-address';
  static const ORDER_TRACK = '/order-track';
  static const ORDER_DETAILS = '/order-details';
  static const CHANGE_PASSWORD = '/change-password';
  static const THEME = '/theme';
  static const PRIVACY_POLICY = '/privacy-policy';
  static const HELP_SUPPORT = '/help-support';
  static const TERMS_CONDITION = '/terms-condition';
  static const ABOUT = '/about';
}
