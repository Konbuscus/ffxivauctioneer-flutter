import 'package:bezier_chart/bezier_chart.dart';
import 'package:flutter/material.dart';
import 'package:FFXIVAuctioneer/models/Category.dart';
import 'package:FFXIVAuctioneer/models/FFXIVItem.dart';
import 'package:FFXIVAuctioneer/models/ItemInfos.dart';
import 'package:FFXIVAuctioneer/services/xivapi.dart';
import 'package:random_color/random_color.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  final darkModeColor = new Color(0x121212);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: "FFXIVAuctioneer",
      home: FFXIVAuctioneerManagements(),
      theme: ThemeData(scaffoldBackgroundColor: darkModeColor),
    );
  }
}

class FFXIVAuctioneerManagementstates extends State<FFXIVAuctioneerManagements> {
  //Adding build()static var ffxivItems;
  final Set<dynamic> savedItems = Set<dynamic>();
  final ranLength = const TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
      future: getCategories(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new Center(child:new CircularProgressIndicator());
          default:
            if (snapshot.hasError)
              return new Text('Error: ${snapshot.error}');
            else
              return buildListView(context, snapshot);
        }
      },
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Categories List"),
        backgroundColor: Colors.black45,
        centerTitle: true,

      ),
      body: futureBuilder,

    );

  }

  Widget buildListView(BuildContext context, AsyncSnapshot snapshot) {
    List<Category> list = snapshot.data;
    return new ListView.builder(
      
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        var currentItem = list.elementAt(index);
        // final bool alreadyBeenSaved =
        //     savedItems.contains(list.elementAt(index));
        return new Column(
          
          children: <Widget>[
            new ListTile(
                title: new Text(currentItem.name, style:  TextStyle(color: Colors.white)),
                
                trailing:
                    new Image.network("https://xivapi.com/" + currentItem.icon),
                onTap: () {
                  //Open new navigator
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(builder: (BuildContext context) {
                      //BuildingListTiles
                      //We need category ID to perform request
                      var futureXIVBuilder = FutureBuilder<List<FFXIVItem>>(
                          future: GetItemsByCategoryID(currentItem.iD),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return new Center(child:new CircularProgressIndicator());
                              default:
                                if (snapshot.hasError)
                                  return new Text('Error: ${snapshot.error}');
                                else
                                  return buildListViewItem(context, snapshot);
                            }
                          });
                      return Scaffold(
                        appBar: AppBar(
                          title: Text('Items of category :' +currentItem.name),
                          backgroundColor: Colors.black45,
                        ),
                        body: futureXIVBuilder,
                      );
                    }),

                    //setState(() {
                    // if (alreadyBeenSaved) {
                    //   savedItems.remove(list.elementAt(index));
                    // } else {
                    //   savedItems.add(list.elementAt(index));
                    // }
                    // });
                  );
                }),
            new Divider(
              height: 2.0,
            ),
          ],
        );
      },
    );
  }

  Widget buildListViewItem(BuildContext context, AsyncSnapshot snapshot) {

    List<FFXIVItem> listItem = snapshot.data;

    return new ListView.builder(
      itemCount: listItem.length,
      itemBuilder: (BuildContext context, int index){

          var currentItem = listItem.elementAt(index);

          return new Column(
            children: <Widget>[
              new ListTile(
                title: new Text(currentItem.name, style: TextStyle(color: Colors.white),),
                trailing: new Image.network("https://xivapi.com/" + currentItem.icon),
                onTap: (){

                  //push to the query and then the chart
                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (BuildContext context){
                    var futureItemInfos = FutureBuilder<List<ItemInfos>>(

                      future: GetIemsInfos(currentItem.iD),
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                        switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return new Center(child:new CircularProgressIndicator());
                              default:
                                if (snapshot.hasError)
                                  return new Text('Error: ${snapshot.error}');
                                else
                                  return buildChart(context, snapshot);
                            }
                      },

                    );

                  return Scaffold(
                        appBar: AppBar(
                          title: Text('History prices of item :' + currentItem.name),
                          backgroundColor: Colors.black45,
                        ),
                        body: futureItemInfos,
                      );
                  }));
                },
              ),
              new Divider(
              height: 2.0,
            )
            ,
            ],
          );

      },


    );


  }
  Widget buildChart (BuildContext context, AsyncSnapshot snapshot){
    
    final darkModeColor = new Color(0x121212);

    //Our precious data
     List<ItemInfos> infos = snapshot.data;
     List<double> timestamp = <double>[];
    //Color series randomizer
    RandomColor _randomColor = RandomColor();
    
    //Prices data
    List<BezierLine> bzList = <BezierLine>[];

    for(int i = 0; i < infos.length; i++)
    {
      var data = <DataPoint<DateTime>>[];
      for(int y = 0; y < infos[i].history.length;y++)
      {
        timestamp.add(infos[i].history[y].added.toDouble());
        var currDate = new DateTime.fromMillisecondsSinceEpoch(infos[i].history[y].added * 1000).toUtc();
        data.add(DataPoint<DateTime>(value: infos[i].history[y].priceTotal.toDouble(), xAxis: currDate));
      }
      //For each infos we create a data serie
      BezierLine bz = new BezierLine(label: infos[i].currServer,
      lineColor: _randomColor.randomColor(), data: data);
      
      bzList.add(bz);
    }
    timestamp.sort((a, b) => a.compareTo(b));
    var minDate = new DateTime.fromMillisecondsSinceEpoch(timestamp.first.toInt() * 1000).toUtc();
    var maxDate = new DateTime.fromMillisecondsSinceEpoch(timestamp.last.toInt() * 1000).toUtc();
    //BuildingChart 
    return Center(
    child: Container(
      color: Colors.black45,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: BezierChart(
        bezierChartScale: BezierChartScale.WEEKLY,
        fromDate: minDate,
        toDate: maxDate,
        series: bzList,
        config: BezierChartConfig(
          verticalIndicatorStrokeWidth: 2.0,
          verticalIndicatorColor: Colors.black12,
          showVerticalIndicator: true,
          contentWidth: MediaQuery.of(context).size.width ,
          backgroundColor: darkModeColor,
        ),
      ),
    ),
  );

  }
  void pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = savedItems.map((dynamic wp) {
        return ListTile(
          title: Text(wp, style: ranLength),
        );
      });

      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text('Fav items'),
        ),
        body: ListView(children: divided),
      );
    }));
  }

  Future<List<Category>> getCategories() async {
    return XivApi.GetCategoriesList();
  }

  Future<List<FFXIVItem>> GetItemsByCategoryID(int id) {
    return XivApi.GetItemsByCategoryID(id);
  }

  Future<List<ItemInfos>> GetIemsInfos(int id){
    return XivApi.GetItemInfos(id);
  }
}

class FFXIVAuctioneerManagements extends StatefulWidget {
  @override
  FFXIVAuctioneerManagementstates createState() => FFXIVAuctioneerManagementstates();
}
