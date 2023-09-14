import 'package:covid19_tracker/view/detail_screen.dart';
import 'package:covid19_tracker/view_model/world_states_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    WorldStatesViewModel newWorldStatesViewModel = WorldStatesViewModel();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
        title: const Text('Track Countries'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0)
                ),
                suffixIcon: searchController.text.isEmpty ? const Icon(Icons.search) :
                    GestureDetector(
                      onTap: (){
                        searchController.text = "";
                        setState(() {

                        });
                      },
                      child: const Icon(Icons.clear),
                    ),
              ),
            ),
            Expanded(
                child: FutureBuilder(
                  future: newWorldStatesViewModel.fetchCountriesRecords(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                     return ListView.builder(
                         itemCount: 4,
                         itemBuilder: (context, index){
                           return Shimmer.fromColors(
                             baseColor: Colors.grey.shade300,
                             highlightColor: Colors.grey.shade50,
                             child: Column(
                               children: [
                                 ListTile(
                                   leading: Container(height: 50, width: 50, color: Colors.white,),
                                   title: Container(height: 10, width: 80, color: Colors.white,),
                                   subtitle: Container(height: 10, width: 80, color: Colors.white,),
                                 ),
                                 Container(height: 5, width: MediaQuery.sizeOf(context).width, color: Colors.white,)
                               ],
                             ),
                           );
                         }
                     );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                          String name = snapshot.data![index]['country'];
                          if(searchController.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalRecovered: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                    )
                                    ));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text('Cases: ${snapshot.data![index]['cases']}'),
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          } else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailScreen(
                                      name: snapshot.data![index]['country'],
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalRecovered: snapshot.data![index]['recovered'],
                                      totalDeaths: snapshot.data![index]['deaths'],
                                      active: snapshot.data![index]['active'],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      critical: snapshot.data![index]['critical'],
                                    )
                                    ));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),
                                    ),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text('Cases: ${snapshot.data![index]['cases']}'),
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          } else {
                            return Container();
                          }
                          }
                      );
                    }
                  }
                ),
            ),
          ],
        ),
      ),
    );
  }
}
