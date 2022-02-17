import 'package:flutter/material.dart';

class IndividualErrorContainer extends StatelessWidget {
  final String errorMsg;

  const IndividualErrorContainer({
    this.errorMsg,
  });
  @override
  Widget build(BuildContext context) {
    return errorPopup(context);
  }

  Widget errorPopup(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ConstrainedBox(
        constraints: new BoxConstraints(minWidth: 10.0, minHeight: 20.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Container(
            alignment: Alignment.bottomLeft,
            decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(15)),
            child: ConstrainedBox(
              constraints: new BoxConstraints(
                minWidth: 20,
                maxWidth: MediaQuery.of(context).size.width,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 5, bottom: 5, right: 15),
                child: Text(
                  errorMsg,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  maxLines: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
