import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/menu.dart';
import '../models/hour.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hour> listHours = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Menu(user: widget.user),
      appBar: AppBar(
        title: const Text('Time List'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {

          },
          child: const Icon(Icons.add),
      ),
      body: (listHours.isEmpty) ? const Center(
        child: Text(
            'Nada a ser exibido.\nRegistre suas horas',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18
            ),
        ),
      ) : ListView(
        padding: const EdgeInsets.only(left: 16, right: 16),
        children: List.generate(listHours.length, (index) {
          Hour model = listHours[index];
          return Dismissible(
              key: ValueKey<Hour>(model),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 12),
                color: Colors.red,
                child: const Icon(Icons.delete_forever, color: Colors.white),
              ),
            onDismissed: (direction) {
                remove(model);
            },
            child: Card(
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    onLongPress: () {},
                    onTap: () {},
                    leading: const Icon(Icons.list_alt_rounded, size: 56),
                    title: Text("Data: ${model.data} hora: ${model.minutos}"),
                    subtitle: Text(model.descricao!),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void remove(Hour model) {}
}
