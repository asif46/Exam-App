import 'package:get/get.dart';
import 'package:untitled/models/student_notification_model.dart';
import 'package:untitled/repository/repository_class.dart';

class NotificationCOntroller extends GetxController {
  var isLoading = true.obs;

  var notificationList = <StudentNotifications>[].obs;

  @override
  void onInit() {
    fetchtfinalNotifications();
    super.onInit();
  }

  void fetchtfinalNotifications() async {
    isLoading(true);
    try {
      var data = await Repository.getNotifications();
      if (data != null) {
        notificationList.value = data;
      }
    } finally {
      isLoading(false);
    }
  }
}
