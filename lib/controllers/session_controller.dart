import 'package:get/get.dart';
import 'package:untitled/models/sessions_model.dart';
import 'package:untitled/repository/repository_class.dart';

class SessionController extends GetxController {
  var isLoading = true.obs;

  var sessionsList = <Sessions>[].obs;

  @override
  void onInit() {
    fetchtfinalsessions();
    super.onInit();
  }

  void fetchtfinalsessions() async {
    isLoading(true);
    try {
      var data = await Repository.getSessions();
      if (data != null) {
        sessionsList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
