


import 'package:anywhere/screens/Home/home.dart';
import 'package:anywhere/screens/Home/models/character_list_model.dart';
import 'package:anywhere/screens/details/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  final Iconn iconn = Iconn(
      "12", "fake_url", "20"
  );

  final relatedTopics = [
    RelatedTopics("firstURL", iconn, "result", "text"),
    RelatedTopics("firstURL2", iconn, "result2", "text2"),
  ];

  testWidgets('renders DetailsScreen properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          builder: (context, widget) {
            return DetailsScreen(relatedTopics: relatedTopics[0]);
          },
        )
      )
    );

    expect(find.byType(Container), findsOneWidget);
    expect(find.text(relatedTopics[0].text!), findsOneWidget);
    expect(find.text(relatedTopics[0].text!.split(" - ").first), findsOneWidget);
  });
}