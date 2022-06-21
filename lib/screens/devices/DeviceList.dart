import 'package:admin/controllers/DeviceController.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class DeviceList extends StatefulWidget {
  const DeviceList({
    Key? key,
  }) : super(key: key);

  @override
  State<DeviceList> createState() => _DeviceListState();
}

class _DeviceListState extends State<DeviceList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Devices",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800,
              height: 300,
              child: FutureBuilder<List>(
                  future: context.read<DeviceController>().getDeviceData,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.data == null && !snapshot.hasData) {
                      return CircularProgressIndicator.adaptive();
                    }
                    bool allowRender = snapshot.data![0];
                    if (!allowRender) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          "No devices have been registered",
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                    List devices = snapshot.data![1]
                        .map((device) => RecentFile(
                              date: DateTime.now().toIso8601String(),
                              title: device.name,
                            ))
                        .toList();
                    return DataTable2(
                      columnSpacing: defaultPadding,
                      minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text(
                            "Device Name",
                          ),
                        ),
                        DataColumn(
                          label: Text("Last seen"),
                        ),
                        DataColumn(
                          label: Text("Status"),
                        ),
                        DataColumn(
                          label: Text("Energy"),
                        ),
                        DataColumn(
                          label: Text("GH¢"),
                        ),
                        DataColumn(
                          label: Text(""),
                        ),
                      ],
                      rows: List.generate(
                        devices.length,
                        (index) => recentFileDataRow(devices[index], context),
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

DataRow recentFileDataRow(RecentFile fileInfo, context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SvgPicture.asset(
              fileInfo.icon ?? "assets/icons/xd_file.svg",
              height: 30,
              width: 30,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Text(
                  fileInfo.title!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  // textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      ),
      DataCell(Text(DateFormat.yMMMEd()
          .add_Hm()
          .format(DateTime.parse(fileInfo.date.toString())))),
      DataCell(Text(fileInfo.size ?? "0")),
      DataCell(Text("15 kWH")),
      DataCell(Text("GH¢ 2.14")),
      DataCell(InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Edit " + fileInfo.title!),
                    content: SizedBox(
                      height: 100,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "This field cannot be empty";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Device name"),
                          )
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, primary: Colors.red),
                          onPressed: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Cancel"),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, primary: Colors.green),
                          onPressed: () => Navigator.pop(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Save"),
                          )),
                    ],
                  ));
        },
        child: Text(
          "Edit",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(decoration: TextDecoration.underline),
        ),
      )),
    ],
  );
}
