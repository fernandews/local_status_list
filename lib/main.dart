import 'package:cozy/cozy.dart';
import 'package:flutter/material.dart';

import 'local_status_list_component/status_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LocalStatusList(
          type: LocalStatusListType.connected,
          items: [
            LocalStatusListItem(
              iconData: CozyIcons.info,
              status: LocalStatusListItemStatus.attention,
              title: 'Dados do proprietário',
              description: 'ainda é necessária por que esse campo é usado no Semantics no componente',
              content: Button(label: 'Isso é um Widget', onPressed: () {  },),
              withMenu: true,
            ),
            LocalStatusListItem(
              iconData: CozyIcons.check,
              status: LocalStatusListItemStatus.success,
              title: 'Localização',
              description:
              'Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel Complete o endereço do imóvel',
              onTap: () {
                debugPrint("Clicked in Locatization");
              },
            ),
          ],
        ),
      ),
    );
  }
}
