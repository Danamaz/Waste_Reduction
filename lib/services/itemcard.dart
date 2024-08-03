import 'package:flutter/material.dart';
import 'package:waste_management/services/expiry.dart';

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
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

//expiry Dialog method
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
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("cancel"))
            ],
          );
        });
  }
}
