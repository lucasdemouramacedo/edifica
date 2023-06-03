import 'package:edifica/menu_page_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';

class NavigationBarItem extends StatelessWidget {
  final MenuPageStatus menuPageStatus;
  final int index;
  const NavigationBarItem(
      {Key? key, required this.menuPageStatus, required this.index})
      : super(key: key);

  static const TextStyle optionStyle = TextStyle(
      fontFamily: 'Source Sans Pro',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      decoration: TextDecoration.none);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {menuPageStatus.changeStatus(index)},
      child: Observer(builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: menuPageStatus.status == index ? 20 : 0,
              top: menuPageStatus.status == index ? 0 : 22.5),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                color: menuPageStatus.status == index
                    ? const Color.fromRGBO(113, 151, 194, 1)
                    : Colors.transparent,
              ),
              child: Padding(
                  padding: EdgeInsets.only(
                    left: menuPageStatus.status == index ? 10 : 0,
                    right: menuPageStatus.status == index ? 11 : 0,
                    top: menuPageStatus.status == index ? 10 : 0,
                    bottom: menuPageStatus.status == index ? 10 : 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      menuPageStatus.titles[index].toString(),
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 18,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.bold,
                        color:  menuPageStatus.status == index ? Colors.white :Color.fromRGBO(52, 68, 86, 1.0),
                      ),
                    ),
                  ))),
        );
      }),
    );
  }
}
