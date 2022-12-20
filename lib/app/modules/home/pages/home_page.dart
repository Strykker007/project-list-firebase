import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:listadecompras/app/modules/home/widgets/add_newlist_widget.dart';
import 'package:listadecompras/app/modules/home/widgets/error_dialog_widget.dart';
import 'package:listadecompras/app/modules/home/widgets/item_list_widget.dart';
import '../stores/home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
    store.getShoppingLists();
  }

  @override
  void dispose() {
    Modular.dispose<HomeStore>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de compras'),
      ),
      body: TripleBuilder(
        store: store,
        builder: (context, triple) {
          if (triple.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (triple.event == TripleEvent.error) {
            showDialog(
              context: context,
              builder: (context) {
                return const ErrorDialogWidget(
                  message: 'Erro ao carregar as suas listas',
                );
              },
            );
          }
          if (store.state.isEmpty) {
            return const Center(
              child: Text('Clique no icone + para adicionar uma nova lista'),
            );
          }
          return Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await store.getShoppingLists().catchError((onError) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ErrorDialogWidget(
                            message: 'Erro ao carregar as suas listas',
                          );
                        },
                      );
                    });
                  },
                  child: ListView.builder(
                    itemCount: store.state.length,
                    itemBuilder: (context, index) {
                      return ItemListWidget(listName: store.state[index]);
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Text('Nova lista'),
            SizedBox(width: 5),
            Icon(Icons.add),
          ],
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return const AddNewlistWidget();
            },
          );
        },
      ),
    );
  }
}
