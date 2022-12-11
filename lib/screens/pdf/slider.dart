// import 'package:flutter/material.dart';

// class CustomPdfSlider extends StatefulWidget {
//   int maxValue;
//   int minValue;
//   Function(RangeValues) pagesRangeCallBack;

//   CustomPdfSlider(
//       {super.key,
//       required this.maxValue,
//       required this.minValue,
//       required this.pagesRangeCallBack});

//   @override
//   State<CustomPdfSlider> createState() => _CustomPdfSliderState();
// }

// class _CustomPdfSliderState extends State<CustomPdfSlider> {
//   @override
//   Widget build(BuildContext context) {
//     RangeValues pagesrange =
//         RangeValues(widget.minValue.toDouble(), widget.maxValue.toDouble());
//     return StatefulBuilder(
//       builder: (BuildContext context, state) {
//         return RangeSlider(
//       values: pagesrange,
//       min: widget.minValue.toDouble(),
//       max: widget.maxValue.toDouble(),
//       onChanged: (value) {
//         pagesrange = value;
//           widget.pagesRangeCallBack(pagesrange);
//         state((){});
//         setState(() {
          
//         });
//       });
      //  SfRangeSliderTheme(
      //               data: SfRangeSliderThemeData(
      //                   tooltipBackgroundColor: Colors.red[300],
      //               ),
      //               child:  SfRangeSlider(
      //                   min: 2.0,
      //                   max: 10.0,
      //                   interval: 1,
      //                   showTicks: true,
      //                   showLabels: true,
      //                   enableTooltip: true,
      //                   values: values,
      //                   onChanged: (SfRangeValues newValues){
      //                       setState(() {
      //                           values = newValues;
      //                       });
      //                   },
      //               ),
      //         ),
      // },
    // );
  // }
// }
    
