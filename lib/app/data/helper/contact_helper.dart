import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'package:get/get.dart';

import '../common/widgets/custom_snackbar.dart';

class ContactHelper {
  static Future<void> makeCall(String? phoneNumber) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      customSnackbar(
        title: "ভুল",
        message: "ফোন নাম্বার পাওয়া যায়নি",
        isError: true,
      );

      return;
    }

    final Uri launchUri = Uri.parse('tel:${phoneNumber.trim()}');

    try {
      await launchUrl(launchUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      customSnackbar(
        title: "ত্রুটি",
        message: "ফোন ডায়ালার ওপেন করা যাচ্ছে না",
        isError: true,
      );
    }
  }

  static void shareBloodRequest(dynamic post) {
    String message =
        """
🩸 রক্তের প্রয়োজন 🩸

রক্তের গ্রুপ: ${post.bloodGroup ?? 'অজানা'}
পরিমাণ: ${post.unit ?? '১'} ব্যাগ
হাসপাতাল: ${post.hospital ?? ''}
ঠিকানা: ${post.location ?? ''}
তারিখ: ${post.date ?? ''}
যোগাযোগ: ${post.phone ?? ''}

রোগীর সমস্যা: ${post.description ?? 'জরুরি'}

পোস্টটি শেয়ার করে অন্যকে দেখার সুযোগ করে দিন।
""";

    Share.share(message);
  }

  static Future<void> sendWhatsAppMessage(
    String? phoneNumber,
    String? message,
  ) async {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      Get.snackbar("ভুল", "ফোন নাম্বার পাওয়া যায়নি");
      return;
    }

    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final finalPhone = cleanPhone.startsWith('88')
        ? cleanPhone
        : '88$cleanPhone';
    final encodedMessage = Uri.encodeComponent(message ?? "");

    final Uri whatsappUri = Uri.parse(
      "https://wa.me/$finalPhone?text=$encodedMessage",
    );

    try {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } catch (e) {
      customSnackbar(
        title: "ত্রুটি",
        message: "হোয়াটসঅ্যাপ ওপেন করা যাচ্ছে না বা ইনস্টল নেই",
        isError: true,
      );
    }
  }

  static Future<void> openFacebook(String? fullLink) async {
    if (fullLink == null || fullLink.isEmpty) {
      customSnackbar(
        title: "ত্রুটি",
        message: "লিঙ্ক পাওয়া যায়নি",
        isError: true,
      );

      return;
    }

    try {
      final String cleanUrl = fullLink.trim();

      bool launched = await launchUrl(
        Uri.parse(cleanUrl),
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        String username = cleanUrl.split('/').last;
        if (username.isEmpty && cleanUrl.contains('/')) {
          username = cleanUrl.split('/')[cleanUrl.split('/').length - 2];
        }

        final String fbScheme = "fb://facewebmodal/f?href=$cleanUrl";

        await launchUrl(
          Uri.parse(fbScheme),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      }
    } catch (e) {
      await launchUrl(Uri.parse(fullLink), mode: LaunchMode.platformDefault);
    }
  }

  static Future<void> openMap(String location) async {
    if (location.isEmpty || location == "ঠিকানা  তথ্য এড করা হয়নি") {
      customSnackbar(
        title: "ত্রুটি",
        message: "ঠিকানা পাওয়া যায়নি",
        isError: true,
      );

      return;
    }

    final String googleMapUrl =
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(location)}";
    final Uri uri = Uri.parse(googleMapUrl);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        customSnackbar(
          title: "ত্রুটি",
          message: "গুগল ম্যাপ ওপেন করা যাচ্ছে না",
          isError: true,
        );
      }
    } catch (e) {
      customSnackbar(
        title: "ত্রুটি",
        message: "কিছু একটা ভুল হয়েছে",
        isError: true,
      );
    }
  }






  static String privacyPolicyUrl = "https://www.blogger.com/blog/posts/6118972782592398307";

  static Future<void> openPrivacyPolicy() async {
    final Uri uri = Uri.parse(privacyPolicyUrl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('পলিসি পেজটি ওপেন করা যাচ্ছে না');
    }
  }




// --- Rate the App ---
  static Future<void> rateApp() async {
    const String packageName = "com.example.deshi_mart_ecom_app";
    final Uri playStoreUri = Uri.parse("market://details?id=$packageName");
    final Uri browserUri = Uri.parse("https://play.google.com/store/apps/details?id=$packageName");

    try {
      if (await canLaunchUrl(playStoreUri)) {
        await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(browserUri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      customSnackbar(
        title: "ত্রুটি",
        message: "প্লে-স্টোর ওপেন করা যাচ্ছে না",
        isError: true,
      );
    }
  }

  // --- Share App ---
  static void shareApp() {
    const String appLink = "https://play.google.com/store/apps/details?id=com.example.deshi_mart_ecom_app";
    const String message = "Link : $appLink";

    Share.share(message);
  }






}
