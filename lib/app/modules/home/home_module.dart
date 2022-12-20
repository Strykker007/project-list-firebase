import 'package:flutter_modular/flutter_modular.dart';
import 'package:listadecompras/app/modules/home/home_repository.dart';
import 'package:listadecompras/app/modules/home/stores/list_details_store.dart';
import 'pages/list_details_page.dart';
import 'stores/home_store.dart';

import 'pages/home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    Bind.lazySingleton((i) => ListDetailsStore()),
    Bind.lazySingleton((i) => HomeRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const HomePage()),
    ChildRoute('/listDetails',
        child: (_, args) => ListDetailsPage(
              listName: args.data,
            )),
  ];
}
