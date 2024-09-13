import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_widget/home_widget.dart';

import 'article_screen.dart';
import 'news_data.dart';

const String androidWidgetName = 'LocketWidget';

void updateHeadline(NewsArticle newHeadline) {
  HomeWidget.saveWidgetData<String>('headline_title', newHeadline.title);
  HomeWidget.saveWidgetData<String>('headline_description', newHeadline.description);
  HomeWidget.updateWidget(
    androidName: androidWidgetName,
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('com.example.locket_widget/native_camera_communication');

  Future<void> _clickPhotoNatively() async {
    try {
      await platform.invokeMethod<int>('clickPhoto');
    } on PlatformException catch (e) {
      log("Fail: '${e.message}'.");
    }
  }

  @override
  void initState() {
    super.initState();
    final newHeadline = getNewsStories()[0];
    updateHeadline(newHeadline);
    platform.setMethodCallHandler((call) async {
      if (call.method == 'photoCaptured') {
        String message = call.arguments;
        log('Photo captured: $message');
        Navigator.of(context).push(
          MaterialPageRoute<ArticleScreen>(
            builder: (context) {
              return ArticleScreen(article: NewsArticle(title: "title", description: "description"));
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Top Stories'),
            centerTitle: false,
            titleTextStyle: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            _clickPhotoNatively();
          },
          label: const Text('Take a Photo'),
        ),
        body: ListView.separated(
          separatorBuilder: (context, idx) {
            return const Divider();
          },
          itemCount: getNewsStories().length,
          itemBuilder: (context, idx) {
            final article = getNewsStories()[idx];
            return ListTile(
              key: Key('$idx ${article.hashCode}'),
              title: Text(article.title),
              subtitle: Text(article.description),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<ArticleScreen>(
                    builder: (context) {
                      return ArticleScreen(article: article);
                    },
                  ),
                );
              },
            );
          },
        ));
  }
}
