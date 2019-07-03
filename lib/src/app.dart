import 'package:flutter/material.dart';
import 'screens/news_list.dart';
import 'blocs/stories_provider.dart';
import 'screens/news_details.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoriesProvider(
        child: MaterialApp(
      title: 'News',
      onGenerateRoute: routes,
    ));
  }

  Route routes(RouteSettings settings) {
    if (settings.name == '/') {
      return MaterialPageRoute(builder: (context) {
        return NewsList();
      });
    } else {
      return MaterialPageRoute(builder: (context){
        // extract the item id from settings.name
        // and pass into NewsDetsil
        final itemId = int.parse(settings.name.replaceFirst('/', ''));
        return NewsDetails(
          itemId: itemId,
        );
      });
    }
  }

}
