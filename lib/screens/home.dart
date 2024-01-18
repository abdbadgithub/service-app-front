import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:service_app/screens/services.dart';
import 'package:service_app/constants.dart' as constants;
import 'package:http/http.dart' as http;
import '../classes/khadametBasic.dart';
import '../widgets/statefull/customlayout.dart';
import '../widgets/statefull/serviceCard.dart';
import '../widgets/ui/circleTabIndicator.dart';

Future<List<KhadametBasic>> fetchUsersWaiting() async {
  final response = await http.get(Uri.parse('${constants.api}services/waiting'));

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
Future<List<KhadametBasic>> fetchUsersRejected() async {
  final response = await http.get(Uri.parse('${constants.api}services/rejected'));

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
Future<List<KhadametBasic>> fetchUsersDone() async {
  final response = await http.get(Uri.parse('${constants.api}services/done'));

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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late Future<List<KhadametBasic>> futureKhadametWaiting;
  late Future<List<KhadametBasic>> futureKhadametRejected;
  late Future<List<KhadametBasic>> futureKhadametDone;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    futureKhadametWaiting = fetchUsersWaiting();
    futureKhadametRejected = fetchUsersRejected();
    futureKhadametDone = fetchUsersDone();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Column(children:[
        TabBar(
          indicator:
              CircleTabIndicator(color: constants.primaryColor, radius: 3),
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.grey,
          labelColor: constants.primaryColor,
          labelStyle: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'aljazira'),
          //For Selected tab
          tabs: const [
            Tab(
              text: 'قيد الإنجاز',
            ),
            Tab(
              text: 'للحفظ',
            ),
            Tab(
              text: 'أنجزت',
            ),
          ],
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 500,
          child: TabBarView(
            controller: _tabController,
            children: [
              Column(
                children: [
                  FutureBuilder<List<KhadametBasic>>(
                    future: futureKhadametWaiting,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        // The data is an array of objects and is not empty
                        return Expanded(child:ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0,10,0,kFloatingActionButtonMargin + 90.0), // Adjust the padding as needed
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // Pass the Data object to the ServiceCard widget
                            return ServiceCard(khedme: snapshot.data![index]);
                          },
                        ));
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        // The data array is empty
                        return const Center(child: Text('No data available'));
                      } else {
                        // By default, show a loading spinner
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  FutureBuilder<List<KhadametBasic>>(
                    future: futureKhadametRejected,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        // The data is an array of objects and is not empty
                        return Expanded(child:ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0,10,0,kFloatingActionButtonMargin + 90.0), // Adjust the padding as needed
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // Pass the Data object to the ServiceCard widget
                            return ServiceCard(khedme: snapshot.data![index]);
                          },
                        ));
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        // The data array is empty
                        return const Center(child: Text('No data available'));
                      } else {
                        // By default, show a loading spinner
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  FutureBuilder<List<KhadametBasic>>(
                    future: futureKhadametDone,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        // The data is an array of objects and is not empty
                        return Expanded(child:ListView.builder(
                          padding: const EdgeInsets.fromLTRB(0,10,0,kFloatingActionButtonMargin + 90.0), // Adjust the padding as needed
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            // Pass the Data object to the ServiceCard widget
                            return ServiceCard(khedme: snapshot.data![index]);
                          },
                        ));
                      } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                        // The data array is empty
                        return const Center(child: Text('No data available'));
                      } else {
                        // By default, show a loading spinner
                        return const CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Services()),
                  );
                },
                child: const Text('TextButton'),
              )
            ]),
      ]),
    );
  }
}
