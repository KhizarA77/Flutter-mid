import 'package:flutter/material.dart';

class CustomTextWidget extends StatefulWidget {
  CustomTextWidget({super.key, required this.description});

  final String description;
  bool isExpanded = false;
  @override
  State<CustomTextWidget> createState() => _CustomTextWidgetState();
}

class _CustomTextWidgetState extends State<CustomTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.description, maxLines: widget.isExpanded ? null : 2),
        Container(
          alignment: Alignment.centerRight,
                        child: SizedBox(
                          width: 90,
                          height: 25,
                          child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  widget.isExpanded = !widget.isExpanded;
                                });
                              }, child: Row(
                                children: [
                                  Text(widget.isExpanded ? 'Less' : 'More'),
                                  const Icon(Icons.arrow_downward_rounded),
                                ],
                              ),
                            ),
                        ),
        )
      ],
    );
  }
}