import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app_api/helper/data.dart';
import 'package:news_app_api/helper/widgets.dart';
import 'package:news_app_api/models/categorie_model.dart';
import 'package:news_app_api/views/categorie_news.dart';
import 'package:news_app_api/views/contact_us.dart';
import 'package:news_app_api/views/privacy_policy.dart';
import 'package:news_app_api/views/terms_conditions.dart';
import '../helper/news.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _loading;
  var newslist;

  List<CategorieModel> categories = List<CategorieModel>();

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();

    categories = getCategories();
    getNews();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30,right: 30,top: 50),
            height: MediaQuery.of(context).size.height/5,
            child: Text("WaqasNews",
            style: TextStyle(
              fontSize: 30,
              color: Theme.of(context).primaryColor
            ),),
          ),
            Divider(
              thickness: 1,
              color: Theme.of(context).primaryColor,
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
              },
              leading: Icon(Icons.home,
                color: Theme.of(context).primaryColor,),
              title: Text("Home"),
            ),
            // ListTile(
            //   leading: Icon(Icons.dashboard_customize,
            //     color: Colors.blue,),
            //   title: Text("Custom Ads"),
            // ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>PrivacyPolicy()
                ));
              },
              leading: Icon(Icons.policy,
              color: Theme.of(context).primaryColor,),
              title: Text("Privacy Policy"),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>TermsConditions()
                ));
              },
              leading: Icon(Icons.info,
                color: Theme.of(context).primaryColor,),
              title: Text("Terms & Conditions"),
            ),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>ContactUs()
                ));
              },
              leading: Icon(Icons.contact_page,
                color: Theme.of(context).primaryColor,),
              title: Text("Contact Us"),
            ),
          ],
        ),
      ),
      appBar: MyAppBar(context,_scaffoldKey),
      body: SafeArea(
        child: _loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      /// Categories
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        height: 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                imageAssetUrl: categories[index].imageAssetUrl,
                                categoryName: categories[index].categorieName,
                              );
                            }),
                      ),


                      /// News Article
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: ListView.builder(
                            itemCount: newslist.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return NewsTile(
                                imgUrl: newslist[index].urlToImage ?? "",
                                title: newslist[index].title ?? "",
                                desc: newslist[index].description ?? "",
                                content: newslist[index].content ?? "",
                                posturl: newslist[index].articleUrl ?? "",
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String imageAssetUrl, categoryName;

  CategoryCard({this.imageAssetUrl, this.categoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryNews(
            newsCategory: categoryName.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 14),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                imageUrl: imageAssetUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 60,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                color: Colors.black26
              ),
              child: Text(
                categoryName,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}
