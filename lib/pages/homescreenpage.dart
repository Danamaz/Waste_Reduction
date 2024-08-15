import 'package:bulleted_list/bulleted_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Home',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
        ),
        body: Container(
          margin: const EdgeInsets.all(5),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Discover the methods used to preserve processed foods and products to extend shelf life:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    //color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                BulletedList(listItems: [
                  Text(
                      'Canning or Jarrings: Canning is a popular method for preserving foods by sealing them in airtight containers and heating them to eliminate any microorganisms present. This process can prolong the shelf life of foods such as fruits, vegetables, sauces, and soups for months or even years when done correctly.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Freezing: Freezing is an effective way to maintain the quality and freshness of many foods by slowing down the growth of microbes and chemical reactions that cause spoilage. Foods like meats, seafood, vegetables, and prepared meals can last for several months when stored at appropriate freezing temperatures.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Dehydration or Drying: Dehydrating foods removes most of their moisture content, inhibiting the growth of microorganisms and slowing down enzymatic reactions that lead to spoilage. Properly packaged dried fruits, vegetables, herbs, and jerky can have extended shelf lives ranging from months to years.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Vacuum Sealing: Vacuum sealing removes air from the packaging, creating an environment that inhibits the growth of bacteria and fungi, thus extending the shelf life of the product. This method is commonly used for preserving meats, cheeses, and snack foods.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Irradiation: Food irradiation uses ionizing radiation, such as gamma rays or electron beams, to kill harmful microorganisms and extend the shelf life of foods like fresh produce, meats, and spices. It can also delay ripening and sprouting in certain products.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Modified Atmosphere Packaging (MAP): MAP involves altering the gaseous environment within the food packaging by introducing specific mixtures of gases, such as carbon dioxide, nitrogen, or oxygen. This inhibits the growth of spoilage microorganisms and oxidation reactions, prolonging the shelf life of products like fresh produce, baked goods, and ready-to-eat meals.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600)),
                  Text(
                      'Preservatives and Additives: Various preservatives, such as salt, sugar, vinegar, natural or synthetic antioxidants, and antimicrobials, can be added to processed foods to inhibit microbial growth, enzymatic browning, and oxidation, thereby extending their expiration dates.',
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600))
                ])
              ],
            ),
          ),
        ));
  }
}
