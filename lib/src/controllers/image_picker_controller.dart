import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePickerController extends GetxController {
  RxString imagePath = ''.obs;
  RxString imagePath1 = ''.obs;

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path.toString();
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadProfileImage();
  }

  Future<void> getProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath1.value = image.path;
      await pref.setString('profileImage', imagePath1.value);
    }
  }

  Future<void> loadProfileImage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    imagePath1.value = pref.getString('profileImage') ?? '';
  }
}
