import 'package:anywhere/screens/Home/cubit/home_cubit.dart';
import 'package:anywhere/screens/Home/home.dart';
import 'package:anywhere/screens/Home/models/character_list_model.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';


class MockHomeCubit extends MockCubit<HomeState> implements HomeCubit {}

void main() {

  late MockHomeCubit mockHomeCubit;

  final Iconn iconn = Iconn(
      "12", "fake_url", "20"
  );

  final relatedTopics = [
    RelatedTopics("firstURL", iconn, "result", "text"),
    RelatedTopics("firstURL2", iconn, "result2", "text2"),
  ];

  setUp(() {
    mockHomeCubit = MockHomeCubit();
  });
  testWidgets('renders HomeScreen properly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          builder: (context, widget) {
            return HomeScreen();
          },
        )
      )
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text("Character Names"), findsOneWidget);
  });
}