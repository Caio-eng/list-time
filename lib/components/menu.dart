import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_list/screens/login_screen.dart';
import 'package:time_list/services/auth_service.dart';

class Menu extends StatefulWidget {
  final User user;
  const Menu({super.key, required this.user});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: (widget.user.photoURL != null)
                  ? NetworkImage(widget.user.photoURL!)
                  : null,
              child: (widget.user.photoURL == null)
                  ? const Icon(
                Icons.manage_accounts_rounded,
                size: 48,
              )
                  : null,
            ),
            accountName: Text((widget.user.displayName != null) ? widget.user.displayName! : ''),
            accountEmail: Text(widget.user.email!),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Excluir Conta'),
            onTap: () {
              excluirConta();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Sair'),
            onTap: () {
              AuthService().deslogar();
            },
          ),
        ],
      )

    );
  }

  void excluirConta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Excluir Conta'),
          content: const Text('Tem certeza de que quer excluir sua conta?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                _confirmarExclusao();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _confirmarExclusao() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance.collection(user.uid).get().then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        });

        await user.delete();
        await FirebaseAuth.instance.signOut();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Conta excluída com sucesso.')),
        );
      } else {
        print('Nenhum usuário logado.');
      }
    } catch (e) {
      print('Erro ao excluir a conta: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao excluir a conta. Tente novamente.')),
      );
    }
  }

}
