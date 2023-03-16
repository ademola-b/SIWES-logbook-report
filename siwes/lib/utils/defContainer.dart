import 'package:flutter/material.dart';
import 'package:siwes/utils/defaultText.dart';

class DefContainer extends StatelessWidget {
  final String title;
  final String route;
  final Widget? leading;

  const DefContainer({
    Key? key,
    required this.title,
    // required this.subtitle,
    required this.route,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, route);
        },
        leading: leading,
        title: DefaultText(
          size: 15,
          text: title,
          color: Colors.green,
          weight: FontWeight.w500,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
