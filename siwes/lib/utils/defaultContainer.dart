import 'package:flutter/material.dart';
import 'package:siwes/utils/defaultText.dart';

class DefaultContainer extends StatelessWidget {
  final String title;
  final String subtitle;
  final String route;
  final Widget? leading;
  final num div_width;
  final int? weekIndex;
  final DateTime? weekStart;
  final DateTime? weekEnd;

  const DefaultContainer({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.route,
    this.leading,
    required this.div_width,
    this.weekIndex,
    this.weekStart,
    this.weekEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

    return Container(
      width: MediaQuery.of(context).size.width / div_width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        color: Colors.white,
      ),
      child: ListTile(
        onTap: () {
          Navigator.pushNamed(context, route, arguments: {
            'week_index': weekIndex,
            'week_start': weekStart,
            'week_end': weekEnd,
          });
        },
        leading: leading,
        title: DefaultText(
          size: 15,
          text: title,
          color: Colors.green,
          weight: FontWeight.w500,
        ),
        subtitle: DefaultText(
          size: 13,
          text: subtitle,
          color: Colors.green,
          weight: FontWeight.w500,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
