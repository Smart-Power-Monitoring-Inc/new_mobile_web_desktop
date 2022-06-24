import 'package:admin/controllers/DeviceController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  bool online = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${online ? "Online" : "Offline"} Devices",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Row(
                children: [
                  Text(
                    "Online",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Switch.adaptive(
                    value: online,
                    onChanged: (value) => setState(() {
                      online = value;
                    }),
                  ),
                ],
              )
            ],
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: 600,
              height: 400,
              child: StreamBuilder<Map<String, dynamic>>(
                  stream:
                      context.read<DeviceController>().getOnlineDevices(online),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData && snapshot.data == null) {
                      return SizedBox(
                        height: 30,
                        width: 30,
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                    Map<String, dynamic>? data = snapshot.data;

                    List devices = [];
                    List<RecentFile> _devices = [];
                    if (data!['result'].containsKey("devices")) {
                      devices = data['result']['devices'];
                      _devices = devices
                          .map(
                            (e) => RecentFile(
                                online: e['state'],
                                date: DateFormat.yMMM()
                                    .add_Hms()
                                    .format(DateTime.now()),
                                size: "",
                                icon: "assets/icons/xd_file.svg",
                                title: e['device_name']),
                          )
                          .toList();
                    }
                    return devices.isEmpty
                        ? Center(
                            child: Text(
                              "No device ${online ? "Online" : "Offline"}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                            ),
                          )
                        : DataTable2(
                            columnSpacing: defaultPadding,
                            minWidth: MediaQuery.of(context).size.width,
                            columns: [
                              DataColumn(
                                label: Text("Device"),
                              ),
                              DataColumn(
                                label: Text("Last seen"),
                              ),
                              DataColumn(
                                label: Text("Status"),
                              ),
                            ],
                            rows: List.generate(
                              _devices.length,
                              (index) =>
                                  recentFileDataRow(_devices[index], context),
                            ),
                          );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(RecentFile fileInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon!,
              height: 30,
              width: 30,
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  fileInfo.title!,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(fileInfo.date!)),
      DataCell(Card(
          color: fileInfo.online ? Colors.green : Colors.red,
          shape: StadiumBorder(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(fileInfo.online ? "On" : "Off"),
          ))),
    ],
  );
}
