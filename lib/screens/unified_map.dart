// unified_survey_wrapper.dart
import 'package:admin_app_new/screens/survey_map.dart';
import 'package:admin_app_new/screens/survey_map2.dart';
import 'package:admin_app_new/screens/survey_map4.dart';
import 'package:flutter/material.dart';


class UnifiedSurveyWrapper extends StatefulWidget {
  const UnifiedSurveyWrapper({super.key});

  @override
  State<UnifiedSurveyWrapper> createState() => _UnifiedSurveyWrapperState();
}

class _UnifiedSurveyWrapperState extends State<UnifiedSurveyWrapper> {
  int _selectedMode = 1; // 1 = SurveyMap (Per Panels), 2 = SurveyMap2 (Per Space)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:    Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.orange, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (_selectedMode != 1) {
                    setState(() {
                      _selectedMode = 1;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mode changed to Per Panels. Please create a new building."),
                        backgroundColor: Colors.orange,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _selectedMode == 1 ? Colors.orange : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text("As Per KW", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ),
              ),
              InkWell(
                onTap: () {
                  if (_selectedMode != 2) {
                    setState(() {
                      _selectedMode = 2;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mode changed to Per Space. Please create a new building."),
                        backgroundColor: Colors.orange,
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _selectedMode == 2 ? Colors.orange : Colors.transparent,
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: const Text("As Per Space", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        // actions: [
        //   Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 8),
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Colors.orange, width: 1),
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     child: Row(
        //       children: [
        //         InkWell(
        //           onTap: () {
        //             if (_selectedMode != 1) {
        //               setState(() {
        //                 _selectedMode = 1;
        //               });
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 const SnackBar(
        //                   content: Text("Mode changed to Per Panels. Please create a new building."),
        //                   backgroundColor: Colors.orange,
        //                   duration: Duration(seconds: 2),
        //                 ),
        //               );
        //             }
        //           },
        //           child: Container(
        //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //             decoration: BoxDecoration(
        //               color: _selectedMode == 1 ? Colors.orange : Colors.transparent,
        //               borderRadius: BorderRadius.circular(7),
        //             ),
        //             child: const Text("1", style: TextStyle(fontWeight: FontWeight.bold)),
        //           ),
        //         ),
        //         InkWell(
        //           onTap: () {
        //             if (_selectedMode != 2) {
        //               setState(() {
        //                 _selectedMode = 2;
        //               });
        //               ScaffoldMessenger.of(context).showSnackBar(
        //                 const SnackBar(
        //                   content: Text("Mode changed to Per Space. Please create a new building."),
        //                   backgroundColor: Colors.orange,
        //                   duration: Duration(seconds: 2),
        //                 ),
        //               );
        //             }
        //           },
        //           child: Container(
        //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        //             decoration: BoxDecoration(
        //               color: _selectedMode == 2 ? Colors.orange : Colors.transparent,
        //               borderRadius: BorderRadius.circular(7),
        //             ),
        //             child: const Text("2", style: TextStyle(fontWeight: FontWeight.bold)),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ],
      ),
      body: _selectedMode == 1
          ?  SurveyMap(key: ValueKey('mode1'))
          :  SurveyMap2(key: ValueKey('mode2')),
    );
  }
}