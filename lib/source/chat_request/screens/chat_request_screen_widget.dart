import 'package:app/source/chat_request/screens/incoming_requests_screen_widget.dart';
import 'package:app/source/chat_request/screens/outgoing_requests_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatRequests extends StatelessWidget {
  const ChatRequests({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: isDark ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.white,
          title: TabBar(
            dividerColor: Colors.transparent,
            tabs: [
              Tab(
                icon: Text(
                  'incoming',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Tab(
                icon: Text(
                  'outgoing',
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
            indicatorColor: isDark ? Colors.white : Colors.black,
            labelColor: isDark ? Colors.white : Colors.black,
          ),
        ),
        body: TabBarView(
          children: [
            IncomingRequests(),
            OutgoingRequests(),
          ],
        ),
      ),
    );
  }
}
