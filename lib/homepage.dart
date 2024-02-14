import 'package:flutter/material.dart';
import 'package:wwm/service/wiki_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();

  late Future<List<User>> futureUsers;

  Future<List<User>> loadUser(String searchString) async {
    final results = await WikiService().getUser(searchString);
    return results;
  }

  @override
  void initState() {
    super.initState();
    futureUsers = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Walk With Me'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Search!',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
              onSubmitted: (String searchString) {
                setState(() {
                  futureUsers = loadUser(searchString);
                });
              },
            ),
            Expanded(
                child: FutureBuilder<List<User>>(
              future: futureUsers,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      User user = snapshot.data![index];
                      return ListTile(
                        title: Text(user.name.firstname),
                        subtitle: Text(user.email),
                        trailing: const Icon(Icons.chevron_right_outlined),
                      );
                    },
                  );
                } else {
                  return const Text('No data found');
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
