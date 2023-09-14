import 'package:covid19_tracker/res/components/spinner.dart';
import 'package:covid19_tracker/view/detail_screen.dart';
import 'package:covid19_tracker/view_model/world_states_view_model.dart';
import 'package:flutter/material.dart';

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
        title: const Text('Countries'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'Search with country name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0)),
                suffixIcon: searchController.text.isEmpty
                    ? const Icon(Icons.search)
                    : GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          setState(() {});
                        },
                        child: const Icon(Icons.clear),
                      ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: newWorldStatesViewModel.fetchCountriesRecords(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Spinner();
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            String name = snapshot.data![index]['country'];
                            if (searchController.text.isEmpty) {
                              return Card(
                                child: ListTile(
                                  leading: Image(
                                    height: 40,
                                    width: 40,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']
                                            ['flag']),
                                  ),
                                  title: Text(
                                      snapshot.data![index]['country'],
                                    style: const TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  subtitle: Text(
                                      'Cases: ${snapshot.data![index]['cases']}'),
                                  trailing: const Icon(Icons.navigate_next),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          active: snapshot.data![index]['active'],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            } else if (name.toLowerCase().contains(
                                searchController.text.toLowerCase())) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          name: snapshot.data![index]['country'],
                                          image: snapshot.data![index]['countryInfo']['flag'],
                                          totalCases: snapshot.data![index]['cases'],
                                          totalRecovered: snapshot.data![index]['recovered'],
                                          totalDeaths: snapshot.data![index]['deaths'],
                                          active: snapshot.data![index]['active'],
                                        ),
                                      ),
                                    );
                                  },
                                  leading: Image(
                                    height: 50,
                                    width: 50,
                                    image: NetworkImage(
                                        snapshot.data![index]['countryInfo']['flag']),
                                  ),
                                  trailing: const Icon(Icons.navigate_next),
                                  title: Text(
                                      snapshot.data![index]['country'],
                                    style: const TextStyle(
                                      color: Colors.green,
                                    ),
                                  ),
                                  subtitle: Text(
                                      'Cases: ${snapshot.data![index]['cases']}'),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                      );
                    }
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
