import 'package:news_demo/main.dart';
import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String errorMsg;

  const ErrorContainer({this.errorMsg});

  @override
  Widget build(BuildContext context) {
    return errorPopup(context);
  }

  Widget errorPopup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minWidth: 25.0,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Container(
          alignment: Alignment.center,
          decoration: new BoxDecoration(
              color: Colors.white, borderRadius: new BorderRadius.circular(20)),
          child: ConstrainedBox(
            constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                errorMsg,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                maxLines: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
