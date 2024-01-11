import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/widgets/statefull/serviceCard.dart';
import '../../classes/khadametBasic.dart';
import '../../screens/services.dart';
Future<List<KhadametBasic>> fetchSearchService(query) async {
  final response = await http.get(Uri.parse('http://localhost:3000/services/search?query=${query}'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<dynamic> dataJson = json.decode(response.body);
    return dataJson.map((json) => KhadametBasic.fromJson(json)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _Header();
}

class _Header extends State<Header> {
  final TextEditingController _controller = TextEditingController();
  String? _searchingWithQuery;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 275,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/img/header-bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(children: <Widget>[
        Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: const EdgeInsets.only(top: 65.0),
            child: const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الخدمات',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                      color: Colors.white,
                      fontFamily: 'aljazira'),
                ))),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.only(top: 20.0),
          child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'ابحث عن خدمات او شخص',
                  padding: const MaterialStatePropertyAll<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 16.0)),
                  onTap: () {
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                  leading: const Icon(Icons.search),
                  trailing: <Widget>[
                    Tooltip(
                      message: 'Change brightness mode',
                      child: IconButton(
                        icon: SvgPicture.asset("assets/icons/search_settings.svg"),
                        onPressed: () {  },
                      ),
                    )
                  ],
                );
              }, suggestionsBuilder:
              (BuildContext context, SearchController controller)  async{
                _searchingWithQuery = controller.text;
                return fetchSearchService(_searchingWithQuery).then((suggestions) {
                  return suggestions.map((suggestion) =>
                      ServiceCard(khedme:suggestion));
                });
          }),
        ),
      ]),
    );
  }
}
