import 'package:covid19_tracker/Model/world_stats_model.dart';
import 'package:covid19_tracker/res/components/resueable_card.dart';
import 'package:covid19_tracker/res/components/reuseable_row.dart';
import 'package:covid19_tracker/res/components/spinner.dart';
import 'package:covid19_tracker/utils/utils.dart';
import 'package:covid19_tracker/view_model/world_states_view_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> {

  final colorList = <Color> [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    WorldStatesViewModel newWorldStatesViewModel = WorldStatesViewModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        title: const Text('COVID-19 Stats'),
      ),
      body: RefreshIndicator(
        onRefresh: newWorldStatesViewModel.fetchData,
        child: SingleChildScrollView(
            child: FutureBuilder(
              future: newWorldStatesViewModel.fetchWorldRecords(),
                builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
                if(!snapshot.hasData){
                  return const Spinner();
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: PieChart(
                              dataMap: {
                                "Total": double.parse(snapshot.data!.cases.toString()),
                                "Recovered": double.parse(snapshot.data!.recovered.toString()),
                                "Deaths": double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true
                              ),
                              chartRadius: MediaQuery.sizeOf(context).height / 5,
                              legendOptions: const LegendOptions(
                                  legendPosition: LegendPosition.left
                              ),
                              animationDuration: const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Worldwide Stats',
                            textAlign: TextAlign.start,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          children: [
                            ReuseableCard(
                                title: 'TOTAL CASES',
                                number: Utils.formatNumber(snapshot.data!.cases),
                                color: Colors.blue,
                            ),
                            ReuseableCard(
                                title: 'TOTAL DEATHS',
                                number: Utils.formatNumber(snapshot.data!.deaths),
                                color: Colors.red,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            ReuseableCard(
                                title: 'TOTAL RECOVERED',
                                number: Utils.formatNumber(snapshot.data!.recovered),
                                color: Colors.green,
                            ),
                            ReuseableCard(
                                title: 'ACTIVE CASES',
                                number: Utils.formatNumber(snapshot.data!.active),
                                color: Colors.orange,
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
              }
            ),
        ),
      ),
    );
  }
}



