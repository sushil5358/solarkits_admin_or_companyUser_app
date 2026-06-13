// lib/controllers/otp_controller.dart
import 'dart:async';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var timerSeconds = 60.obs;
  var canResendOtp = false.obs;
  Timer? _timer;

  void startTimer() {
    _timer?.cancel();
    timerSeconds.value = 60;
    canResendOtp.value = false;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        canResendOtp.value = true;
        _timer?.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    timerSeconds.value = 60;
    canResendOtp.value = false;
  }

  void resendOtp() {
    if (canResendOtp.value) {
      startTimer();
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}