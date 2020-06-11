import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tamizshahr/models/personal_data.dart';
import 'package:tamizshahr/widgets/info_edit_item.dart';

import '../../models/customer.dart';
import '../../provider/app_theme.dart';
import '../../provider/customer_info.dart';
import '../../widgets/main_drawer.dart';
import 'customer_user_info_screen.dart';

class CustomerDetailInfoEditScreen extends StatefulWidget {
  static const routeName = '/customerDetailInfoEditScreen';

  @override
  _CustomerDetailInfoEditScreenState createState() =>
      _CustomerDetailInfoEditScreenState();
}

class _CustomerDetailInfoEditScreenState
    extends State<CustomerDetailInfoEditScreen> {
  final nameController = TextEditingController();
  final familyController = TextEditingController();

  final emailController = TextEditingController();
  final ostanController = TextEditingController();
  final cityController = TextEditingController();

//  final addressController = TextEditingController();
  final postCodeController = TextEditingController();

  @override
  void initState() {
    Customer customer =
        Provider.of<CustomerInfo>(context, listen: false).customer;
    nameController.text = customer.personalData.first_name;
    familyController.text = customer.personalData.last_name;

    emailController.text = customer.personalData.email;
    ostanController.text = customer.personalData.ostan;
    cityController.text = customer.personalData.city;
//    addressController.text = customer.personalData.address;
    postCodeController.text = customer.personalData.postcode;

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    familyController.dispose();
    cityController.dispose();
    ostanController.dispose();
    emailController.dispose();
    postCodeController.dispose();
//    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    var textScaleFactor = MediaQuery.of(context).textScaleFactor;
    Customer customerInfo =
        Provider.of<CustomerInfo>(context, listen: false).customer;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppTheme.appBarColor,
          iconTheme: new IconThemeData(color: AppTheme.appBarIconColor),
        ),

        drawer: Theme(
          data: Theme.of(context).copyWith(
            // Set the transparency here
            canvasColor: Colors
                .transparent, //or any other color you want. e.g Colors.blue.withOpacity(0.5)
          ),
          child: MainDrawer(),
        ), // resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (context) => Directionality(
            textDirection: TextDirection.rtl,
            child: Stack(
              children: <Widget>[
                Container(
                  color: AppTheme.bg,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'اطلاعات شخص',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontFamily: 'Iransans',
                              fontSize: textScaleFactor * 14.0,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Container(
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                InfoEditItem(
                                  title: 'نام',
                                  controller: nameController,
                                  bgColor: AppTheme.bg,
                                  iconColor: Color(0xffA67FEC),
                                  keybordType: TextInputType.text,
                                  fieldHeight: deviceHeight * 0.05,
                                ),
                                InfoEditItem(
                                  title: 'نام خانوادگی',
                                  controller: familyController,
                                  bgColor: AppTheme.bg,
                                  iconColor: Color(0xffA67FEC),
                                  keybordType: TextInputType.text,
                                  fieldHeight: deviceHeight * 0.05,
                                ),
                                InfoEditItem(
                                  title: 'ایمیل',
                                  controller: emailController,
                                  bgColor: AppTheme.bg,
                                  iconColor: Color(0xffA67FEC),
                                  keybordType: TextInputType.text,
                                  fieldHeight: deviceHeight * 0.05,
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          Text(
                            'اطلاعات تماس',
                            textAlign: TextAlign.right,
                          ),
                          Container(
                            color: AppTheme.bg,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                InfoEditItem(
                                  title: 'استان',
                                  controller: ostanController,
                                  bgColor: AppTheme.bg,
                                  iconColor: Color(0xff4392F1),
                                  keybordType: TextInputType.text,
                                  fieldHeight: deviceHeight * 0.05,
                                ),
                                InfoEditItem(
                                  title: 'شهر',
                                  controller: cityController,
                                  bgColor: AppTheme.bg,
                                  iconColor: Color(0xff4392F1),
                                  keybordType: TextInputType.text,
                                  fieldHeight: deviceHeight * 0.05,
                                ),
                                InfoEditItem(
                                  title: 'کدپستی',
                                  controller: postCodeController,
                                  bgColor: AppTheme.bg,
                                  iconColor: Color(0xff4392F1),
                                  keybordType: TextInputType.number,
                                  fieldHeight: deviceHeight * 0.05,
                                ),
//                                InfoEditItem(
//                                  title: 'آدرس',
//                                  controller: addressController,
//                                  bgColor: AppTheme.bg,
//                                  iconColor: Color(0xff4392F1),
//                                  keybordType: TextInputType.text,
//                                  fieldHeight: deviceHeight*0.1,
//                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: deviceHeight * 0.02,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 18,
                  left: 18,
                  child: FloatingActionButton(
                    onPressed: () {
                      setState(() {});
                      var _snackBarMessage = 'اطلاعات ویرایش شد.';
                      final addToCartSnackBar = SnackBar(
                        content: Text(
                          _snackBarMessage,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Iransans',
                            fontSize: textScaleFactor * 14.0,
                          ),
                        ),
                      );

                      Provider.of<CustomerInfo>(context, listen: false)
                          .firstName = nameController.text;
                      Provider.of<CustomerInfo>(context, listen: false)
                          .lastName = familyController.text;

                      Provider.of<CustomerInfo>(context, listen: false).email =
                          emailController.text;
                      Provider.of<CustomerInfo>(context, listen: false)
                          .province = ostanController.text;
                      Provider.of<CustomerInfo>(context, listen: false).city =
                          cityController.text;
//                      Provider.of<CustomerInfo>(context, listen: false).address =
//                          addressController.text;
                      Provider.of<CustomerInfo>(context, listen: false)
                          .postcode = postCodeController.text;
                      Customer customerSend = Customer(
                          personalData: PersonalData(
                        first_name: nameController.text,
                        last_name: familyController.text,
                        city: cityController.text,
                        ostan: ostanController.text,
                        email: emailController.text,
                        postcode: postCodeController.text,
                      ));

                      Provider.of<CustomerInfo>(context, listen: false)
                          .sendCustomer(customerSend)
                          .then((v) {
                        Scaffold.of(context).showSnackBar(addToCartSnackBar);
                        Navigator.of(context)
                            .popAndPushNamed(CustomerUserInfoScreen.routeName);
                      });
                    },
                    backgroundColor: AppTheme.primary,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
