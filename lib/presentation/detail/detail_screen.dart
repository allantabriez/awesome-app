import 'package:awesome_app/presentation/detail/detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:awesome_app/di/get_injection.dart' as di;
import 'package:provider/provider.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/details';

  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int _id = ModalRoute.of(context)!.settings.arguments as int;
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => di.getIt.get(param1: _id),
      child: Scaffold(),
    );
  }
}
