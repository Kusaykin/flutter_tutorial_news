import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';


class Repository {

  List<Source> sources = <Source>[
    newsDbProvider,
    NewsApiProvider()
  ];

  List<Cache> caches = <Cache>[
    newsDbProvider,
  ];

  // TODO: implement fetchTopIds in NewsDbProvider
  // Iterate over sources when dbprovider
  // get fetchTopIds implemented
  Future<List<int>>fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async {
    ItemModel item;
    var source;
  
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null)
        break;
    }

   caches.forEach((cache) => cache.addItem(item));
//     for(var cache in caches) {
//       if (cache != (source) as Cache)  //check for no double insert or add parameter conflictAlgorithm: ConflictAlgorithm.ignore in db.insert (news_db_provider.dart)
//         cache.addItem(item);
//     }
    return item;
  }

  clearCash() async {
    for(var cache in caches) {
      await cache.clear();
    }

  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
  Future<int> clear();
}