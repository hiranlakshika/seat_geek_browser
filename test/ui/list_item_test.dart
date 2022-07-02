import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:seat_geek_browser/ui/list_item.dart';

void main() {
  //This test does not work due to the CachedNetworkImage. Need to find a proper solution for that
  group("list item widget tests", () {
    testWidgets("list item style widget evaluation", (widgetTester) async {
      const String title = "Test 1";
      const String location = 'Texas';
      const String dateTime = '2022-07-02T20:10:00';

      final widget = Builder(builder: (BuildContext context) {
        return MaterialApp(
            theme: Theme.of(context),
            home: Scaffold(
                body: ListItem(
              title: title,
              location: location,
              dateTime: dateTime,
              onTap: () {},
              imageUrl: '',
            )));
      });

      await widgetTester.pumpWidget(widget);
      await widgetTester.pumpAndSettle();

      var titleFind = find.text(title);
      expect(titleFind, findsOneWidget);
      Text titleText = widgetTester.firstWidget(titleFind);
      expect(titleText.style?.fontSize, 20.0);
      expect(titleText.style?.letterSpacing, 0.15);
    });
  });
}
