
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/utils/ps_dimens.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatefulWidget {
  const ErrorDialog({required this.message});
  final String message;
  @override
  _ErrorDialogState createState() => _ErrorDialogState();
}

class _ErrorDialogState extends State<ErrorDialog> {
  @override
  Widget build(BuildContext context) {
    return _NewDialog(widget: widget);
  }
}

class _NewDialog extends StatelessWidget {
  const _NewDialog({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final ErrorDialog widget;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.all(PsDimens.space8),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5)),
                    color: appColorBlack),
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: PsDimens.space4,
                    ),
                    Icon(
                      Icons.warning,
                      color: appColorWhite,
                    ),
                    const SizedBox(
                      width: PsDimens.space4,
                    ),
                    Text('WARNING',
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: appColorWhite)),
                  ],
                )),
            const SizedBox(
              height: PsDimens.space20,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: PsDimens.space16,
                  right: PsDimens.space16,
                  top: PsDimens.space8,
                  bottom: PsDimens.space8),
              child: Text(
                widget.message,
                style: Theme.of(context).textTheme.button,
              ),
            ),
            const SizedBox(
              height: PsDimens.space20,
            ),
            Divider(
              thickness: 0.5,
              height: 1,
              color: Theme.of(context).iconTheme.color,
            ),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Ok',
                style: Theme.of(context)
                    .textTheme
                    .button!
                    .copyWith(color: appColorBlack),
              ),
            )
          ],
        ));
  }
}
