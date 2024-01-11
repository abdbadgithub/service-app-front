import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:service_app/widgets/ui/TextDesign.dart';
import '../../classes/khadamet.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/constants.dart' as constants;

Future<void> showCustomModalBottomSheet(BuildContext context, int id) async {
  final data = await fetchServiceDetails(id);
  String sejelnumber = data.data?.sejelNumber.toString() as String;
  var modalColor;
  if (data.khedmetStatus == 1) {
    modalColor = constants.superLightGrey;
  } else if (data.khadametStatus?.statusId == 2) {
    modalColor = constants.lightGreen;
  } else if (data.khadametStatus?.statusId == 4) {
    modalColor = constants.lightRed;
  } else {
    modalColor = constants.superLightGrey;
  }
  // Fetching data based on the passed ID
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      var screenSize = MediaQuery.of(context).size;

      return Container(
          height: screenSize.height * 0.8, // 80% of the screen's height
          child: Container(
            margin: const EdgeInsets.only(left: 20, right: 20.0, top: 40.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
              color: modalColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text('Item 1'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'رقم ومكان السجل', type: 'title'),
                    title: TextDesign(
                        text: sejelnumber + ' ' + data.data!.sejelPlace!.spName,
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'رقم الهاتف', type: 'title'),
                    title: TextDesign(
                        text: data.data!.dataDetails[0].PersonalPhone,
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'المعرف', type: 'title'),
                    title: TextDesign(
                        text: data.data!.dataDetails[0].mouaref.mouarefName,
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'رقم المعرف', type: 'title'),
                    title: TextDesign(
                        text: data.data!.dataDetails[0].mouaref.mourefPhone,
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'عنوان السكن', type: 'title'),
                    title: TextDesign(
                        text: data.data!.dataDetails[0].HomeAddress,
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'مسؤول المكتب', type: 'title'),
                    title: TextDesign(
                        text: data.khedmehResponsibleOffice!
                            .khedmehResponsibleOffice!,
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'ينتخب', type: 'title'),
                    title: TextDesign(
                        text: data.data?.yantakheb == 0
                            ? 'كلا'
                            : data.data?.yantakheb == 1
                                ? 'نعم'
                                : "",
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'مندوب', type: 'title'),
                    title: TextDesign(
                        text: data.data?.mandoub == 0
                            ? 'كلا'
                            : data.data?.mandoub == 1
                                ? 'نعم'
                                : "",
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'تاريخ التسجيل', type: 'title'),
                    title: TextDesign(
                        text: data.startDate!.day.toString() +
                            '/' +
                            data.startDate!.month.toString() +
                            '/' +
                            data.startDate!.year.toString(),
                        type: 'text'),
                  ),
                  ListTile(
                    leading: TextDesign(text: 'تاريخ التنفيذ', type: 'title'),
                    title: TextDesign(
                        text: data.endDate != null
                            ? data.endDate!.day.toString() +
                                '/' +
                                data.startDate!.month.toString() +
                                '/' +
                                data.startDate!.year.toString()
                            : "لم ينفذ بعد",
                        type: 'text'),
                  ),
                  ListTile(
                    title: TextDesign(text: 'تفاصيل', type: 'title'),
                    subtitle: TextDesign(
                        text: data.khedmetSubjectDetails!,
                        type: 'text'),
                  ),
                  // Your dialog content here
                  // Add more items...
                ],
              ),
            ),
          ));
    },
  );
}

Future<Khadamet> fetchServiceDetails(id) async {
  final response =
      await http.get(Uri.parse('http://localhost:3000/services/$id'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Khadamet.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
