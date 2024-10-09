import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mid_practice/TextWidget.dart';
import 'package:mid_practice/launch_model.dart';
import 'dart:math';

class custom_mission_list extends StatefulWidget {
  const custom_mission_list({super.key});

  @override
  State<custom_mission_list> createState() => _custom_mission_listState();
}

class _custom_mission_listState extends State<custom_mission_list> {
  Future<List<Launch>> fetchMissions() async {
    final response = await http.get(Uri.parse('https://api.spacexdata.com/v3/missions'));
    if (response.statusCode == 200) {
      final List jsonData = json.decode(response.body);

      return jsonData.map((mission) => Launch.fromJson(mission)).toList();
      
    } else {
      throw Exception('Failed to load missions');
    }
  }

  List<bool> isExpandedList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Space Missions',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 136, 248),
      ),
      body: FutureBuilder<List<Launch>>(
        future: fetchMissions(),
        builder: (context, snap) {
          if (snap.hasData) {
            List<Launch> missions = snap.data as List<Launch>;
            if (isExpandedList.isEmpty) {
              isExpandedList = List<bool>.filled(missions.length, false);
            }
            return ListView.separated(
              itemCount: missions.length,
              separatorBuilder: (context, index) => const Divider(thickness: 0.5,),
              padding: const EdgeInsets.all(15),
              itemBuilder: (context, index) {
                bool isExpanded = isExpandedList[index];
                return ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: const Color.fromARGB(255, 215, 215, 215), width: 2),
                  ),
                  contentPadding: const EdgeInsets.all(20),
                  title: Text(missions[index].missionName ?? 'Error fetching, please reload'),
                  subtitle: Column(
                    children: [
                      CustomTextWidget(description: missions[index].description ?? 'Error fetching, please reload'),
                      Align(
                        alignment: Alignment.center,
                        child: Wrap(
                        spacing: 2,
                        runSpacing: 2,
                        children: missions[index].payloadIds!.map((payloadId) => Chip(label: Text(payloadId), backgroundColor: Color.fromARGB(Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), Random().nextInt(255)))).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
