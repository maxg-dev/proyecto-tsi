import 'package:cliente_nebu_pos/admin_pages/admin_home.dart';
import 'package:cliente_nebu_pos/user_pages/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../login_page.dart';

class AuthService {
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.email.toString() == "admin@gmail.com") {
              return AdminHome();
            } else {
              return UserHome();
            }
          } else {
            return LoginPage();
          }
        });
  }

  signOut() {
    FirebaseAuth.instance.signOut();
  }

  signOutGoogle() async {
    FirebaseAuth.instance.signOut();
    await GoogleSignIn(
            clientId:
                '439539492915-1ebrl6sj1955iena1def4e0icnrnd1q8.apps.googleusercontent.com')
        .disconnect();
  }
}
