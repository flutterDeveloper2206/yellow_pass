import 'package:flutter/material.dart';
import 'package:linkedin_login/linkedin_login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LinkedIn Login',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LinkedinExample(),
    );
  }
}

class LinkedinExample extends StatelessWidget {
  const LinkedinExample({Key? key}) : super(key: key);

  final String clientId = "77er4bokc1x0q6";
  final String clientSecret = "WPL_AP1.Sn33CDp0zynZZysh.HsmgSg==";
  final String redirectUrl = "https://www.linkedin.com/developers/tools/oauth/redirect";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LinkedIn Login")),
      body: Center(
        child: ElevatedButton(
          child: const Text("Login with LinkedIn"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LinkedInUserWidget(
                  redirectUrl: redirectUrl,
                  clientId: clientId,
                  clientSecret: clientSecret,
                  scope: [
                    OpenIdScope(),
                    EmailScope(),
                    ProfileScope(),
                  ],

                  onGetUserProfile: (UserSucceededAction result) {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => UserDetailScreen(user: result.user),
                      ),
                    );
                  },

                  onError: (error) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString())),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class UserDetailScreen extends StatelessWidget {
  final EnrichedUser user;
  const UserDetailScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LinkedIn User Info")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Profile Image
            if (user.picture != null)
              Center(
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(user.picture!),
                ),
              ),

            const SizedBox(height: 15),

            Text("Name: ${user.name ?? ''}", style: textStyle()),
            Text("Email: ${user.email ?? ''}", style: textStyle()),
            Text("User ID Token: ${user.token.accessToken ?? ''}", style: textStyle()),
            Text("User ID Token: ${user.token.expiresIn ?? ''}", style: textStyle()),
            Text("Email Verified: ${user.isEmailVerified ?? ''}", style: textStyle()),
            Text("Profile Image URL: ${user.picture ?? ''}", style: textStyle()),

            const SizedBox(height: 20),

            const Text("Raw JSON Response:", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  user.toString(),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle() =>
      const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
}
