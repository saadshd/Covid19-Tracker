import 'package:covid19_tracker/Model/world_stats_model.dart';
import 'package:covid19_tracker/Views/countries_screen.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:covid19_tracker/Services/stats_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color> [
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    StatsServices statsServices = StatsServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        title: const Text('COVID-19 Tracker'),
      ),
      body: SingleChildScrollView(
          child: FutureBuilder(
            future: statsServices.fetchWorldStatsRecords(),
              builder: (context,AsyncSnapshot<WorldStatsModel> snapshot){
              if(!snapshot.hasData){
                return Expanded(
                  flex: 1,
                  child: SpinKitFadingCircle(
                    color: Colors.white,
                    size: 50.0,
                    controller: _controller,
                  ),
                );
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
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text('Worldwide Stats',
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),),
                      ),
                      Card(
                        child: Column(
                          children: [
                            ReuseableRow(title: 'Total', value: snapshot.data!.cases.toString()),
                            ReuseableRow(title: 'Deaths', value: snapshot.data!.deaths.toString()),
                            ReuseableRow(title: 'Recovered', value: snapshot.data!.recovered.toString()),
                            ReuseableRow(title: 'Active', value: snapshot.data!.active.toString()),
                            ReuseableRow(title: 'Critical', value: snapshot.data!.critical.toString()),
                            ReuseableRow(title: 'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                            ReuseableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                            ReuseableRow(title: 'Today Cases', value: snapshot.data!.todayCases.toString()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesScreen()));
                          },
                          child: const Text('Track Countries')),
                    ],
                  ),
                );
              }
              }
          )),
    );
  }
}

class ReuseableRow extends StatelessWidget {
  String title, value;
  ReuseableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10,10,10,5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5,),
          const Divider()
        ],
      ),
    );
  }
}

