import 'package:get/get.dart';
import '../../../../data/models/contact_info_response_model.dart';
import '../repository/support_repository.dart';

class SupportController extends GetxController {
  final SupportRepository _repository = Get.find<SupportRepository>();

  Rx<ContactData?> contactInfo = Rx<ContactData?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchContactInfo();
  }

  Future<void> fetchContactInfo() async {
    isLoading.value = true;
    try {
      var response = await _repository.getContactInfo();
      if (response != null && response['status'] == true) {
        ContactInfoResponse contactResponse = ContactInfoResponse.fromJson(response);
        contactInfo.value = contactResponse.data;
      }
    } catch (e) {
      print("Error fetching contact info: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
