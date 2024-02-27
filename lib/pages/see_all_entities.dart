import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wwm/models/entities_model.dart';
import 'package:wwm/constants.dart' as constants;
import 'package:wwm/models/entity_model.dart';
import 'package:wwm/widgets/entity_tile.dart';

class SeeAllEntities extends StatelessWidget {
  const SeeAllEntities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final entities = Provider.of<EntitiesModel>(context).entities;
    return Scaffold(
      appBar: AppBar(
        title: const Text('See All Items'),
      ),
      body: ListView.builder(
        itemCount: entities.length,
        itemBuilder: (context, index) {
          String wikiKey = entities.keys.elementAt(index);
          Entity? entity = entities[wikiKey];
          return EntityTile(
            title: entity?.title ?? constants.titleUnavilable,
            subtitle:
                entity?.shortDescription ?? constants.descriptionUnavilable,
            onAdd: () {},
            isDownloaded: entity!.isDownloaded,
          );
        },
      ),
    );
  }
}
