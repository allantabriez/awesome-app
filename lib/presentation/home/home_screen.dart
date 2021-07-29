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
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                context.read<HomeProvider>().setListType();
              },
              icon: Icon(Icons.list),
            )
          ],
          title: Text(
            'My Awesome App',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  var isLoading = context.read<HomeProvider>().state.loading;
                  if (isLoading == false &&
                      scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                    context.read<HomeProvider>().getNextPage();
                  }
                  return true;
                },
                child: Container(),
              ),
            ),
            Container(
              height: context.watch<HomeProvider>().state.loading == true ? 50 : 0,
              child: CircularProgressIndicator.adaptive(),
            )
          ],
        ),
      ),
    );
  }
}
