import 'package:awesome_app/commons/result_state.dart';
import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:awesome_app/presentation/detail/detail_screen.dart';
import 'package:awesome_app/presentation/home/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:awesome_app/di/get_injection.dart' as di;
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => di.getIt(),
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  context.read<HomeProvider>().setListType();
                },
                icon: context.watch<HomeProvider>().isGrid
                    ? Icon(Icons.featured_play_list_rounded)
                    : Icon(Icons.list),
              )
            ],
            title: Text(
              'My Awesome App',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                context.watch<HomeProvider>().state == ResultState.Error
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.watch<HomeProvider>().message),
                      )
                    : Container(),
                context.watch<HomeProvider>().state == ResultState.NoConnection
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(context.watch<HomeProvider>().message),
                      )
                    : Container(),
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      var isLoading = context.read<HomeProvider>().state;
                      if (isLoading != ResultState.Loading &&
                          scrollInfo.metrics.pixels ==
                              scrollInfo.metrics.maxScrollExtent) {
                        if (context.read<HomeProvider>().nextPage != null)
                          context.read<HomeProvider>().getNextPage();
                      }
                      return true;
                    },
                    child: context.watch<HomeProvider>().isGrid
                        ? _gridBuilder()
                        : _listBuilder(),
                  ),
                ),
                Container(
                  height:
                      context.watch<HomeProvider>().state == ResultState.Loading
                          ? 50
                          : 0,
                  width: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _listBuilder() {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        var list = provider.list;
        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return _listItem(list[index], () {
              Navigator.pushNamed(context, DetailScreen.routeName,
                  arguments: list[index]);
            });
          },
        );
      },
    );
  }

  Widget _listItem(Photo photo, Function() callback) {
    return Card(
      child: ListTile(
        onTap: callback,
        leading: Hero(
          tag: photo.id.toString(),
          child: Image.network(
            photo.src!.landscape ?? '',
            width: 50,
            height: 100,
            fit: BoxFit.fill,
          ),
        ),
        title: Text(
          'Taken by: ${photo.photographer}',
          maxLines: 1,
        ),
      ),
    );
  }

  Widget _gridBuilder() {
    return Consumer<HomeProvider>(
      builder: (context, provider, _) {
        return GridView.builder(
          itemCount: provider.list.length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (BuildContext context, int index) {
            var photo = provider.list[index];
            return _gridItem(photo, () {
              Navigator.pushNamed(context, DetailScreen.routeName,
                  arguments: photo);
            });
          },
        );
      },
    );
  }

  Widget _gridItem(Photo photo, Function() callback) {
    return GestureDetector(
      child: Hero(
        tag: photo.id.toString(),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                Image.network(
                  photo.src!.landscape ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                Row(children: [
                  Expanded(
                      child: Container(
                    child: Text(
                      photo.photographer ?? '',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    color: Color.fromRGBO(255, 255, 255, 0.4),
                    padding: const EdgeInsets.all(8),
                  ))
                ])
              ],
            )),
      ),
      onTap: callback,
    );
  }
}
