import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:time_list/screens/register_screen.dart';
import 'package:time_list/screens/reset_password_modal.dart';
import 'package:time_list/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const FlutterLogo(size: 76),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Senha',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      authService
                          .entrarUsuario(
                          email: _emailController.text,
                          senha: _senhaController.text
                      ).then((String? error) {
                        if (error != null) {
                          final snackBar = SnackBar(
                            content: Text(error),
                            backgroundColor: Colors.red,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (kIsWeb) {
                        singinWithWebGoogle();
                      } else {
                        singinWithGoogle();
                      }
                    },
                    //Futuro botão da Google
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: Image.asset("imagens/google.png"),
                        ),
                      const SizedBox(width: 20),
                      const Text(
                        "Login com Google",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                       )
                      ],
                    )
                  ),
                  const SizedBox(height: 16),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) =>  RegisterScreen()
                        )
                    );
                  },
                      child: const Text(
                        'Não tem conta?, clique aqui',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      )
                  ),
                  TextButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ResetPasswordModal();
                            }
                        );
                      },
                      child: const Text(
                        'Equeceu sua senha?',
                        style: TextStyle(fontSize: 20),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<UserCredential> singinWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void singinWithWebGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '638927132257-muul05h58h5cbnqf9i2295fca71mtlve.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);

  }

}
