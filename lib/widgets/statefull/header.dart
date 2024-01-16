import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:service_app/widgets/statefull/serviceCard.dart';
import '../../classes/khadametBasic.dart';
import 'package:service_app/constants.dart' as constants;
const Duration debounceDuration = Duration(milliseconds: 500);

Future<List<KhadametBasic>?> fetchSearchService(query) async {
  final response = await http.get(Uri.parse('${constants.api}services/search?query=$query'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    if(response.body.isNotEmpty) {
      List<dynamic> dataJson = json.decode(response.body);
      return dataJson.map((json) => KhadametBasic.fromJson(json)).toList();
    }
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load khadmet');
  }
  return null;
}
class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _Header();
}

class _Header extends State<Header> {
  String? _currentQuery;
  late Iterable<Widget> _lastOptions = <Widget>[];
  late final _Debounceable<List<KhadametBasic>, String> _debouncedSearch;
  Future<List<KhadametBasic>?> _search(String query) async {
    _currentQuery = query;

    // In a real application, there should be some error handling here.
    final List<KhadametBasic>? options = await fetchSearchService(_currentQuery!);

    // If another search happened after this one, throw away these options.
    if (_currentQuery != query) {
      return null;
    }
    _currentQuery = null;

    return options;
  }
  @override
  void initState() {
    super.initState();
    _debouncedSearch = _debounce<List<KhadametBasic>, String>(_search);
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
               // _currentQuery = controller.text;
                final List<KhadametBasic>? options =
                (await _debouncedSearch(controller.text))?.toList();
                if (options == null) {
                  return _lastOptions;
                }
                  return options.map((suggestion) =>
                      ServiceCard(khedme:suggestion));
          }),
        ),
      ]),
    );
  }
}
typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } catch (error) {
      if (error is _CancelException) {
        return null;
      }
      rethrow;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}