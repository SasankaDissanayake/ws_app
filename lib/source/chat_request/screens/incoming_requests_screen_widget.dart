import 'package:app/source/chat_request/components/incoming_tile.dart';
import 'package:app/source/chat_request/controllers/incomming_request_controller.dart';
import 'package:app/source/chat_request/controllers/request_model.dart';
import 'package:app/source/references/image_references.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IncomingRequests extends StatelessWidget {
  final IncommingRequestController controller =
      Get.put(IncommingRequestController());

  IncomingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RequestSendModel>>(
      future: controller.getMyIncommingRequests(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final requests = snapshot.data!;
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];

              return IncomingRequestTile(request: request);
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
