import 'package:flutter/material.dart';

import 'package:wwm/service/wiki_service.dart';
import 'package:wwm/constants.dart' as constants;
import 'package:wwm/widgets/search_result.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _controller = TextEditingController();

  late Future<List<Entity>> futureEntities;

  Future<List<Entity>> loadEntities(String searchString) async {
    final results = await WikiService().getEntities(searchString);
    return results;
  }

  @override
  void initState() {
    super.initState();
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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Entity entity = snapshot.data![index];
                      return SearchResult(
                        title: entity.title ?? constants.titleUnavilable,
                        subtitle: entity.shortDescription ??
                            constants.descriptionUnavilable,
                      );
                    },
                  );
                } else {
                  return const Text(constants.noDataFound);
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
