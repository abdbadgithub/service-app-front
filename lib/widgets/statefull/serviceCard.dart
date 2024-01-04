import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_app/constants.dart' as constants;

import '../../classes/data.dart';

class ServiceCard extends StatelessWidget {
  final Data data;

  const ServiceCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fullName = '${data.name} ${data.midlename} ${data.lastName}';
    return InkWell(
        onTap: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title:  Text('AlertDialog Title ${data.userId}'),
              content: const Text('AlertDialog description'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Cancel'),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
        child: Container(
          height: 90,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: constants.superLightGrey,
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              )),
          width: MediaQuery.of(context).size.width * 0.9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      )),
                  child: SvgPicture.asset("assets/icons/paper.svg",
                      height: 30, width: 30, fit: BoxFit.scaleDown)),
              IntrinsicHeight(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    fullName.length > 20
                        ? fullName.substring(0, 20) + '...'
                        : fullName,
                    style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'aljazira',
                        fontWeight: FontWeight.bold),
                  ),
                  Text('نوع الخدمة : سجل عدلي',
                      style: TextStyle(
                          fontSize: 12,
                          color: constants.lightGrey,
                          fontFamily: 'aljazira',
                          fontWeight: FontWeight.w400))
                ],
              )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 4, 5, 4),
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    )),
                child: Row(children: [
                  SvgPicture.asset("assets/icons/watch.svg"),
                  const SizedBox(width: 10),
                  const Text(
                    'بالانتظار',
                    style: TextStyle(
                        fontSize: 12,
                        color: constants.grey,
                        fontFamily: 'aljazira',
                        fontWeight: FontWeight.w400),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
