import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

class LinkedInAuthScreen extends StatelessWidget {
  const LinkedInAuthScreen({super.key});

  final String clientId = "77er4bokc1x0q6";
  final String clientSecret = "WPL_AP1.Sn33CDp0zynZZysh.HsmgSg==";
  final String redirectUrl = "https://www.linkedin.com/developers/tools/oauth/redirect";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LinkedIn Login"),
      ),
      body: LinkedInUserWidget(
        redirectUrl: redirectUrl,
        clientId: clientId,
        clientSecret: clientSecret,
        scope: [
          OpenIdScope(),
          EmailScope(),
          ProfileScope(),
        ],
        onError: (final UserFailedAction e) {
          Navigator.pop(context, e);
        },
        onGetUserProfile: (final UserSucceededAction result) {
          Navigator.pop(context, result);
        },
      ),
    );
  }
}
