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
    Source source;
  
    for (source in sources) {
      item = await source.fetchItem(id);
      if (item != null)
        break;
    }

    caches.forEach((cache) => cache.addItem(item));
    // for(var cache in caches)
    //   cache.addItem(item);

    return item;
  }
}

abstract class Source {
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache {
  Future<int> addItem(ItemModel item);
}