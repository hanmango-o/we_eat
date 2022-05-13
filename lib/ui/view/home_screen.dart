import 'package:flutter/material.dart';
import 'package:we_eat/ui/component/board_component.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WE_EAT'),
      ),
      body: Center(
        child: Column(children: [
          BoardComponent(title: 'dd', child: Text('d')),
          Text('글씨1', style: Theme.of(context).textTheme.headline1),
          Text('글씨2', style: Theme.of(context).textTheme.headline2),
          Text('글씨3', style: Theme.of(context).textTheme.headline3),
          Text('글씨4', style: Theme.of(context).textTheme.headline4),
          Text('글씨5', style: Theme.of(context).textTheme.headline5),
          Text('글씨6', style: Theme.of(context).textTheme.headline6),
        ]),
      ),
    );
  }
}
