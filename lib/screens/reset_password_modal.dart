import 'package:flutter/material.dart';
import 'package:time_list/services/auth_service.dart';

class ResetPasswordModal extends StatefulWidget {
  const ResetPasswordModal({super.key});

  @override
  State<ResetPasswordModal> createState() => _ResetPasswordModalState();
}

class _ResetPasswordModalState extends State<ResetPasswordModal> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Recuperar senha'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(labelText: 'Endereço de e-mail'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Informe um endereço de e-mail válido!';
            } else {
              return null;
            }
          },
        ),
      ),
      actions: <TextButton> [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            if(_formKey.currentState!.validate()) {
              authService.redefinicaoSenha(
                  email: _emailController.text
              ).then((String? erro) {
                Navigator.of(context).pop();

                if(erro != null) {
                  final snackBar = SnackBar(
                    content: Text(erro),
                    backgroundColor: Colors.red,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                } else {
                  final snackBar = SnackBar(
                    content: Text('Um e-mail de redefinição de senha foi enviado para o seu endereço de e-mail: ${_emailController.text}')
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              });
            }
          },
          child: const Text('Recuperar senha'),
        )
      ],
    );
  }
}
