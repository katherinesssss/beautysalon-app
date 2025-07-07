import 'dart:convert';
import 'package:beautysalon/components/procedure.dart';
import 'package:beautysalon/pages/description_service_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({super.key});

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  late Future<Map<String, List<Procedure>>> _proceduresFuture;

  @override
  void initState() {
    super.initState();
    _proceduresFuture = _loadProcedures();
  }

  Future<Map<String, List<Procedure>>> _loadProcedures() async {
    final jsonString = await rootBundle.loadString('lib/assets/procedure.json');
    final Map<String, dynamic> jsonData = json.decode(jsonString); //используем Map<String, dynamic> для сырых данных, сразу после декодирования
    final Map<String, List<Procedure>> proceduresByCategory = {}; //Map<String, List<Procedure>> по идее аналогично Map<String, dynamic>

    jsonData.forEach((category, proceduresJson) {
      proceduresByCategory[category] = (proceduresJson as List)
          .map((item) => Procedure.fromJson(item)) //это метод из Procedure.dart
          .toList();
    });

    return proceduresByCategory;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _proceduresFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final proceduresByCategory = snapshot.data!;

        return DefaultTabController(
          length: proceduresByCategory.length,
          child: Column(
            children: [
              TabBar(
                tabs: proceduresByCategory.keys
                    .map((category) => Tab(text: category))
                    .toList(),
                    labelColor: Colors.black,
              ),
              Expanded(
                child: TabBarView(
                  children: proceduresByCategory.values.map((procedures) {
                    return ListView.builder(
                      itemCount: procedures.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () {
                            Navigator.push(
                              context,
                            MaterialPageRoute(
                              builder: (context)=> DescriptionServicePage(
                              procedure: procedures[index],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            procedures[index].imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(procedures[index].title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                        subtitle: Text(procedures[index].description,style: TextStyle(color: Colors.black),),
                        trailing: Text(
                          '\$${procedures[index].price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}