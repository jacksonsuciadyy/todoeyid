import 'package:flutter/material.dart';

const Color PRIMARY_COLOR = Colors.blueAccent;
const Color BACKGROUND_COLOR = Color(0xffE2E7F2);

class CustomBottomNavigationBar extends StatefulWidget {
  final Color backgroundColor;
  final Color itemColor;
  final List<CustomBottomNavigationItem> children;
  final Function(int) onChange;
  final int currentIndex;

  CustomBottomNavigationBar({
    this.backgroundColor = BACKGROUND_COLOR,
    this.itemColor = PRIMARY_COLOR,
    this.currentIndex = 0,
    @required this.children,
    this.onChange,
  });

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  void _changeIndex(int index) {
    if (widget.onChange != null) {
      widget.onChange(index);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.children.map((item) {
          var color = item.color ?? widget.itemColor;
          var icon = item.icon;
          var isCenter = item.isCenter;
          var onTapCenter = item.onTapCenter;
          // var label = item.label;
          int index = widget.children.indexOf(item);
          return GestureDetector(
            onTap: () {
              if (!isCenter) _changeIndex(index);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: isCenter ? 90 : 60,
              padding: EdgeInsets.only(left: 10, right: 10),
              margin: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  // color: widget.currentIndex == index
                  //     ? color.withOpacity(0.3)
                  //     : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  isCenter
                      ? Expanded(
                          child: InkWell(
                            splashColor: Colors.white,
                            onTap: onTapCenter,
                            child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Theme.of(context).primaryColor,
                                ),
                                width: 100,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Icon(
                                  icon,
                                  size: 30,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            child: Icon(
                              icon,
                              size: 30,
                              color: widget.currentIndex == index
                                  ? color
                                  : Colors.grey,
                              // color: widget.currentIndex == index
                              //     ? color
                              //     : color.withOpacity(0.5),
                            ),
                          ),
                        ),
                  // widget.currentIndex == index
                  //     ? Expanded(
                  //         flex: 2,
                  //         child: Text(
                  //           label ?? '',
                  //           overflow: TextOverflow.ellipsis,
                  //           textAlign: TextAlign.center,
                  //           style: TextStyle(
                  //               color: widget.currentIndex == index
                  //                   ? color
                  //                   : color.withOpacity(0.5)),
                  //         ),
                  //       )
                  //     : Container()
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBottomNavigationItem {
  final IconData icon;
  final String label;
  final Color color;
  final bool isCenter;
  final Function onTapCenter;

  CustomBottomNavigationItem({
    @required this.icon,
    @required this.label,
    this.color,
    this.isCenter = false,
    this.onTapCenter,
  });
}
