import 'dart:convert';
import 'package:demo_project/src/Strip/creadit_card_bloc.dart';
import 'package:demo_project/src/Strip/newCart.dart';
import 'package:demo_project/src/Strip/provider/apply_charges.dart';
import 'package:demo_project/src/Strip/provider/create_customer.dart';
import 'package:demo_project/src/Strip/provider/get_token_api.dart';
import 'package:demo_project/src/global/global.dart';
import 'package:demo_project/src/models/generalsetting_model.dart';
import 'package:demo_project/src/models/serviceDetail_model.dart';
import 'package:demo_project/src/screens/layout/bookingSuccess.dart';
import 'package:demo_project/src/screens/layout/serviceDetail.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:place_picker/entities/location_result.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class CheckOutService extends StatefulWidget {
  ServiceDetailModel? restaurants;
  String? selectedTypePrice;
  String? pickedLocation;
  String? dateValue;
  String? timeValue;
  String? notes;
  CheckOutService(
      {this.restaurants,
      this.selectedTypePrice,
      this.pickedLocation,
      this.dateValue,
      this.timeValue,
      this.notes});
  @override
  _GetCartState createState() => new _GetCartState();
}

class _GetCartState extends State<CheckOutService> {
  bool isPayment = false;
  String _pickedLocation = '';
  bool isLoading = false;

  //Razorpay//>>>>>>>>>>>>>>>>

  Razorpay? _razorpay;
  String orderid = '';

  // String paySELECTED;
  TextEditingController? _cardNumberController;
  TextEditingController? _expiryDateController;
  // TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController? _cvvCodeController;
  var maskFormatterNumber;
  var maskFormatterExpiryDate;
  var maskFormatterCvv;
  bool cvv = false;
  TextEditingController addressController = TextEditingController();

  String cardNumber = "";
  String cardMonthyear = "";
  String cardCvvNumber = "";

  GeneralSettingModel? generalSettingModel;

  @override
  void initState() {
    isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : _getgeneralSetting();

    addressController.text = widget.pickedLocation!;
    _pickedLocation = widget.pickedLocation!;
    maskFormatterNumber = MaskTextInputFormatter(mask: '#### #### #### ####');
    maskFormatterExpiryDate = MaskTextInputFormatter(mask: '##/##');
    maskFormatterCvv = MaskTextInputFormatter(mask: '###');
    super.initState();
  }

  _getgeneralSetting() async {
    setState(() {
      isLoading = true;
    });

    var uri = Uri.parse('${baseUrl()}general_setting');
    var request = new http.MultipartRequest("GET", uri);
    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);
    var response = await request.send();
    print(response.statusCode);
    String responseData = await response.stream.transform(utf8.decoder).join();
    var userData = json.decode(responseData);
    setState(() {
      generalSettingModel = GeneralSettingModel.fromJson(userData);

      //  for(var i=0; i<=allProductsModel.restaurants.length; i++){
      if (generalSettingModel!.status == 1) {
        setState(() {
          stripSecret = generalSettingModel!.setting!.sSecretKey!;
          stripPublic = generalSettingModel!.setting!.sPublicKey!;
          rozSecret = generalSettingModel!.setting!.rSecretKey!;
          rozPublic = generalSettingModel!.setting!.rPublicKey!;
        });
      }
      isLoading = false;
    });

    print("----------");
    print(stripSecret);
    print("----------");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: appColorWhite,
        appBar: AppBar(
          backgroundColor: appColorWhite,
          elevation: 2,
          title: Text(
            "Checkout",
            style: TextStyle(
                fontSize: 20,
                color: appColorBlack,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: appColorBlack,
              )),
          actions: [],
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _itmeList(),
                        Container(height: 15),
                        locationWidget(),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ),
                        paymentOption()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            isPayment == true
                ? Center(
                    child: loader(context),
                  )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _itmeList() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ServiceDetailScreen(
                    widget.restaurants!.restaurant!.id!,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Container(
              height: 130,
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        0.0,
                      ),
                      child: Image.network(
                        widget.restaurants!.restaurant!.serviceImage![0],
                        height: 90,
                        width: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restaurants!.restaurant!.serviceName!,
                            style: TextStyle(
                                fontSize: 16,
                                color: appColorBlack,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Container(height: 5),
                          Text(
                            "\$${widget.selectedTypePrice}",
                            style: TextStyle(
                                color: appColorBlack,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Container(height: 5),
                          // Text(
                          //   "Size : ${widget.selectedTypeSize}",
                          //   style: TextStyle(
                          //       color: Colors.black45,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey[300],
            )
          ],
        ),
      ),
    );
  }

  Widget locationWidget() {
    return Padding(
        padding:
            const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 10),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height: 45,
              width: double.infinity,
              // ignore: deprecated_member_use
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: Colors.black)),
                color: Colors.white,
                textColor: Colors.black,
                // padding: EdgeInsets.all(0.0),
                onPressed: () {
                  _getLocation();
                },
                child: Text(
                  _pickedLocation.length > 0
                      ? "Selected Address:"
                      : "+ Select Address",
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10),
            _pickedLocation.length > 0
                ? Card(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, bottom: 15, top: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.location_city, size: 30),
                          Container(width: 10),
                          Expanded(
                            child: Text(
                              _pickedLocation,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: appColorBlack,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          _pickedLocation.length > 0
                              ? IconButton(
                                  onPressed: () {
                                    _editAddress(context);
                                  },
                                  icon: Icon(Icons.edit, size: 20),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }

  _editAddress(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Address'),
            content: TextField(
              controller: addressController,
              textInputAction: TextInputAction.go,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(hintText: "Enter your address"),
            ),
            actions: <Widget>[
              TextButton(
                child: new Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new TextButton(
                child: new Text('Submit'),
                onPressed: () {
                  if (addressController.text != '') {
                    setState(() {
                      _pickedLocation = addressController.text;
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  _getLocation() async {
    LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PlacePicker(
              "AIzaSyCqQW9tN814NYD_MdsLIb35HRY65hHomco",
            )));
    setState(() {
      _pickedLocation = result.formattedAddress.toString();
    });
  }

  Widget paymentOption() {
    var dateFormate =
        DateFormat("dd/MM/yyyy").format(DateTime.parse(widget.dateValue!));
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            'Booking Detail',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Column(
          //   children: [
          //     Card(
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Column(
          //           children: [
          //             Row(
          //               children: [
          //                 Icon(Icons.date_range),
          //                 SizedBox(width: 5.0),
          //                 Text(
          //                   dateFormate,
          //                   style: TextStyle(
          //                       color: appColorBlack,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 14),
          //                 ),
          //               ],
          //             ),
          //             Divider(),
          //             Row(
          //               children: [
          //                 Icon(Icons.watch_later_outlined),
          //                 SizedBox(width: 5.0),
          //                 Text(
          //                   widget.timeValue!,
          //                   style: TextStyle(
          //                       color: appColorBlack,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 14),
          //                 ),
          //               ],
          //             ),
          //             Divider(),
          //             SizedBox(height: 5),
          //             Row(
          //               children: [
          //                 Text(
          //                   "Total : \$${widget.selectedTypePrice}",
          //                   style: TextStyle(
          //                       color: appColorBlack,
          //                       fontWeight: FontWeight.bold,
          //                       fontSize: 14),
          //                 ),
          //               ],
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          Container(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                        ),
                        Text(
                          dateFormate,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time',
                        ),
                        Text(
                          widget.timeValue!,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount',
                        ),
                        Text(
                          "\$ " + widget.selectedTypePrice!,
                          style: TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            title: Text(
              "Payment options",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            subtitle: Text(
              "Select your preferred payment mode",
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
            ),
          ),
          Card(
            child: ExpansionTile(
              tilePadding: const EdgeInsets.only(left: 10, right: 5),
              leading: Icon(Icons.payment, color: Colors.black),
              title: Text(
                "Cradit/Debit Card (STRIPE)",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              ),
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      // border: Border.all(),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(child: _cardNumber()),
                              _creditCradWidget(),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(child: _expiryDate()),
                            Expanded(child: _cvvNumber()),
                          ],
                        ),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: SizedBox(
                      height: 45,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            onPrimary: Colors.white,
                            onSurface: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            padding: EdgeInsets.all(8.0),
                            textStyle: TextStyle(color: Colors.white)),
                        onPressed: () {
                          setState(() {
                            FocusScope.of(context).unfocus();
                          });
                          if (_pickedLocation.length > 0) {
                            String number =
                                maskFormatterNumber.getMaskedText().toString();
                            String cvv =
                                maskFormatterCvv.getMaskedText().toString();
                            String month = maskFormatterExpiryDate
                                .getMaskedText()
                                .toString()
                                .split("/")[0];
                            String year = maskFormatterExpiryDate
                                .getMaskedText()
                                .toString()
                                .split("/")[1];

                            setState(() {
                              isPayment = true;
                            });

                            print('$number, $month, $year, $cvv');

                            getCardToken
                                .getCardToken(
                                    number, month, year, cvv, "test", context)
                                .then((onValue) {
                              print(onValue["id"]);
                              createCutomer
                                  .createCutomer(onValue["id"], "test", context)
                                  .then((cust) {
                                print(cust["id"]);
                                applyCharges
                                    .applyCharges(cust["id"], context,
                                        widget.selectedTypePrice.toString())
                                    .then((value) {
                                  bookApiCall(value["balance_transaction"]);

                                  setState(() {
                                    isPayment = false;
                                  });
                                });
                              });
                            });
                          } else {
                            // Toast.show("Select Address", context,
                            //     duration: Toast.LENGTH_SHORT,
                            //     gravity: Toast.BOTTOM);
                            Fluttertoast.showToast(
                                msg: "Select Address",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.black,
                                fontSize: 13.0);
                          }
                        },
                        child: Text(
                          "Pay",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            // fontFamily: ""
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                if (_pickedLocation.length > 0) {
                  checkOut();
                } else {
                  // Toast.show("Select Address", context,
                  //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                  Fluttertoast.showToast(
                      msg: "Select Address",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.grey.shade200,
                      textColor: Colors.black,
                      fontSize: 13.0);
                }
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(Icons.payment, color: Colors.black),
              title: Text(
                "Razorpay",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                if (_pickedLocation.length > 0) {
                  bookApiCall('');
                } else {
                  Fluttertoast.showToast(
                      msg: "Select Address",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT);
                }
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              leading: Icon(Icons.attach_money_outlined, color: Colors.black),
              title: Text(
                "Cash On Delivery",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _creditCradWidget() {
    return StreamBuilder<String>(
        stream: creditCardBloc.numberStream,
        initialData: "",
        builder: (context, number) {
          return StreamBuilder<String>(
              stream: creditCardBloc.expiryDateStream,
              initialData: "",
              builder: (context, expiryDate) {
                return StreamBuilder<String>(
                    stream: creditCardBloc.nameStream,
                    initialData: "",
                    builder: (context, name) {
                      return StreamBuilder<String>(
                          stream: creditCardBloc.cvvStream,
                          initialData: "",
                          builder: (context, cvvNumber) {
                            return CreditCardWidget1(
                              cardBgColor: Colors.white,
                              cardNumber: number.data,
                              expiryDate: expiryDate.data,
                              cardHolderName: name.data,
                              cvvCode: cvvNumber.data,
                              showBackView:
                                  cvv, //true when you want to show cvv(back) view
                            );
                          });
                    });
              });
        });
  }

  Widget _cardNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: ingenieriaTextfield(
        controller: _cardNumberController,
        inputFormatters: [maskFormatterNumber],
        onChanged: (text) {
          cardNumber = text;
          creditCardBloc.numberSink(text);
        },
        onTap: () {
          setState(() {
            cvv = false;
          });
        },
        hintText: "1234 1234 1234 1234",
        keyboardType: TextInputType.number,
        // prefixIcon: Icon(Icons.credit_card, color: appGreen),
      ),
    );
  }

  Widget _expiryDate() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 0.0),
      child: ingenieriaTextfield(
        controller: _expiryDateController,
        inputFormatters: [maskFormatterExpiryDate],
        onChanged: (text) {
          cardMonthyear = text;
          creditCardBloc.expiryDateSink(text);
        },
        onTap: () {
          setState(() {
            cvv = false;
          });
        },
        hintText: "MM / YY",
        keyboardType: TextInputType.number,
        //  prefixIcon: Icon(Icons.date_range, color: appGreen),
      ),
    );
  }

  Widget _cvvNumber() {
    return Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 15.0),
      child: ingenieriaTextfield(
        controller: _cvvCodeController,
        onChanged: (text) {
          cardCvvNumber = text;
          creditCardBloc.cvvSink(text);
        },
        onTap: () {
          setState(() {
            cvv = true;
          });
        },
        hintText: "CVV",
        keyboardType: TextInputType.number,
        inputFormatters: [maskFormatterCvv],
        //  prefixIcon: Icon(Icons.dialpad, color: appGreen),
      ),
    );
  }

  checkOut() {
    generateOrderId(
        rozPublic, rozSecret, int.parse(widget.selectedTypePrice!) * 100);

    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    if (_razorpay != null) _razorpay!.clear();
  }

  Future<String> generateOrderId(String key, String secret, int amount) async {
    setState(() {
      isPayment = true;
    });
    var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };

    var data =
        '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!

    var res = await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
        headers: headers, body: data);
    //if (res.statusCode != 200) throw Exception('http.post error: statusCode= ${res.statusCode}');
    print('ORDER ID response => ${res.body}');
    orderid = json.decode(res.body)['id'].toString();
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + orderid);
    if (orderid.length > 0) {
      openCheckout();
    } else {
      setState(() {
        isPayment = false;
      });
    }

    return json.decode(res.body)['id'].toString();
  }

  //rzp_live_UMrVDdnJjTUhcc
//rzp_test_rcbv2RXtgmOyTf
  void openCheckout() async {
    var options = {
      'key': rozPublic,
      'amount': int.parse(widget.selectedTypePrice!) * 100,
      'currency': 'INR',
      'name': 'Ezshield',
      'description': '',
      // 'order_id': orderid,
      'prefill': {'contact': userMobile, 'email': userEmail},
      // 'external': {
      //   'wallets': ['paytm']
      // }
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Toast.show("SUCCESS Order: " + response.paymentId!, context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Fluttertoast.showToast(
        msg: "SUCCESS Order: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 13.0);

    bookApiCall(response.paymentId!);

    print(response.paymentId);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    setState(() {
      isPayment = false;
    });
    // Toast.show("ERROR: " + response.code.toString() + " - " + response.message!,
    //     context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 13.0);

    print(response.code.toString() + " - " + response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Toast.show("EXTERNAL_WALLET: " + response.walletName!, context,
    //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.black,
        fontSize: 13.0);

    print(response.walletName);
  }

  bookApiCall(String txnId) async {
    setState(() {
      isPayment = true;
    });
    var uri = Uri.parse('${baseUrl()}booking');

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);

    request.fields['user_id'] = userID;
    request.fields['service_id'] = widget.restaurants!.restaurant!.id!;
    request.fields['res_id'] = widget.restaurants!.restaurant!.resId!;
    request.fields['vid'] = widget.restaurants!.restaurant!.vId!;
    request.fields['date'] = widget.dateValue!;
    request.fields['slot'] = widget.timeValue!;
    request.fields['address'] = _pickedLocation.toString();
    request.fields['notes'] = widget.notes!;
    // request.fields['notes'] = .toString();

// send
    var response = await request.send();

    print(response.statusCode);

    String responseData = await response.stream
        .transform(utf8.decoder)
        .join(); // decodes on response data using UTF8.decoder
    Map data = json.decode(responseData);
    print(data);
    print(data["booking"]["booking_id"]);

    setState(() {
      isPayment = false;

      if (data["response_code"] == "1") {
        successPaymentApiCall(txnId, data["booking"]["booking_id"].toString());
      } else {
        isPayment = false;
        bookDialog(
          context,
          "something went wrong. Try again",
          button: true,
        );
      }
    });
  }

  successPaymentApiCall(txnId, String bookingId) async {
    setState(() {
      isPayment = true;
    });

    var uri = Uri.parse("${baseUrl()}payment_success");

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> headers = {
      "Accept": "application/json",
    };
    request.headers.addAll(headers);

    request.fields['txn_id'] = txnId;
    request.fields['amount'] = widget.selectedTypePrice!;
    request.fields['booking_id'] = bookingId;
    request.fields['payment_mode'] = 'STRIPE';

// send
    var response = await request.send();

    print(response.statusCode);

    String responseData = await response.stream
        .transform(utf8.decoder)
        .join(); // decodes on response data using UTF8.decoder
    Map data = json.decode(responseData);
    print(data);

    setState(() {
      isPayment = false;

      if (data["response_code"] == "1") {
        // Toast.show("Payment Success", context,
        //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        txnId == ''
            ? Fluttertoast.showToast(
                msg: "Booking Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade200,
                textColor: Colors.black,
                fontSize: 13.0)
            : Fluttertoast.showToast(
                msg: "Payment Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.grey.shade200,
                textColor: Colors.black,
                fontSize: 13.0);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BookingSccess(
                  image: widget.restaurants!.restaurant!.serviceImage![0],
                  name: widget.restaurants!.restaurant!.serviceName,
                  location: _pickedLocation,
                  date: widget.dateValue,
                  time: widget.timeValue)),
        );
      } else {
        setState(() {
          isPayment = false;
          // Toast.show("something went wrong. Try again", context,
          //     duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          Fluttertoast.showToast(
              msg: "something went wrong. Try again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.grey.shade200,
              textColor: Colors.black,
              fontSize: 13.0);
        });
      }
    });
  }
}
