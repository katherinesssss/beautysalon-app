import 'package:flutter/material.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(top: 80),
            child: IconButton(icon:Icon(Icons.lock_open,
              size: 60,
              color: Theme.of(context).colorScheme.surface,
            ),
            onPressed: (){},
            ),
          ),

          Padding(padding: EdgeInsets.all(8),
            child: Divider(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
              padding: EdgeInsets.all(30),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed('/home');
                        },
                        child: Text(
                          "HOME",
                          style: TextStyle(
                            fontFamily: 'Delius-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed('/home');
                        },
                        icon: Icon(Icons.home),
                        color: Theme.of(context).colorScheme.surface,
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).pushNamed('/settings');
                        },
                        child: Text(
                          "SETTINGS",
                          style: TextStyle(
                            fontFamily: 'Delius-Regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true).pushNamed('/settings');
                        },
                        icon: Icon(Icons.settings),
                        color: Theme.of(context).colorScheme.surface,
                      )
                      ]
                    ),
                  SizedBox(height: 250,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).pushNamed('/logout');
                          },
                          child: Text(
                            "LOG OUT",
                            style: TextStyle(
                              fontFamily: 'Delius-Regular',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.surface,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context, rootNavigator: true).pushNamed('/logout');
                          },
                          icon: Icon(Icons.logout),
                          color: Theme.of(context).colorScheme.surface,
                        )
                      ]
                  ),
                ],
              ),
            ),
          ),
          ],
      ),
    );
  }
}
