import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:service_app/widgets/ui/TextDesign.dart';
import '../../classes/khadamet.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/constants.dart' as constants;

void showCustomModalBottomSheet(BuildContext context, int id) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return ServiceDetailsModal(id: id);
    },
  );
}

class ServiceDetailsModal extends StatefulWidget {
  final int id;

  const ServiceDetailsModal({Key? key, required this.id}) : super(key: key);

  @override
  _ServiceDetailsModalState createState() => _ServiceDetailsModalState();
}

class _ServiceDetailsModalState extends State<ServiceDetailsModal> {
  late Future<Khadamet> futureServiceDetails;

  @override
  void initState() {
    super.initState();
    futureServiceDetails = fetchServiceDetails(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Khadamet>(
      future: futureServiceDetails,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return buildModalContent(context, snapshot.data!);
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget buildModalContent(BuildContext context, Khadamet data) {
    String sejelnumber = data.data?.sejelNumber.toString() as String;
    Color modalColor;
    if (data.khedmetStatus == 1) {
      modalColor = constants.superLightGrey;
    } else if (data.khadametStatus?.statusId == 2) {
      modalColor = constants.lightGreen;
    } else if (data.khadametStatus?.statusId == 4) {
      modalColor = constants.lightRed;
    } else {
      modalColor = constants.superLightGrey;
    }

    var screenSize = MediaQuery.of(context).size;
    return Localizations.override(
        context: context,
        locale: const Locale('ar'),
        child: Builder(builder: (context) {
          return SizedBox(
              height: screenSize.height * 0.8, // 80% of the screen's height
              child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20.0, top: 40.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      topLeft: Radius.circular(20.0)),
                  color: modalColor,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: const TextDesign(
                            text: 'رقم ومكان السجل', type: 'title'),
                        title: TextDesign(
                            text:
                                '$sejelnumber ${data.data!.sejelPlace!.spName}',
                            type: 'text'),
                      ),
                      ListTile(
                        leading:
                            const TextDesign(text: 'رقم الهاتف', type: 'title'),
                        title: TextDesign(
                            text: data.data!.dataDetails[0].PersonalPhone,
                            type: 'text'),
                      ),
                      ListTile(
                        leading:
                            const TextDesign(text: 'المعرف', type: 'title'),
                        title: TextDesign(
                            text: data.data!.dataDetails[0].mouaref.mouarefName,
                            type: 'text'),
                      ),
                      ListTile(
                        leading:
                            const TextDesign(text: 'رقم المعرف', type: 'title'),
                        title: TextDesign(
                            text: data.data!.dataDetails[0].mouaref.mourefPhone,
                            type: 'text'),
                      ),
                      ListTile(
                        leading: const TextDesign(
                            text: 'عنوان السكن', type: 'title'),
                        title: TextDesign(
                            text: data.data!.dataDetails[0].HomeAddress,
                            type: 'text'),
                      ),
                      ListTile(
                        leading: const TextDesign(
                            text: 'مسؤول المكتب', type: 'title'),
                        title: TextDesign(
                            text: data.khedmehResponsibleOffice!
                                .khedmehResponsibleOffice!,
                            type: 'text'),
                      ),
                      ListTile(
                        leading: const TextDesign(text: 'ينتخب', type: 'title'),
                        title: TextDesign(
                            text: data.data?.yantakheb == 0
                                ? 'كلا'
                                : data.data?.yantakheb == 1
                                    ? 'نعم'
                                    : "",
                            type: 'text'),
                      ),
                      ListTile(
                        leading: const TextDesign(text: 'مندوب', type: 'title'),
                        title: TextDesign(
                            text: data.data?.mandoub == 0
                                ? 'كلا'
                                : data.data?.mandoub == 1
                                    ? 'نعم'
                                    : "",
                            type: 'text'),
                      ),
                      ListTile(
                        leading: const TextDesign(
                            text: 'تاريخ التسجيل', type: 'title'),
                        title: TextDesign(
                            text:
                                '${data.startDate!.day}/${data.startDate!.month}/${data.startDate!.year}',
                            type: 'text'),
                      ),
                      ListTile(
                        leading: const TextDesign(
                            text: 'تاريخ التنفيذ', type: 'title'),
                        title: TextDesign(
                            text: data.endDate != null
                                ? '${data.endDate!.day}/${data.startDate!.month}/${data.startDate!.year}'
                                : "لم ينفذ بعد",
                            type: 'text'),
                      ),
                      ListTile(
                        title: const TextDesign(text: 'تفاصيل', type: 'title'),
                        subtitle: TextDesign(
                            text: data.khedmetSubjectDetails!, type: 'text'),
                      ),
                      // Your dialog content here
                      // Add more items...
                    ],
                  ),
                ),
              ));
        }));
  }
}

Future<Khadamet> fetchServiceDetails(int id) async {
  final response = await http.get(Uri.parse('${constants.api}services/$id'));

  if (response.statusCode == 200) {
    return Khadamet.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load service details');
  }
}

// Future<void> showCustomModalBottomSheet(BuildContext context, int id) async {
//   showModalBottomSheet(
//     isScrollControlled: true,
//     context: context,
//     builder: (BuildContext context) {
//       return FutureBuilder<Khadamet>(
//         future: fetchServiceDetails(id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return buildModalContent(context, snapshot.data!);
//           } else {
//             return const Center(child: Text('No data available'));
//           }
//         },
//       );
//     },
//   );
// }
