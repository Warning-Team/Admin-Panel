import 'package:admin_panel/models/user.dart';
import 'package:admin_panel/views/screens/request_detail_screen.dart';
import 'package:flutter/material.dart';

class RequestsScreen extends StatefulWidget {
  const RequestsScreen({super.key});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> {
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    List<User> fetchedUsers = await fetchUsersFromApi();
    setState(() {
      users = fetchedUsers;
    });
  }

  Future<List<User>> fetchUsersFromApi() async {
    await Future.delayed(const Duration(seconds: 0));
    return [
      User(
        id: 1,
        apiId: 'api_001',
        name: 'John',
        surname: 'Doe',
        phoneNumber: '123456789',
        workPlace: 'Company A',
        login: 'john.doe',
        password: 'password',
        role: 'user',
      ),
      User(
        id: 2,
        apiId: 'api_002',
        name: 'Jane',
        surname: 'Smith',
        phoneNumber: '987654321',
        workPlace: 'Company B',
        login: 'jane.smith',
        password: 'password',
        role: 'admin',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Screen"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue.shade100,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const RequestDetailsScreen(requestId: 'request1'),
                ),
              );
            },
            child: Card(
              color: Colors.lightBlue.shade100,
              child: ListTile(
                title: Text('${user.name} ${user.surname}'),
                subtitle: Text(user.workPlace),
              ),
            ),
          );
        },
      ),
    );
  }
}
