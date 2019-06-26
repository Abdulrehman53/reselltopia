import 'package:flutter/material.dart';
import 'package:reselltopia/HomeWidgets/slidebar.dart';
import 'package:reselltopia/utils/main_grid_list.dart';
import 'package:reselltopia/utils/main_page_grid.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.grey.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  onChanged: (value) {
                    print(value);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SlideBar(),
                          ),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 180.0,
                              child: CategoriesList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      delegate: SliverChildListDelegate(
                        [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MainGridList(
                              searchText: "",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /*Padding(
              padding: const EdgeInsets.all(8.0),
              child: SlideBar(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 180.0,
                child: CategoriesList(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MainGridList(
                  searchText: "",
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
