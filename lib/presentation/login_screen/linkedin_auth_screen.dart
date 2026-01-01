import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'package:get/get.dart';

class LinkedInAuthScreen extends StatelessWidget {
  const LinkedInAuthScreen({super.key});

  final String clientId = "77er4bokc1x0q6";
  final String clientSecret = "WPL_AP1.Sn33CDp0zynZZysh.HsmgSg==";
  final String redirectUrl = "https://www.linkedin.com/developers/tools/oauth/redirect";

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      appBar: AppBar(
        title: Text(
          "LinkedIn Login",
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 20,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.black : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: LinkedInUserWidget(
          redirectUrl: redirectUrl,
          clientId: clientId,
          clientSecret: clientSecret,
          scope: [
            OpenIdScope(),
            EmailScope(),
            ProfileScope(),
          ],
          onError: (final UserFailedAction e) {
            Get.back(result: e);
          },
          onGetUserProfile: (final UserSucceededAction result) {
            Get.back(result: result);
          },
        ),
      ),
    );
  }
}
