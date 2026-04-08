import 'package:deshi_mart_ecom_app/app/data/model/user_model.dart';
import 'package:deshi_mart_ecom_app/app/data/services/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../data/common/widgets/custom_snackbar.dart';
import '../../profile/controllers/profile_controller.dart';

class DeliveryAddressController extends GetxController {

  final AuthServices authServices = AuthServices();

  final customerController = TextEditingController();
  final phoneController = TextEditingController();
  final postalCodeController = TextEditingController();
  final upazilaController = TextEditingController();
  final districtController = TextEditingController();
  final fullAddressController = TextEditingController();


  var isLoading = false.obs;

  final ProfileController profileController = Get.find<ProfileController>();
  late UserData userData;




  @override
  void onInit() {
    super.onInit();
    loadDeliveryAddresses();
  }


  Future<void> saveDeliveryAddress() async {

    final customerName = customerController.text.trim();
    final phone = phoneController.text.trim();
    final postalCode = postalCodeController.text.trim();
    final upazila = upazilaController.text.trim();
    final district = districtController.text.trim();
    final fullAddress = fullAddressController.text.trim();

    if(customerName.isEmpty || phone.isEmpty || postalCode.isEmpty || upazila.isEmpty || district.isEmpty || fullAddress.isEmpty ){
      customSnackbar( title: 'Error', message: 'All fields are required', isError: true);
      return;
    }



    try{
      isLoading.value = true;

      final data = {
        "customer_name" : customerName,
        "phone" : phone,
        "postal_code" : postalCode,
        "upazila" : upazila,
        "district" : district,
        "full_address" : fullAddress,

      };

      final response = await authServices.updateDeliveryAddress(data);

      if(response.statusCode == 200){
        profileController.loadUserData();
        Get.back();
        customSnackbar(title: 'Success', message: 'Delivery address saved successfully');
      } else{
        customSnackbar(title: 'Error', message: 'Failed to save delivery address', isError: true);
      }

    } catch(e){
      throw Exception("Error : $e");
    } finally{
      isLoading.value = false;
    }




  }



  void loadDeliveryAddresses() {
    if (Get.arguments != null && Get.arguments is UserData) {
      final UserData data = Get.arguments;

      customerController.text = data.customerName ?? "";
      phoneController.text = data.phone ?? "";
      postalCodeController.text = data.postalCode ?? "";
      upazilaController.text = data.upazila ?? "";
      districtController.text = data.district ?? "";
      fullAddressController.text = data.fullAddress ?? "";

      print("Data Loaded: ${data.customerName}");
    } else {
      print("No arguments found!");
    }
  }



}
