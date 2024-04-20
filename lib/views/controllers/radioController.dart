import 'package:get/get.dart';

// Controller for managing radio button selections
class RadioController extends GetxController {
  // Observable variables for selected options
  RxString selectedGoal = ''.obs;
  RxString selectedLocation = ''.obs;
  RxString selectedDiet = ''.obs;
  RxString selectedLanguage = ''.obs;

  // Method to update the selected option for a particular variable
  void selectOption(RxString? variable, String option) {
    variable!.value = option;
    update(); // Notify listeners of the change
  }
}
