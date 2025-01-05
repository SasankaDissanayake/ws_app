import 'package:app/source/chat_request/components/outgoing_title.dart';
import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:app/source/chat_request/controllers/sent_request_controller.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OutgoingRequests extends StatelessWidget {
  final OutgoingRequestController controller =
      Get.put(OutgoingRequestController());
  OutgoingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RequestSendModel>>(
      future: controller.getMyPendingRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final requests = snapshot.data!;
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              return OutgoingRequestTile(request: request);
            },
          );
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        }
        // Show a loading indicator while waiting for data
        return _buildLoadingWidget(context);
      },
    );
  }

  Widget _buildErrorWidget(dynamic error) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              errorAnimation,
              height: 150,
              repeat: true,
            ),
            const Text(
              "Oops! Something went wrong.",
              style: TextStyle(
                fontFamily: 'Oswald',
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "$error",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Oswald',
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Center(
        child: Lottie.asset(
          loadingAnimation,
          repeat: true,
        ),
      ),
    );
  }
}
