import 'package:flutter/material.dart';
import 'package:proti_box/back_icon.dart';

class Auth extends StatefulWidget {
  final List<Widget> children;
  final Widget? floatingChild;
  final bool isBackBtnShown;
  final bool hasManyTextFields;

  const Auth({
    Key? key,
    this.isBackBtnShown = true,
    required this.children,
    this.floatingChild,
    this.hasManyTextFields = false
  }) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  Widget build(BuildContext context) {
    if (!_isScrolled && _scrollController.hasClients && widget.hasManyTextFields) {
      _scrollController.animateTo(MediaQuery.of(context).viewInsets.bottom > 200 ? 130 : 0,
          duration: Duration(milliseconds: 200), curve: Curves.ease);
      // _isScrolled = true;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: widget.floatingChild != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    controller: _scrollController,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              MediaQuery.of(context).padding.bottom),
                      child: IntrinsicHeight(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: widget.isBackBtnShown
                                      ? BackIcon()
                                      : Container()),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(16),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: widget.children),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.bottomCenter, child: widget.floatingChild)
                ],
              )
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(
                  height: 16,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: widget.isBackBtnShown ? BackIcon() : Container()),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.children),
                  ),
                ),
              ]),
      ),
    );
  }
}
