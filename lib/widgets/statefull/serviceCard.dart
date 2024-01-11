import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:service_app/constants.dart' as constants;
import '../../classes/khadametBasic.dart';
import 'modal.dart';

class ServiceCard extends StatelessWidget {
  final KhadametBasic khedme;

  const ServiceCard({Key? key, required this.khedme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var fullName =
        '${khedme.data?.name} ${khedme.data?.midlename} ${khedme.data?.lastName}';
    var statusColor;
    var statusIcon;
    var statusTextColor;
    var statusText;
    if (khedme.khadametStatus?.statusId == 1) {
      statusColor = constants.superLightGrey;
      statusIcon = "assets/icons/status/waiting.svg";
      statusTextColor = constants.lightGrey;
      statusText = "بالانتظار";
    } else if (khedme.khadametStatus?.statusId == 2) {
      statusColor = constants.lightGreen;
      statusIcon = "assets/icons/status/done.svg";
      statusTextColor = constants.green;
      statusText = "تم التنفيذ";
    } else if (khedme.khadametStatus?.statusId == 4) {
      statusColor = constants.lightRed;
      statusIcon = "assets/icons/status/rejected.svg";
      statusTextColor = constants.red;
      statusText = "تم الرفض";
    } else {
      statusColor = constants.superLightGrey;
      statusIcon = "assets/icons/status/waiting.svg";
      statusTextColor = constants.lightGrey;
      statusText = "بالانتظار";
    }
    return InkWell(
        onTap: () {
          showCustomModalBottomSheet(context, khedme.idKhedmet);
        },
        child: Container(
          height: 90,
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: statusColor,
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
                  Text('${khedme.khadametSubject?.subjectName}',
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
                  SvgPicture.asset(statusIcon),
                  const SizedBox(width: 10),
                  Text(
                    statusText,
                    style: TextStyle(
                        fontSize: 12,
                        color: statusTextColor,
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

