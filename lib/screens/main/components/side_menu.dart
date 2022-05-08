import 'package:admin/controllers/PageController.dart';
import 'package:admin/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(Img.get("knust.png")),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                Provider.of<MyPageController>(context, listen: false)
                    .setPage(0);
              },
            ),
            DrawerListTile(
              title: "Manage Devices",
              svgSrc: "assets/icons/menu_doc.svg",
              press: () {
                Provider.of<MyPageController>(context, listen: false)
                    .setPage(1);
              },
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "assets/icons/menu_setting.svg",
              press: () {
                Provider.of<MyPageController>(context, listen: false)
                    .setPage(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key,
      // For selecting those three line once press "Command+D"
      required this.title,
      required this.svgSrc,
      required this.press,
      this.selected = false})
      : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ListTile(
        onTap: press,
        // horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(
          svgSrc,
          color: Colors.white54,
          height: 16,
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.white54),
        ),
        trailing: selected
            ? Icon(
                Icons.circle,
                size: 10,
                color: Colors.green,
              )
            : null,
      ),
    );
  }
}
