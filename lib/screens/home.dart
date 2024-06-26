import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/khadametBasic.dart';
import '../widgets/statefull/customlayout.dart';
import '../widgets/statefull/serviceCard.dart';
import '../widgets/ui/circleTabIndicator.dart';

Future<String?> readAccessToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('access_token');
  return accessToken;
}

Future<List<KhadametBasic>> fetchUsersWaiting() async {
  final accessToken = await readAccessToken();
  final response = await http.get(
    Uri.parse('${constants.api}/services/waiting'),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    List<dynamic> dataJson = json.decode(response.body);
    return dataJson.map((json) => KhadametBasic.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<KhadametBasic>> fetchUsersRejected() async {
  final accessToken = await readAccessToken();
  final response = await http.get(
    Uri.parse('${constants.api}/services/rejected'),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    List<dynamic> dataJson = json.decode(response.body);
    return dataJson.map((json) => KhadametBasic.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<KhadametBasic>> fetchUsersDone() async {
  final accessToken = await readAccessToken();
  final response = await http.get(
    Uri.parse('${constants.api}/services/done'),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    List<dynamic> dataJson = json.decode(response.body);
    return dataJson.map((json) => KhadametBasic.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}

Future<List<dynamic>> fetchStats() async {
  try {
    final accessToken = await readAccessToken();
    final response = await http.get(
      Uri.parse('${constants.api}/services/count'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final int countWaiting = data['count_waiting'];
      final int countDone = data['count_done'];

      return [countDone, countWaiting];
    } else {
      print('Failed to fetch statistics: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error fetching statistics: $e');
    return [];
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
  late Future<List<dynamic>> futureStats;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    futureKhadametWaiting = fetchUsersWaiting();
    futureKhadametRejected = fetchUsersRejected();
    futureKhadametDone = fetchUsersDone();
    futureStats = fetchStats();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      child: Column(
        children: [
          SizedBox(
            height: 110,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 130,
                  height: 100,
                  decoration: BoxDecoration(
                    color: constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: fetchStats(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final List<dynamic>? data = snapshot.data;

                            if (data != null && data.isNotEmpty) {
                              return Text(
                                data[0].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                "No data",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'أنجزت',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aljazira'),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 130,
                  height: 100,
                  decoration: BoxDecoration(
                    color: constants.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: fetchStats(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final List<dynamic>? data = snapshot.data;

                            if (data != null && data.isNotEmpty) {
                              return Text(
                                data[1].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            } else {
                              return const Text(
                                "No data",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'قيد الإنجاز',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'aljazira'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            indicator: const CircleTabIndicator(
                color: constants.primaryColor, radius: 3),
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
                text: 'أنجزت',
              ),
              Tab(
                text: 'للحفظ',
              ),
              Tab(
                text: 'قيد الإنجاز',
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
                      future: futureKhadametDone,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          // The data is an array of objects and is not empty
                          return Expanded(
                              child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                0,
                                10,
                                0,
                                kFloatingActionButtonMargin +
                                    150.0), // Adjust the padding as needed
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              // Pass the Data object to the ServiceCard widget
                              return GestureDetector(
                                  child: ServiceCard(
                                      khedme: snapshot.data![index]));
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          // The data is an array of objects and is not empty
                          return Expanded(
                              child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                0,
                                10,
                                0,
                                kFloatingActionButtonMargin +
                                    150.0), // Adjust the padding as needed
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
                      future: futureKhadametWaiting,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          // The data is an array of objects and is not empty
                          return Expanded(
                              child: ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                0,
                                10,
                                0,
                                kFloatingActionButtonMargin +
                                    150.0), // Adjust the padding as needed
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
          const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: []),
        ],
      ),
    );
  }
}
