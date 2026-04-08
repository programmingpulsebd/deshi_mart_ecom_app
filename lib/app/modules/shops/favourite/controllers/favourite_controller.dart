import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../data/auth_services/auth_session.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../../../data/model/fav_model.dart';
import '../../../../routes/app_pages.dart';

class FavouriteController extends GetxController {


  final RxList<FavouriteModel> favItems = <FavouriteModel>[].obs;
  static const _favKey = 'fav_items';
  final AuthSession authSession = AuthSession();

  @override
  void onInit() {
    super.onInit();
    _loadFav();
  }

  Future<void> _loadFav() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      favItems.assignAll(
        decoded
            .map((e) => FavouriteModel.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }
  }

  Future<void> _saveFav() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _favKey,
      jsonEncode(favItems.map((e) => e.toJson()).toList()),
    );
  }

  Future<void> toggleFav(FavouriteModel item) async {
    final loggedIn = await authSession.checkLogin();
    if (!loggedIn) {
      Get.toNamed(Routes.LOGIN);
      return;
    }

    if (isFav(item.id)) {
      favItems.removeWhere((e) => e.id == item.id);
      customSnackbar(
        title: "Removed",
        message: "${item.productName} removed from favourites",
        isError: false,
      );
    } else {
      favItems.add(item);
      customSnackbar(
        title: "Added",
        message: "${item.productName} added to favourites",
        isError: false,
      );
    }
    await _saveFav();
  }

  Future<void> removeFromFav(int id) async {
    favItems.removeWhere((e) => e.id == id);
    await _saveFav();
  }

  Future<void> clearFav() async {
    favItems.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favKey);
  }

  bool isFav(int id) => favItems.any((e) => e.id == id);
  int get totalFavs => favItems.length;
}