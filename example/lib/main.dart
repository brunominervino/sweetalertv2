import 'package:flutter/material.dart';
import 'package:sweetalertv2/sweetalertv2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SweetAlertV2 Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'SweetAlertV2 Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: new Container(
          width: double.infinity,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text("Basic usage"),
              new MaterialButton(
                onPressed: () {
                  SweetAlertV2.show(context, title: "Just show a message");
                },
                child: new Text("Try me"),
                color: SweetAlertV2.success,
                textColor: Colors.white,
              ),
              new Text("Title with subtitle"),
              new MaterialButton(
                onPressed: () {
                  SweetAlertV2.show(context,
                      title: "Just show a message",
                      subtitle: "Sweet alert is pretty");
                },
                child: new Text("Try me"),
                color: SweetAlertV2.success,
                textColor: Colors.white,
              ),
              new Text("A success message"),
              new MaterialButton(
                onPressed: () {
                  SweetAlertV2.show(context,
                      title: "Just show a message",
                      subtitle: "Sweet alert is pretty",
                      style: SweetAlertV2Style.success);
                },
                child: new Text("Try me"),
                color: SweetAlertV2.success,
                textColor: Colors.white,
              ),
              new Text(
                  "A warning message,with a function action on \"Confirm\"-button"),
              new MaterialButton(
                onPressed: () {
                  SweetAlertV2.show(
                    context,
                    title: "Just show a message",
                    subtitle: "Sweet alert is pretty",
                    style: SweetAlertV2Style.confirm,
                    showCancelButton: true,
                    // ignore: missing_return
                    onPress: (bool isConfirm) {
                      if (isConfirm) {
                        SweetAlertV2.show(context,
                            style: SweetAlertV2Style.success, title: "Success");

                        // return false to keep dialog
                        return false;
                      }
                    },
                  );
                },
                child: new Text("Try me"),
                color: SweetAlertV2.success,
                textColor: Colors.white,
              ),
              new Text("Do a job that may take some time"),
              new MaterialButton(
                onPressed: () {
                  SweetAlertV2.show(
                    context,
                    subtitle: "Do you want to delete this message",
                    style: SweetAlertV2Style.confirm,
                    showCancelButton: true,
                    onPress: (bool isConfirm) {
                      if (isConfirm) {
                        SweetAlertV2.show(context,
                            subtitle: "Deleting...",
                            style: SweetAlertV2Style.loading);
                        new Future.delayed(new Duration(seconds: 2), () {
                          SweetAlertV2.show(context,
                              subtitle: "Success!",
                              style: SweetAlertV2Style.success);
                        });
                      } else {
                        SweetAlertV2.show(context,
                            subtitle: "Canceled!",
                            style: SweetAlertV2Style.error);
                      }
                      // return false to keep dialog
                      return false;
                    },
                  );
                },
                child: new Text("Try me"),
                color: SweetAlertV2.success,
                textColor: Colors.white,
              ),
              new Text("Do a job that may fail"),
              new MaterialButton(
                onPressed: () {
                  SweetAlertV2.show(
                    context,
                    subtitle: "Do you want to delete this message",
                    style: SweetAlertV2Style.confirm,
                    showCancelButton: true,
                    // ignore: missing_return
                    onPress: (bool isConfirm) {
                      if (isConfirm) {
                        //Return false to keep dialog
                        if (isConfirm) {
                          SweetAlertV2.show(context,
                              subtitle: "Deleting...",
                              style: SweetAlertV2Style.loading);
                          new Future.delayed(new Duration(seconds: 2), () {
                            SweetAlertV2.show(context,
                                subtitle: "Job fail!",
                                style: SweetAlertV2Style.error);
                          });
                        } else {
                          SweetAlertV2.show(context,
                              subtitle: "Canceled!",
                              style: SweetAlertV2Style.error);
                        }
                        return false;
                      }
                    },
                  );
                },
                child: new Text("Try me"),
                color: SweetAlertV2.success,
                textColor: Colors.white,
              ),
            ],
          ),
        ));
  }
}
