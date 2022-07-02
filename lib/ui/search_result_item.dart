import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SearchResultItem extends StatelessWidget {
  final String title;
  final String location;
  final String dateTime;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onTap;

  const SearchResultItem(
      {Key? key,
      required this.title,
      required this.location,
      required this.dateTime,
      required this.imageUrl,
      this.isFavorite = false,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: imageUrl,
                      progressIndicatorBuilder: (_, __, ___) => const Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    ),
                  ),
                ),
                if (!isFavorite)
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
              ],
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    location,
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                  ),
                  Text(
                    dateTime,
                    style: Theme.of(context).textTheme.caption?.copyWith(fontSize: 14.0),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
