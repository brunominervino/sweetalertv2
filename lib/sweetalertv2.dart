library sweetalertv2;

import 'package:flutter/material.dart';
import 'package:sweetalertv2/src/cancel.dart';
import 'package:sweetalertv2/src/confirm.dart';
import 'package:sweetalertv2/src/success.dart';

/// Return false to keey dialog showing
typedef bool SweetAlertV2OnPress(bool isConfirm);

enum SweetAlertV2Style { success, error, confirm, loading }

class SweetAlertV2Options {
  /// Title string
  final String title;

  /// Subtitle string
  final String subtitle;

  final SweetAlertV2OnPress onPress;

  /// Default value is `SweetAlertV2.success` when `showCancelButton`=false
  /// and `SweetAlertV2.danger` when `showCancelButton` = true
  final Color confirmButtonColor;

  /// Default value is `SweetAlertV2.cancel`
  final Color cancelButtonColor;

  /// Default value is `SweetAlertV2.successText` when `showCancelButton`=false
  /// and `SweetAlertV2.dangerText` when `showCancelButton` = true
  final String confirmButtonText;

  /// Default value is `SweetAlertV2.cancelText`
  final String cancelButtonText;

  /// If set to true, two buttons will be displayed.
  final bool showCancelButton;

  /// The padding of the title text
  final EdgeInsets titlePadding;

  /// The padding of the subtitle text
  final EdgeInsets subtitlePadding;

  /// Alignment of the title text
  final TextAlign titleTextAlign;

  /// Style of the title text
  final TextStyle titleStyle;

  /// Alignment of the subtitle text
  final TextAlign subtitleTextAlign;

  /// Style of the subtitle text
  final TextStyle subtitleStyle;

  final SweetAlertV2Style style;

  SweetAlertV2Options(
      {this.showCancelButton: false,
      this.title,
      this.subtitle,
      this.onPress,
      this.cancelButtonColor,
      this.cancelButtonText,
      this.confirmButtonColor,
      this.confirmButtonText,
      this.titlePadding,
      this.subtitlePadding,
      this.titleTextAlign,
      this.titleStyle,
      this.subtitleTextAlign,
      this.subtitleStyle,
      this.style});
}

class SweetAlertV2Dialog extends StatefulWidget {
  /// animation curve when showing,if null,default value is `SweetAlertV2.showCurve`
  final Curve curve;

  final SweetAlertV2Options options;

  SweetAlertV2Dialog({
    this.options,
    this.curve,
  }) : assert(options != null);

  @override
  State<StatefulWidget> createState() {
    return new SweetAlertV2DialogState();
  }
}

class SweetAlertV2DialogState extends State<SweetAlertV2Dialog>
    with SingleTickerProviderStateMixin, SweetAlertV2 {
  AnimationController controller;

  Animation tween;

  SweetAlertV2Options _options;

  @override
  void initState() {
    _options = widget.options;
    controller = new AnimationController(vsync: this);
    tween = new Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.animateTo(1.0,
        duration: new Duration(milliseconds: 300),
        curve: widget.curve ?? SweetAlertV2.showCurve);

    SweetAlertV2._state = this;
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    SweetAlertV2._state = null;
    super.dispose();
  }

  @override
  void didUpdateWidget(SweetAlertV2Dialog oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void confirm() {
    if (_options.onPress != null && _options.onPress(true) == false) return;
    Navigator.pop(context);
  }

  void cancel() {
    if (_options.onPress != null && _options.onPress(false) == false) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> listOfChildren = [];

    switch (_options.style) {
      case SweetAlertV2Style.success:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new SuccessView(),
        ));
        break;
      case SweetAlertV2Style.confirm:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new ConfirmView(),
        ));
        break;
      case SweetAlertV2Style.error:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new CancelView(),
        ));
        break;
      case SweetAlertV2Style.loading:
        listOfChildren.add(new SizedBox(
          width: 64.0,
          height: 64.0,
          child: new Center(
            child: new CircularProgressIndicator(),
          ),
        ));
        break;
    }

    if (_options.title != null) {
      listOfChildren.add(Padding(
        padding: this._options.titlePadding ??
            EdgeInsets.only(left: 10.0, top: 10.0),
        child: new Text(
          _options.title,
          textAlign: this._options.titleTextAlign ?? TextAlign.left,
          style: this._options.titleStyle ??
              new TextStyle(
                fontSize: 25.0,
                color: new Color(0xff575757),
              ),
        ),
      ));
    }

    if (_options.subtitle != null) {
      listOfChildren.add(new Padding(
        padding:
            this._options.subtitlePadding ?? new EdgeInsets.only(top: 10.0),
        child: new Text(
          _options.subtitle,
          textAlign: this._options.subtitleTextAlign ?? TextAlign.left,
          style: this._options.subtitleStyle ??
              new TextStyle(
                fontSize: 16.0,
                color: new Color(0xff797979),
              ),
        ),
      ));
    }

    if (_options.style != SweetAlertV2Style.loading) {
      if (_options.showCancelButton) {
        listOfChildren.add(new Padding(
          padding: new EdgeInsets.only(top: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new MaterialButton(
                onPressed: cancel,
                color: _options.cancelButtonColor ?? SweetAlertV2.cancel,
                child: new Text(
                  _options.cancelButtonText ?? SweetAlertV2.cancelText,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
              new SizedBox(
                width: 10.0,
              ),
              new MaterialButton(
                onPressed: confirm,
                color: _options.confirmButtonColor ?? SweetAlertV2.danger,
                child: new Text(
                  _options.confirmButtonText ?? SweetAlertV2.confirmText,
                  style: new TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ));
      } else {
        listOfChildren.add(new Padding(
          padding: new EdgeInsets.only(top: 10.0),
          child: new MaterialButton(
            onPressed: confirm,
            color: _options.confirmButtonColor ?? SweetAlertV2.success,
            child: new Text(
              _options.confirmButtonText ?? SweetAlertV2.successText,
              style: new TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ),
        ));
      }
    }

    return new Center(
        child: new AnimatedBuilder(
            animation: controller,
            builder: (c, w) {
              return new ScaleTransition(
                scale: tween,
                child: new ClipRRect(
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
                  child: new Container(
                      color: Colors.white,
                      width: double.infinity,
                      child: new Padding(
                        padding: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          children: listOfChildren,
                        ),
                      )),
                ),
              );
            }));
  }

  void update(SweetAlertV2Options options) {
    setState(() {
      _options = options;
    });
  }
}

abstract class SweetAlertV2 {
  static Color success = new Color(0xffAEDEF4);
  static Color danger = new Color(0xffDD6B55);
  static Color cancel = new Color(0xffD0D0D0);

  static String successText = "OK";
  static String confirmText = "Confirm";
  static String cancelText = "Cancel";

  static Curve showCurve = Curves.bounceOut;

  static SweetAlertV2DialogState _state;

  static void show(BuildContext context,
      {Curve curve,
      String title,
      String subtitle,
      bool showCancelButton: false,
      SweetAlertV2OnPress onPress,
      Color cancelButtonColor,
      Color confirmButtonColor,
      String cancelButtonText,
      String confirmButtonText,
      EdgeInsets titlePadding,
      EdgeInsets subtitlePadding,
      TextAlign titleTextAlign,
      TextStyle titleStyle,
      TextAlign subtitleTextAlign,
      TextStyle subtitleStyle,
      SweetAlertV2Style style}) {
    SweetAlertV2Options options = new SweetAlertV2Options(
        showCancelButton: showCancelButton,
        title: title,
        subtitle: subtitle,
        style: style,
        onPress: onPress,
        confirmButtonColor: confirmButtonColor,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        cancelButtonColor: cancelButtonColor,
        titlePadding: titlePadding,
        subtitlePadding: subtitlePadding,
        titleTextAlign: titleTextAlign,
        titleStyle: titleStyle,
        subtitleTextAlign: subtitleTextAlign,
        subtitleStyle: subtitleStyle);
    if (_state != null) {
      _state.update(options);
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new Container(
              color: Colors.transparent,
              child: new Padding(
                padding: new EdgeInsets.all(40.0),
                child: new Scaffold(
                  backgroundColor: Colors.transparent,
                  body: new SweetAlertV2Dialog(curve: curve, options: options),
                ),
              ),
            );
          });
    }
  }
}
