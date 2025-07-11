import 'package:beautysalon/components/tab_bar.dart';
import 'package:beautysalon/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../my_drawer.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({super.key});

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeProvider>().isDarkMode;
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            "LA BELLE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Delius-Regular',
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          centerTitle: true,
          actions: [ //список виджетов, которые отображаются в конце appbar
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/cart'),
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).colorScheme.surface,
                    ),
                  )
              ],
              iconTheme: IconThemeData(
                  color: Theme.of(context).colorScheme.surface, // Указываем свойство color for humburgermenu
              ),
              ),
        body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDarkMode
                ? [Colors.indigo, Colors.deepPurple, Colors.purple.shade200]
                : [Colors.lightBlueAccent, Colors.cyan, Colors.blueAccent.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column( 
          children: [
            Expanded( 
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: MyTabBar(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}