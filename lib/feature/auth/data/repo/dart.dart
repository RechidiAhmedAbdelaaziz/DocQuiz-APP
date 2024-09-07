import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInDemo extends StatefulWidget {
  @override
  _GoogleSignInDemoState createState() => _GoogleSignInDemoState();
}

class _GoogleSignInDemoState extends State<GoogleSignInDemo> {
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ],
      serverClientId:
          '933236697069-mrmr7vndplo8ap4pm1um81m4rlb3acdf.apps.googleusercontent.com');

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleSignIn(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn(GoogleSignInAccount user) async {
    try {
      // Get the Google authentication token
      final auth = await user.authentication;
      final idToken = auth.idToken;

      print(idToken); // Print null

      // Send the token to your backend for validation
      final response = await http.get(
        Uri.parse(
            'http://192.168.1.12:3000/o-auth/google/callback?code=$idToken'),
      );
      print(response.body);

      if (response.statusCode == 200) {
        // Handle the response and save tokens from your backend
        print('Login successful!');
      } else {
        print('Failed to sign in with Google');
      }
    } catch (error) {
      print('Error signing in: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Sign-In')),
      body: Center(
        child: _currentUser == null
            ? ElevatedButton(
                onPressed: () async {
                  try {
                    await _googleSignIn.signIn();
                  } catch (error) {
                    print(error);
                  }
                },
                child: Text('Sign in with Google'),
              )
            : ElevatedButton(
                onPressed: () async {
                  await _googleSignIn.signOut();
                  setState(() {
                    _currentUser = null;
                  });
                },
                child: Text('Sign out'),
              ),
      ),
    );
  }
}
