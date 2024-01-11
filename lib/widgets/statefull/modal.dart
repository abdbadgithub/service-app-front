import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:service_app/widgets/ui/TextDesign.dart';
import '../../classes/khadamet.dart';
import 'package:http/http.dart' as http;
Future<void> showCustomModalBottomSheet(BuildContext context, int id) async {
      final data = await fetchServiceDetails(id);
      String sejelnumber = data.data?.sejelNumber.toString() as String;
      // Fetching data based on the passed ID
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          var screenSize = MediaQuery.of(context).size;

          return Container(
            height: screenSize.height * 0.8, // 80% of the screen's height
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text('Item 1'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'رقم ومكان السجل',type:'title'),
                      title: TextDesign(text: sejelnumber+' '+data.data!.sejelPlace!.spName,type:'text'),
                  ),
                  // Your dialog content here
                  // Add more items...
                ],
              ),
            ),
          );
        },
      );
    }
Future<Khadamet> fetchServiceDetails(id) async {
  final response = await http.get(Uri.parse('http://localhost:3000/services/$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return  Khadamet.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
