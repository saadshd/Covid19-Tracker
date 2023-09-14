import 'package:covid19_tracker/res/components/resueable_card.dart';
import 'package:covid19_tracker/res/components/reuseable_row.dart';
import 'package:covid19_tracker/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class DetailScreen extends StatefulWidget {
  String name, image;
  int totalCases, totalDeaths, totalRecovered, active;

  DetailScreen({
    super.key,
    required this.name,
    required this.image,
    required this.totalDeaths,
    required this.totalCases,
    required this.totalRecovered,
    required this.active,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final colorList = <Color>[
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        title: Row(
          children: [
            Image(
              height: 50,
              width: 50,
              image: NetworkImage(widget.image),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(widget.name),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: PieChart(
                  dataMap: {
                    "Total": double.parse(widget.totalCases.toString()),
                    "Recovered": double.parse(widget.totalRecovered.toString()),
                    "Deaths": double.parse(widget.totalDeaths.toString()),
                  },
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValuesInPercentage: true),
                  chartRadius: MediaQuery.sizeOf(context).height / 5,
                  legendOptions:
                      const LegendOptions(legendPosition: LegendPosition.left),
                  animationDuration: const Duration(milliseconds: 1200),
                  chartType: ChartType.ring,
                  colorList: colorList,
                ),
              ),
            ),
            Row(
              children: [
                ReuseableCard(
                  title: 'TOTAL CASES',
                  number: Utils.formatNumber(widget.totalCases),
                  color: Colors.blue,
                ),
                ReuseableCard(
                  title: 'TOTAL DEATHS',
                  number: Utils.formatNumber(widget.totalDeaths),
                  color: Colors.red,
                ),
              ],
            ),
            Row(
              children: [
                ReuseableCard(
                  title: 'TOTAL RECOVERED',
                  number: Utils.formatNumber(widget.totalRecovered),
                  color: Colors.green,
                ),
                ReuseableCard(
                  title: 'ACTIVE CASES',
                  number: Utils.formatNumber(widget.active),
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
