import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waste_management/services/itemcard.dart';
import 'package:waste_management/services/additem.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  final searchItem = TextEditingController();
  List<Map<String, dynamic>> filteredItems = [];
  List<Map<String, dynamic>> items = [];
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    searchItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // const Text(
            //   'Catalog',
            //   style: TextStyle(
            //     fontSize: 30,
            //     fontWeight: FontWeight.w900,
            //     fontFamily: 'RobotoCondensed-Italic',
            //     color: Colors.black,
            //     letterSpacing: 1,
            //   ),
            // ),
            searchitem(),
            const SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Items')
                    .where('uid', isEqualTo: _userId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                            'No items found, Click on Add item to Add item'));
                  }

                  items = snapshot.data!.docs
                      .map((doc) => doc.data() as Map<String, dynamic>)
                      .toList();

                  filteredItems = items
                      .where((item) => item['name']
                          .toLowerCase()
                          .contains(searchItem.text.toLowerCase()))
                      .toList();

                  if (filteredItems.isEmpty) {
                    return const Center(child: Text('No items found'));
                  }

                  return ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      return ItemCard(
                        itemImage: filteredItems[index]['imageUrl'],
                        itemName: filteredItems[index]['name'],
                        itemDescription: filteredItems[index]['description'],
                        itemExpiryDate:
                            DateTime.parse(filteredItems[index]['expiryDate']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: const Additem(),
    );
  }

  Container searchitem() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      child: TextFormField(
        controller: searchItem,
        onChanged: (value) {
          setState(() {
            filteredItems = items
                .where((item) =>
                    item['name'].toLowerCase().contains(value.toLowerCase()))
                .toList();
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search_outlined),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          hintText: 'Search',
        ),
      ),
    );
  }
}
