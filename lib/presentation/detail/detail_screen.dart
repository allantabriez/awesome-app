import 'package:awesome_app/data/model/get_photos_response.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/details';

  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Photo photo = ModalRoute.of(context)!.settings.arguments as Photo;
    return Scaffold(
      appBar: AppBar(
        title: Text(photo.photographer ?? ''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
                tag: photo.id.toString(),
                child: Image.network(photo.src!.landscape ?? '')),
            SizedBox(height: 16,),
            Text('Check out this picture at:',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(photo.url ?? '',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
