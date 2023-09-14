import 'package:covid19_tracker/res/components/reuseable_row.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;
  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalDeaths,
    required this.totalCases,
    required this.totalRecovered,
    required this.active,
    required this.critical,
    required this.todayRecovered,
    required this.test,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * .06),
                        ReuseableRow(title: 'Cases', value: widget.totalCases.toString()),
                        ReuseableRow(title: 'Deaths', value: widget.totalDeaths.toString()),
                        ReuseableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                        ReuseableRow(title: 'Active', value: widget.active.toString()),
                        ReuseableRow(title: 'Critical', value: widget.critical.toString()),
                        ReuseableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                        ReuseableRow(title: 'Tests', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ]
            ),
          ],
        ),
      ),
    );
  }
}
