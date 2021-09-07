import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:movie_app/core/constants/asset_constants.dart';
import 'package:movie_app/core/constants/color_constants.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/constants/string_constants.dart';
import 'package:movie_app/core/models/movie_items.dart';
import 'package:movie_app/core/viewmodels/views/login/home_viewmodel.dart';
import 'package:movie_app/ui/views/movielist/movie_detail_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int counter = 0;
  double _rating = 3;
  int _selectedDestination = 0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences? prefs;
  HomeViewModel? model;

  @override
  void initState() {
    initPrefs();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      model = Provider.of<HomeViewModel>(context, listen: false);
      model!.getPopularMovies();
      model!.getTopRatedMovies();
      model!.getUpcomingMovies();
    });
    super.initState();
  }

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    print('HomeView: build()');
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(ColorConstants.saphire_blue),
      drawer: _buildDrawer(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    _buildHeaderSection(),
                    //_buildSearchBar(),
                   // SizedBox(height: 30),
                    buildCategoriesSection(),
                    // SizedBox(height: 20),
                    // buildListCategories(),
                    SizedBox(height: 30),
                    _buildPopularTitle(),
                    SizedBox(height: 20),
                    _buildPopularSection(),
                    SizedBox(height: 20),
                    _buildUpcomingMoviesTitle(),
                    SizedBox(height: 20),
                    _buildUpcomingMoviesSection(),
                    SizedBox(height: 20),
                    _buildTopRatedMoviesTitle(),
                    SizedBox(height: 20),
                    _buildTopRatedMoviesSection(),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 40.0),
      //color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
          GestureDetector(
            onTap: () {

            },
            child: Text(
              StringConstants.accountHolderName,
              style: TextStyle(
                  fontSize: 25,
                  //fontWeight: FontWeight.bold,
                  color: Color(ColorConstants.pure_white)),
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  AssetConstant.profileIcon,
                  height: 50.0,
                  width: 50.0,
                ),
              ),
              Positioned(
                // draw a red marble
                top: 0.1,
                right: 0.0,
                child: new Icon(Icons.brightness_1,
                    size: 15, color: Color(ColorConstants.redAssents)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 60,
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Text("HeroMode",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25
      ),),

    );
  }


  Widget buildCategoriesSection() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text("Hero Mode",
              style: TextStyle(
                  color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
          ),
          Switch(
            value: model!=null && model!.isHeroModeEnable,
            onChanged:(value){
              print("value:$value");
              model!.isHeroModeEnable=value;
            },
            activeTrackColor: Color(ColorConstants.light_blue),
           activeColor: Color(ColorConstants.pure_white),
          ),

        ],
      ),
    );

  }

  Widget buildListCategories() {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 20),
      child: Container(
        child: ListView.builder(
          itemCount:Constants.categoryList.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, position) {
            return _buildCategoryItem(Constants.categoryList[position]);
          },
        ),
      ),
    );
  }

  Widget _buildCategoryItem(category) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blueGrey.withOpacity(0.3),
      ),
      margin: EdgeInsets.only(right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 30,
               height:30,
             // color:Colors.red,
              child: Image.asset(category['img'],
              fit: BoxFit.cover,),
          ),

          SizedBox(height: 8),
          Text(
            category['name'],
            style: TextStyle(
                color: Color(ColorConstants.pure_white), fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularTitle() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConstants.popular,
            style: TextStyle(
              color: Color(ColorConstants.pure_white),
              fontSize: 15,
            ),
          ),
          Text(
            StringConstants.see_more,
            style: TextStyle(
              color: Color(ColorConstants.dark_grey),
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPopularSection() {
    return Container(
      height: 300,
      padding: EdgeInsets.only(left: 20, top: 5),
      width: MediaQuery.of(context).size.width,
      child: model != null && model!.isPopularLoading
          ? Center(child: CircularProgressIndicator())
          : Provider.value(
              value: Provider.of<HomeViewModel>(context),
              child: Consumer(
                builder: (context, value, child) => Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model != null && model!.popularMovies != null
                        ? model!.popularMovies!.results!.length : 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _buildPopularItem(
                          index, model!.popularMovies!.results![index]);
                    },
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildPopularItem(int index, Results result) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailView(movieDataModel: result)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: 150,
            margin: EdgeInsets.only(right: 16),
            child: HeroMode(
              child: Hero(
                  tag: '${result.id}',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    Constants.IMAGE_BASE_URL +
                        Constants.IMAGE_SIZE_1 +
                        '${result.posterPath}',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              //enabled: true,
              enabled:model!.isHeroModeEnable,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            child: Text(
              result.title!,
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            child: GFRating(
              value: _rating,
              color: Color(ColorConstants.orange),
              size: 16,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUpcomingMoviesTitle() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConstants.upcoming,
            style: TextStyle(
              color: Color(ColorConstants.pure_white),
              fontSize: 15,
            ),
          ),
          Text(
            StringConstants.see_more,
            style: TextStyle(
              color: Color(ColorConstants.dark_grey),
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUpcomingMoviesSection() {
    return Container(
        height: 150,
        padding: EdgeInsets.only(left: 20, top: 5),
        width: MediaQuery.of(context).size.width,
        child: model != null && model!.isUpcomingLoading
            ? Center(child: CircularProgressIndicator())
            : Provider.value(
                value: Provider.of<HomeViewModel>(context),
                child: Consumer(
                  builder: (context, value, child) => Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: model != null && model!.upcomingMovies != null
                          ? model!.upcomingMovies!.results!.length
                          : 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return _buildUpcomingMoviesItem(
                            index, model!.upcomingMovies!.results![index]);
                      },
                    ),
                  ),
                ),
              ));
  }

  Widget _buildUpcomingMoviesItem(int position, Results result) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailView(movieDataModel: result)),
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            Constants.IMAGE_BASE_URL +
                Constants.IMAGE_SIZE_1 +
                '${result.posterPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildTopRatedMoviesTitle() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            StringConstants.topRated,
            style: TextStyle(
              color: Color(ColorConstants.pure_white),
              fontSize: 15,
            ),
          ),
          Text(
            StringConstants.see_more,
            style: TextStyle(
              color: Color(ColorConstants.dark_grey),
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopRatedMoviesSection() {
    return Container(
      height: 150,
      padding: EdgeInsets.only(left: 20, top: 5),
      width: MediaQuery.of(context).size.width,
      child: model != null && model!.isTopRatedLoading
          ? Center(child: CircularProgressIndicator())
          : Provider.value(
              value: Provider.of<HomeViewModel>(context),
              child: Consumer(
                builder: (context, value, child) => Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: model != null && model!.topRatedMovies != null
                        ? model!.topRatedMovies!.results!.length
                        : 0,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _buildTopRatedMoviesItem(
                          index, model!.topRatedMovies!.results![index]);
                    },
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildTopRatedMoviesItem(int position, Results result) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MovieDetailView(movieDataModel: result)),
        );
      },
      child: Container(
        width: 150,
        margin: EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.0),
          child: Image.network(
            Constants.IMAGE_BASE_URL +
                Constants.IMAGE_SIZE_1 +
                '${result.posterPath}',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  selectDestinationHome(int i) {
    _selectedDestination = i;
  }

  selectDestinationLogout(int i) async {
    setState(() async {
      _selectedDestination = i;
      Navigator.pop(context);
    });
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: Container(
        color: Color(ColorConstants.saphire_blue),
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Neelu Modanwal"),
              accountEmail: Text("neelu26modanwal@gmail.com"),
              decoration: BoxDecoration(
                color: Color(ColorConstants.saphire_blue),
              ),
              currentAccountPicture: ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  AssetConstant.profileIcon,
                  height: 50.0,
                  width: 50.0,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              selected: _selectedDestination == 0,
              onTap: () => selectDestinationHome(0),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white),
                      ),
                      selected: _selectedDestination == 1,
                      onTap: ()  {

                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
