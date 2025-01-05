import 'package:app/source/chat/screens/chat_home_screen_widget.dart';
import 'package:app/source/chat_request/screens/chat_request_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Get.mediaQuery.platformBrightness == Brightness.dark;
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: isDark ? Colors.black : Colors.white,
            appBar: AppBar(
              backgroundColor: isDark ? Colors.black : Colors.white,
              automaticallyImplyLeading: false,
              title: Text(
                'Chats',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                ),
              ),
              bottom: TabBar(
                tabs: [
                  const Tab(
                    icon: Text('         '),
                  ),
                  Tab(
                    icon: Text(
                      'requests',
                      style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
                indicatorColor: isDark ? Colors.white : Colors.black,
                labelColor: isDark ? Colors.white : Colors.black,
              ),
            ),
            body: const TabBarView(
              children: [
                ChatHome(),
                ChatRequests(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
