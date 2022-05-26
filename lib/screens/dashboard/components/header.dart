import 'package:admin/controllers/PageController.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../controllers/AuthController.dart';
import '../../../helper.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        if (!Responsive.isMobile(context))
          FutureBuilder<int?>(
              future: Provider.of<MyPageController>(context).page,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container();
                }
                int? page = snapshot.data;
                return Expanded(
                  flex: 2,
                  child: Text(
                    page == 0
                        ? "Dashboard"
                        : page == 1
                            ? "Manage Devices"
                            : "Settings",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                );
              }),
        if (!Responsive.isMobile(context))
          Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        FutureBuilder<int?>(
            future: Provider.of<MyPageController>(context).page,
            builder: (context, snapshot) {
              if (!snapshot.hasData && snapshot.data != null)
                return Container();
              print(snapshot.data);
              if (snapshot.data == 2) return Container();

              return ProfileCard();
            }),
      ],
    );
  }
}

enum DropDownMenuSelect { ACCOUNT, LOGOUT, NOT_SELECTED }

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  DropDownMenuSelect selected = DropDownMenuSelect.ACCOUNT;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<DropDownMenuSelect>(
          onChanged: (value) {
            setState(() {
              selected = value!;
            });
            if (value == DropDownMenuSelect.LOGOUT) {
              context.read<AuthController>().logout(context);
            }
          },
          value: selected,
          items: [
            DropdownMenuItem(
                value: DropDownMenuSelect.ACCOUNT,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      Img.get("knust.png"),
                      height: 38,
                    ),
                    if (!Responsive.isMobile(context))
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Angelina Jolie"),
                      ),
                  ],
                )),
            DropdownMenuItem(
                value: DropDownMenuSelect.LOGOUT,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/shutdown.png",
                      height: 38,
                    ),
                    if (!Responsive.isMobile(context))
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: defaultPadding / 2),
                        child: Text("Logout"),
                      ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
