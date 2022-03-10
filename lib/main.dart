import 'package:flutter/services.dart';
import 'package:learnenglish_dtmwordswithquiz/const/const.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/dictionary.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/dictionarySearch.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/quiz.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/text_field_translator.dart';
import 'package:learnenglish_dtmwordswithquiz/screens/translator.dart';
import 'package:learnenglish_dtmwordswithquiz/valueManager/valueManager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'database/sql.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueManager>(
      create: (context) => ValueManager(),
      child: Consumer<ValueManager>(
        builder: (context, value, widget) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ScreensTabs(value: value, widget: widget),
        ),
      ),
    );
  }
}

class ScreensTabs extends StatefulWidget {
  final ValueManager value;
  final Widget widget;
  ScreensTabs({this.widget, this.value});
  @override
  _ScreensTabsState createState() => _ScreensTabsState();
}

class _ScreensTabsState extends State<ScreensTabs>
    with TickerProviderStateMixin {
  TabController _tabController;
  Sql sql = Sql();

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
    super.initState();
    sql.db;
    Provider.of<ValueManager>(context, listen: false).getTasks();
    Provider.of<ValueManager>(context, listen: false).getWords();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.book,
                    size: 20,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Dictionary",
                    style: TextStyle(fontSize: 10, fontFamily: "Carme"),
                  )
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.question,
                    size: 20,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Quiz",
                    style: TextStyle(fontSize: 10, fontFamily: "Carme"),
                  )
                ],
              ),
            ),
            Tab(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.book,
                    size: 20,
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "Translator",
                    style: TextStyle(fontSize: 10, fontFamily: "Carme"),
                  )
                ],
              ),
            ),
          ],
          labelColor: kBlue,
          unselectedLabelColor: Color(0xffEBEBEB),
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(3.0),
          indicatorColor: kBlue,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            widget.value.toDictionary
                ? DictionarySearch()
                : Dictionary(tabController: _tabController),
            Quiz(
              toTranslator: () =>
                  _tabController.animateTo((_tabController.index + 1)),
              toDictionary: () =>
                  _tabController.animateTo((_tabController.index - 1)),
            ),
            widget.value.toTextField
                ? Translator()
                : TextFieldTranslator(tabController: _tabController),
          ],
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
