import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/screens/detailpage.dart';

class Recipientpage extends StatefulWidget {
  const Recipientpage({super.key});

  @override
  State<Recipientpage> createState() => _RecipientpageState();
}

class _RecipientpageState extends State<Recipientpage> {
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  List<Map<String, dynamic>> recipients = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipients',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 4.0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Recipients")
            .where('uid', isEqualTo: _userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Text(
                    'No Recipient Found. Click on Add Recipient Below to add one'));
          }
          recipients = snapshot.data!.docs.map((doc) => doc.data()).toList();
          return ListView.builder(
            itemCount: recipients.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Name : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${recipients[index]['name']}",
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            "Email : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${recipients[index]['email']}",
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            "Phone : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${recipients[index]['phone']}",
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Text(
                            "Address : ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${recipients[index]['address']}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DetailsPage()),
          );
        },
        tooltip: "Add recipient",
        child: const Icon(Icons.add),
      ),
    );
  }
}
