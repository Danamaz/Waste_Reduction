import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:waste_management/services/expiry.dart';
import 'package:http/http.dart' as http;

class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.itemImage,
    required this.itemName,
    required this.itemDescription,
    required this.itemExpiryDate,
  });

  final String itemImage;
  final String itemName;
  final String itemDescription;
  final DateTime itemExpiryDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        daysToExpiry(context);
      },
      child: Card.filled(
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 155,
                    height: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17),
                      image: DecorationImage(
                        image: NetworkImage(itemImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Text(
                            itemName,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text(
                          'Expiry Date: ${itemExpiryDate.toString().split(' ')[0]}',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                itemDescription,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // expiry Dialog method
  void daysToExpiry(BuildContext context) {
    ExpiryCalculator calculator = ExpiryCalculator(expiryDate: itemExpiryDate);
    final expiryInfo = calculator.expiryStatus();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Expiry Date Information"),
          content: Text(expiryInfo),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  final imageUrl = itemImage;
                  final url = Uri.parse(imageUrl);
                  final response = await http.get(url);

                  if (response.statusCode == 200) {
                    final bytes = response.bodyBytes;

                    final tempDir = await getTemporaryDirectory();
                    final filePath = '${tempDir.path}/image.jpg';
                    final file = File(filePath);
                    await file.writeAsBytes(bytes);

                    final xFile = XFile(filePath);

                    await Share.shareXFiles(
                      [xFile],
                      text: '$itemName\n\n$itemDescription\n$itemImage',
                    );
                  } else {
                    print('Failed to download image.');
                  }
                } catch (e) {
                  print('Error during sharing: $e');
                }
              },
              child: const Text("Share"),
            ),
            TextButton(onPressed: () {}, child: const Text("Donate")),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
