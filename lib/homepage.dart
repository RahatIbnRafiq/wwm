import 'package:flutter/material.dart';

import 'package:wwm/service/wiki_service.dart';
import 'package:wwm/constants.dart' as constants;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();

  late Future<List<Entity>> futureEntities;

  Future<List<Entity>> loadEntities(String searchString) async {
    print("homepage: 1");
    final results = await WikiService().getEntities(searchString);
    print("homepage: 2");
    return results;
  }

  @override
  void initState() {
    super.initState();
    print("homepage: 3");
    futureEntities = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(constants.appTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: constants.searchBarLabelText,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                  },
                ),
              ),
              onSubmitted: (String searchString) {
                setState(() {
                  print("homepage: 4");
                  futureEntities = loadEntities(searchString);
                });
              },
            ),
            Expanded(
                child: FutureBuilder<List<Entity>>(
              future: futureEntities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  print("homepage: 5");
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Entity entity = snapshot.data![index];
                      print("homepage: 6");
                      return ListTile(
                        title: Text(entity.title),
                        subtitle: Text(entity.shortDescription),
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
