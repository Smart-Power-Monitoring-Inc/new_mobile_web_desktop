import 'package:admin/controllers/DashboardParamsController.dart';
import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Responsive(
            mobile: FileInfoCardGridView(
              crossAxisCount: _size.width < 650 ? 2 : 4,
              childAspectRatio:
                  _size.width < 650 && _size.width > 350 ? 1.3 : 1,
            ),
            tablet: FileInfoCardGridView(),
            desktop: FileInfoCardGridView(
              childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => StreamBuilder(
          stream: demoMyFiles[index].type == "voltage"
              ? Provider.of<DashbaordParamsController>(context).voltageStream()
              : demoMyFiles[index].type == "current"
                  ? Provider.of<DashbaordParamsController>(context)
                      .currentStream()
                  : demoMyFiles[index].type == "energy"
                      ? Provider.of<DashbaordParamsController>(context)
                          .energyStream()
                      : demoMyFiles[index].type == "power"
                          ? Provider.of<DashbaordParamsController>(context)
                              .powerStream()
                          : Provider.of<DashbaordParamsController>(context)
                              .amountStream(),
          builder: (context, snapshot) {
            if (snapshot.data == null && !snapshot.hasData) {
              return SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator.adaptive(),
              );
            }
            Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
            if (demoMyFiles[index].type == "voltage") {
              demoMyFiles[index].numOfFiles =
                  double.parse(data['avg'].toString());
            } else if (demoMyFiles[index].type == "current") {
              demoMyFiles[index].numOfFiles =
                  double.parse(data['avg'].toString());
            } else if (demoMyFiles[index].type == "energy") {
              demoMyFiles[index].numOfFiles =
                  double.parse(data['avg'].toString());
            } else if (demoMyFiles[index].type == "power") {
              demoMyFiles[index].numOfFiles =
                  double.parse(data['avg'].toString());
            } else {
              demoMyFiles[index].numOfFiles =
                  double.parse(data['avg'].toString());
            }

            return FileInfoCard(info: demoMyFiles[index]);
          }),
    );
  }
}
