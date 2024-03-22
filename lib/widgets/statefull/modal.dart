import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/constants.dart' as constants;
import 'package:service_app/screens/home.dart';
import 'package:service_app/widgets/ui/TextDesign.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../classes/khadamet.dart';

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

    if (data.khedmetStatus == 1) {
    } else if (data.khadametStatus?.statusId == 2) {
    } else if (data.khadametStatus?.statusId == 4) {
    } else {}
    futureServiceDetails = fetchServiceDetails(widget.id);
    return Localizations.override(
      context: context,
      locale: const Locale('ar'),
      child: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.only(left: 20, right: 20.0, top: 40.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Home()),
                                );
                              },
                              child: const Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            ListTile(
                              leading: const TextDesign(
                                text: 'رقم ومكان السجل',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text:
                                    '$sejelnumber ${data.data!.sejelPlace!.spName}',
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'رقم الهاتف',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data.data!.dataDetails[0].PersonalPhone,
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'المعرف',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data
                                    .data!.dataDetails[0].mouaref.mouarefName,
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'رقم المعرف',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data
                                    .data!.dataDetails[0].mouaref.mourefPhone,
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'عنوان السكن',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data.data!.dataDetails[0].HomeAddress,
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'مسؤول المكتب',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data.khedmehResponsibleOffice!
                                    .khedmehResponsibleOffice!,
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'ينتخب',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data.data?.yantakheb == 0
                                    ? 'كلا'
                                    : data.data?.yantakheb == 1
                                        ? 'نعم'
                                        : "",
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'مندوب',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data.data?.mandoub == 0
                                    ? 'كلا'
                                    : data.data?.mandoub == 1
                                        ? 'نعم'
                                        : "",
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'تاريخ التسجيل',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text:
                                    '${data.startDate!.day}/${data.startDate!.month}/${data.startDate!.year}',
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              leading: const TextDesign(
                                text: 'تاريخ التنفيذ',
                                type: 'title',
                              ),
                              title: TextDesign(
                                text: data.endDate != null
                                    ? '${data.endDate!.day}/${data.startDate!.month}/${data.startDate!.year}'
                                    : "لم ينفذ بعد",
                                type: 'text',
                              ),
                            ),
                            ListTile(
                              title: const TextDesign(
                                text: 'تفاصيل',
                                type: 'title',
                              ),
                              subtitle: TextDesign(
                                text: data.khedmetSubjectDetails!,
                                type: 'text',
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ملاحظات',
                      style: TextStyle(
                          color: constants.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'aljazira'),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * .85,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Colors.white,
                        ),
                        child: const Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'لوريم إيبسوم هو نص شكلي يستخدم في الطباعة والنشر. يعتبر النص الشكلي المعياري في هذه الصناعة منذ القرن الخامس عشر. يتكون من كلمات لاتينية مشوهة بشكل عشوائي.',
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .85,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                        color: Colors.white,
                      ),
                      child: const Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'لوريم إيبسوم هو نص شكلي يستخدم في الطباعة والنشر. يعتبر النص الشكلي المعياري في هذه الصناعة منذ القرن الخامس عشر. يتكون من كلمات لاتينية مشوهة بشكل عشوائي.',
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  width: MediaQuery.of(context).size.width * .9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9D9D9),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {},
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/add.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return SizedBox(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                const TextField(
                                                  maxLines: null,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFFD9D9D9),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 15,
                                                        vertical: 10),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () async {},
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        SizedBox(width: 8),
                                                        Text(
                                                          'إضافة ملاحظة',
                                                          style: TextStyle(
                                                              color: constants
                                                                  .primaryColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontFamily:
                                                                  'aljazira'),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: const Text(
                                      'إضافة ملاحظة',
                                      style: TextStyle(
                                          color: constants.primaryColor,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'aljazira'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9D9D9),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                int idKhedmet = prefs.getInt('idKhedmet') ?? 0;
                                String? accessToken =
                                    prefs.getString('access_token');
                                print('Retrieved idKhedmet: $idKhedmet');

                                String url =
                                    'https://service-app.abdallahbadra.com/services/status/rejected/$idKhedmet';

                                try {
                                  http.Response response = await http.put(
                                    Uri.parse(url),
                                    headers: {
                                      'Authorization': 'Bearer $accessToken',
                                      'Content-Type': 'application/json',
                                    },
                                  );

                                  if (response.statusCode == 200) {
                                    print('HTTP Request successful');
                                    print('Response data: ${response.body}');
                                  } else {
                                    print(
                                        'HTTP Request failed with status code: ${response.statusCode}');
                                  }
                                } catch (error) {
                                  print('Error during HTTP Request: $error');
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/deny.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'رفض',
                                    style: TextStyle(
                                        color: Color(0xFFDE5353),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'aljazira'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFD9D9D9),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                int idKhedmet = prefs.getInt('idKhedmet') ?? 0;
                                String? accessToken =
                                    prefs.getString('access_token');
                                print(accessToken);
                                print('Retrieved idKhedmet: $idKhedmet');

                                String url =
                                    'https://service-app.abdallahbadra.com/services/status/done/$idKhedmet';

                                try {
                                  http.Response response = await http.put(
                                    Uri.parse(url),
                                    headers: {
                                      'Authorization': 'Bearer $accessToken',
                                      'Content-Type': 'application/json',
                                    },
                                  );

                                  if (response.statusCode == 200) {
                                    print('HTTP Request successful');
                                    print('Response data: ${response.body}');
                                  } else {
                                    print(
                                        'HTTP Request failed with status code: ${response.statusCode}');
                                  }
                                } catch (error) {
                                  print('Error during HTTP Request: $error');
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/icons/check.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'تنفيذ',
                                    style: TextStyle(
                                        color: Color(0xFF96D580),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'aljazira'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Future<String?> readAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('access_token');
  return accessToken;
}

Future<Khadamet> fetchServiceDetails(int id) async {
  final accessToken = await readAccessToken();
  final response = await http.get(
    Uri.parse('${constants.api}services/$id'),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    print(response.body);
    return Khadamet.fromJson(
      json.decode(response.body),
    );
  } else {
    throw Exception('Failed to load service details');
  }
}
