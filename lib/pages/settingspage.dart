import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/screens/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:waste_management/services/local_notifcation.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        toolbarHeight: 60,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(8)),
              Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AccountInfo(),
                      ),
                    );
                  },
                  title: const Text('Account'),
                  leading: const Icon(Icons.person_2_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    AwesomeNotifications().createNotification(
                        content: NotificationContent(
                            id: 1,
                            channelKey: "basic_channel",
                            title: "Hello World",
                            body:
                                "Hey you out there, my notification is working now "));
                  },
                  title: const Text('Notifications'),
                  leading: const Icon(Icons.notifications_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  title: const Text('Dark Mode'),
                  leading: const Icon(Icons.brightness_6),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {},
                  title: const Text('About'),
                  leading: const Icon(Icons.question_mark_rounded),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    print("User has successfully logout");
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content:
                          Text("Successfully logged out, login in to continue"),
                    ));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                  },
                  title: const Text('Logout'),
                  leading: const Icon(Icons.logout),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Account Information
class AccountInfo extends StatefulWidget {
  const AccountInfo({super.key});

  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  String _name = '';
  String _phone = '';
  final _email = FirebaseAuth.instance.currentUser!.email;
  final _userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  fetchUserInfo() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(_userId)
          .get();
      if (snapshot.exists) {
        setState(() {
          _name = snapshot['name'];
          _phone = snapshot['phone'];
        });
      }
    } catch (e) {
      print("Error fetching user info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Information"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(_name),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text(
                  "Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("$_email"),
              ),
              const SizedBox(height: 10),
              ListTile(
                title: const Text(
                  "Phone Number",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(_phone),
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              const Text("Delete Account",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              const Text(
                "Your Account will be permanently removed from the application and data will be lost",
              ),
              const SizedBox(height: 60),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    // deleteUser();  //Uncomment Later
                  },
                  child: const Text("Delete Account",
                      style: TextStyle(color: Colors.red)),
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                  ),
                  child: const Text("Save Changes",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content:
                const Text('Are you sure you want to delete your account?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Delete'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  try {
                    await user.delete();
                    print('Account deleted successfully.');
                  } catch (e) {
                    print('Failed to delete account: $e');
                  }
                },
              ),
            ],
          );
        },
      );
    } else {
      print('User is not logged in.');
    }
  }
}
