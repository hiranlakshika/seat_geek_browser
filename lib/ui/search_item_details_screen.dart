import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchItemDetailsScreen extends StatelessWidget {
  final String title;
  final String location;
  final String dateTime;
  final String imageUrl;

  const SearchItemDetailsScreen(
      {Key? key, required this.title, required this.location, required this.dateTime, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(title,
            style: Theme.of(context).textTheme.headline5?.copyWith(
                  fontWeight: FontWeight.bold,
                )),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.blue,
            )),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.blue,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                progressIndicatorBuilder: (_, __, ___) => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              location,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              dateTime,
              style: Theme.of(context).textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
