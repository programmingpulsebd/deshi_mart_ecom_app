import 'package:get/get.dart';

import '../data/model/products.dart';
import '../modules/auth/changePassword/bindings/change_password_binding.dart';
import '../modules/auth/changePassword/views/change_password_view.dart';
import '../modules/auth/deliveryAddress/bindings/delivery_address_binding.dart';
import '../modules/auth/deliveryAddress/views/delivery_address_view.dart';
import '../modules/auth/forgotPassword/bindings/forgot_password_binding.dart';
import '../modules/auth/forgotPassword/views/forgot_password_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/profile/bindings/profile_binding.dart';
import '../modules/auth/profile/views/profile_view.dart';
import '../modules/auth/profileEdit/bindings/profile_edit_binding.dart';
import '../modules/auth/profileEdit/views/profile_edit_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/auth/resetPassword/bindings/reset_password_binding.dart';
import '../modules/auth/resetPassword/views/reset_password_view.dart';
import '../modules/auth/verifyOtp/bindings/verify_otp_binding.dart';
import '../modules/auth/verifyOtp/views/verify_otp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/products/product/bindings/product_binding.dart';
import '../modules/products/product/views/product_view.dart';
import '../modules/products/productDetails/bindings/product_details_binding.dart';
import '../modules/products/productDetails/views/product_details_view.dart';
import '../modules/settings/TermsCondition/bindings/terms_condition_binding.dart';
import '../modules/settings/TermsCondition/views/terms_condition_view.dart';
import '../modules/settings/about/bindings/about_binding.dart';
import '../modules/settings/about/views/about_view.dart';
import '../modules/settings/helpSupport/bindings/help_support_binding.dart';
import '../modules/settings/helpSupport/views/help_support_view.dart';
import '../modules/settings/privacyPolicy/bindings/privacy_policy_binding.dart';
import '../modules/settings/privacyPolicy/views/privacy_policy_view.dart';
import '../modules/settings/theme/bindings/theme_binding.dart';
import '../modules/settings/theme/views/theme_view.dart';
import '../modules/shops/cart/bindings/cart_binding.dart';
import '../modules/shops/cart/views/cart_view.dart';
import '../modules/shops/checkout/bindings/checkout_binding.dart';
import '../modules/shops/checkout/views/checkout_view.dart';
import '../modules/shops/explore/bindings/explore_binding.dart';
import '../modules/shops/explore/views/explore_view.dart';
import '../modules/shops/favourite/bindings/favourite_binding.dart';
import '../modules/shops/favourite/views/favourite_view.dart';
import '../modules/shops/orderDetails/bindings/order_details_binding.dart';
import '../modules/shops/orderDetails/views/order_details_view.dart';
import '../modules/shops/orderSuccess/bindings/order_success_binding.dart';
import '../modules/shops/orderSuccess/views/order_success_view.dart';
import '../modules/shops/orderTrack/bindings/order_track_binding.dart';
import '../modules/shops/orderTrack/views/order_track_view.dart';
import '../modules/shops/shop/bindings/shop_binding.dart';
import '../modules/shops/shop/views/shop_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
      transition: Transition.rightToLeft,

    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.PROFILE_EDIT,
      page: () => const ProfileEditView(),
      binding: ProfileEditBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.VERIFY_OTP,
      page: () => const VerifyOtpView(),
      binding: VerifyOtpBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.SHOP,
      page: () => ShopView(),
      binding: ShopBinding(),
      transition: Transition.rightToLeft,
      children: [
        GetPage(
          name: _Paths.EXPLORE,
          page: () => const ExploreView(),
          binding: ExploreBinding(),
        ),
        GetPage(
          name: _Paths.CART,
          page: () => const CartView(),
          binding: CartBinding(),
        ),
        GetPage(
          name: _Paths.FAVOURITE,
          page: () => const FavouriteView(),
          binding: FavouriteBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: _Paths.PRODUCT_DETAILS,
      transition: Transition.rightToLeft,
      page: () {
        final products = Get.arguments as Products?;
        return ProductDetailsView(products: products);
      },
      binding: ProductDetailsBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      transition: Transition.rightToLeft,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      transition: Transition.rightToLeft,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_SUCCESS,
      transition: Transition.rightToLeft,
      page: () => const OrderSuccessView(),
      binding: OrderSuccessBinding(),
    ),
    GetPage(
      name: _Paths.DELIVERY_ADDRESS,
      transition: Transition.rightToLeft,
      page: () => const DeliveryAddressView(),
      binding: DeliveryAddressBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_TRACK,
      transition: Transition.rightToLeft,
      page: () => const OrderTrackView(),
      binding: OrderTrackBinding(),
    ),
    GetPage(
      name: _Paths.ORDER_DETAILS,
      transition: Transition.rightToLeft,
      page: () => const OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_PASSWORD,
      transition: Transition.rightToLeft,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.THEME,
      transition: Transition.rightToLeft,
      page: () => const ThemeView(),
      binding: ThemeBinding(),
    ),
    GetPage(
      name: _Paths.PRIVACY_POLICY,
      transition: Transition.rightToLeft,
      page: () => const PrivacyPolicyView(),
      binding: PrivacyPolicyBinding(),
    ),
    GetPage(
      name: _Paths.HELP_SUPPORT,
      transition: Transition.rightToLeft,
      page: () => const HelpSupportView(),
      binding: HelpSupportBinding(),
    ),
    GetPage(
      name: _Paths.TERMS_CONDITION,
      transition: Transition.rightToLeft,
      page: () => const TermsConditionView(),
      binding: TermsConditionBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      transition: Transition.rightToLeft,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
  ];
}
