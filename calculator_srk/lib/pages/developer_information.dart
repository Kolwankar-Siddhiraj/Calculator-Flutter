import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class developer_information_page extends StatefulWidget {
  @override
  _developer_information_pageState createState() =>
      _developer_information_pageState();
}

class _developer_information_pageState
    extends State<developer_information_page> {
  // variables start
  bool _reviwes_form_open_status = false;
  bool _rate_star_status_1 = false,
      _rate_star_status_2 = false,
      _rate_star_status_3 = false,
      _rate_star_status_4 = false,
      _rate_star_status_5 = false;
  bool _up_down_icon_button_status = false;
  bool _check_status_up_down_button = true;
  String _tooltip_up_down_icon = "";
  bool _report_issue_form_open_status = true;
  bool _check_status_up_down_button_report_issue = true;
  String _name = '',
      _email_id = '',
      _phone_no = '',
      _reviews_or_issue_message = '';
  String _star_rating = '';
  String _subject_for_email = '', _body_of_email = '';

  TextEditingController _name_controller_1 = TextEditingController();
  TextEditingController _name_controller_2 = TextEditingController();
  TextEditingController _phone_controller_1 = TextEditingController();
  TextEditingController _phone_controller_2 = TextEditingController();
  TextEditingController _email_controller_1 = TextEditingController();
  TextEditingController _email_controller_2 = TextEditingController();
  TextEditingController _reviews_controller = TextEditingController();
  TextEditingController _issue_controller = TextEditingController();

  String _show_name_errors_1 = null, _show_name_errors_2 = null;
  String _show_phone_errors_1 = null, _show_phone_errors_2 = null;
  String _show_email_errors_1 = null, _show_email_errors_2 = null;
  String _show_reviews_errors = null, _show_issue_errors = null;

  bool _sendmail_for_reviews = false, _sendmail_for_issue = false;
  bool _email_sent_or_not = false, _sending_email = false;
  bool _sending_email_result = false, _sending_email_result_issue = false;

  // RegExp _name_validation = RegExp(r"^[A-Za-z ]{1, 33}$", caseSensitive: true);
  // RegExp _phone_validation = RegExp(r"^[0-9+ ]{1, 15}$", caseSensitive: true);
  // RegExp _email_validation = RegExp(r"^[A-Za-z ]{1, 33}$", caseSensitive: true);

  // variables end

  // method for sending mails starts here

  sendMail() async {
    String _username = 'sidsflutterapps@gmail.com';
    String _password = '@@helloworld022003';

    final smtpServer = gmail(_username, _password);
    final message = Message()
      ..from = Address(_username, 'Calculator')
      //..recipients.add('siddhirajk77@gmail.com')
      ..ccRecipients
          .addAll(['sidsflutterapps@gmail.com', 'siddhirajk77@gmail.com'])
      //..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = _subject_for_email //'${DateTime.now()}'
      ..text = _body_of_email;
    //..html = "";

    try {
      print("Try to sending mail...!");
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      check_email_sent_or_not(true);
    } on MailerException catch (e) {
      print("Sending Failed");
      check_email_sent_or_not(false);
    } on Exception catch (e) {
      print("Message not sent.");
      check_email_sent_or_not(false);
      // for (var p in e.problems) {
      //   print('Problem: ${p.code}: ${p.msg}');
      // }
    }

//   final equivalentMessage = Message()
//     ..from = Address(username, 'Your name 😀')
//     ..recipients.add(Address('destination@example.com'))
//     ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
//     ..bccRecipients.add('bccAddress@example.com')
//     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
//     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//     ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
//     ..attachments = [
//       FileAttachment(File('exploits_of_a_mom.png'))
//         ..location = Location.inline
//         ..cid = '<myimg@3.141>'
//     ];

//   final sendReport2 = await send(equivalentMessage, smtpServer);
// var connection = PersistentConnection(smtpServer);

//   // Send the first message
//   await connection.send(message);

//   await connection.send(equivalentMessage);

//   await connection.close();
  }

// method for sending mails ends here

  void check_email_sent_or_not(bool _sent_or_not) {
    setState(() {
      _sending_email = false;
      _sending_email_result = true;
      _email_sent_or_not = _sent_or_not;
    });
  }

  void make_all_star_false() {
    _rate_star_status_1 = false;
    _rate_star_status_2 = false;
    _rate_star_status_3 = false;
    _rate_star_status_4 = false;
    _rate_star_status_5 = false;
  }

  Widget select_up_down_icon_button(bool _current_status) {
    if (_current_status) {
      _tooltip_up_down_icon = "Show less";
      return Icon(Icons.expand_less_outlined);
    } else {
      _tooltip_up_down_icon = "Show more";
      return Icon(Icons.expand_more_outlined);
    }
  }

  void clear_textfields() {
    setState(() {
      _name_controller_1.clear();
      _phone_controller_1.clear();
      _email_controller_1.clear();
      _reviews_controller.clear();
    });
  }

  Widget email_sent_or_not_message() {
    show_or_hide_up_down_button(false);
    if (_email_sent_or_not) {
      return Padding(
        padding: EdgeInsets.all(3.0),
        //height: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            Text(
              _sendmail_for_reviews
                  ? "Thanks for sharing your reviews !"
                  : "Thanks ! I will work on this issue.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 50.0),
            RaisedButton(
              color: Colors.grey[600],
              child: Text(
                "Ok",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  _sending_email = false;
                  _sending_email_result = false;
                  _email_sent_or_not = false;
                  _sendmail_for_reviews = false;
                  _sendmail_for_issue = false;
                  clear_textfields();
                  show_or_hide_up_down_button(true);
                });
              },
            ),
            SizedBox(height: 30.0),
          ],
        ),
      );
    } else {
      return Container(
        //height: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30.0),
            Text(
              "Something went wrong !\n\nCheck your internet connection.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 21.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 50.0),
            RaisedButton(
              color: Colors.grey[600],
              child: Text(
                "Ok",
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  _sending_email = false;
                  _sending_email_result = false;
                  _email_sent_or_not = false;
                  _sendmail_for_reviews = false;
                  _sendmail_for_issue = false;
                  clear_textfields();
                  show_or_hide_up_down_button(true);
                });
              },
            ),
            SizedBox(height: 30.0),
          ],
        ),
      );
    }
  }

  Widget email_sent_or_not_message_issue() {}

  Widget show_or_hide_up_down_button(bool _show_or_hide) {
    if (_show_or_hide) {
      return IconButton(
        icon: select_up_down_icon_button(_check_status_up_down_button),
        iconSize: 30.0,
        color: Colors.grey[300],
        tooltip: _tooltip_up_down_icon,
        onPressed: () {
          setState(() {
            _reviwes_form_open_status = !_reviwes_form_open_status;
            _check_status_up_down_button = !_check_status_up_down_button;
          });
        },
      );
    } else {
      return SizedBox(width: 1.0);
    }
  }

  Widget show_or_hide_up_down_button_report_issue() {
    return IconButton(
      icon:
          select_up_down_icon_button(_check_status_up_down_button_report_issue),
      iconSize: 30.0,
      color: Colors.grey[300],
      tooltip: _tooltip_up_down_icon,
      onPressed: () {
        setState(() {
          _report_issue_form_open_status = !_report_issue_form_open_status;
          _check_status_up_down_button_report_issue =
              !_check_status_up_down_button_report_issue;
        });
      },
    );
  }

  Widget star_icon_select(bool _star_status) {
    if (_star_status) {
      return Icon(Icons.star_outlined);
    } else {
      return Icon(Icons.star_outline_outlined);
    }
  }

  // method for reporting an issue starts
  Widget report_an_issue_form() {
    if (_report_issue_form_open_status) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        // reviews form
        child: Column(
          children: <Widget>[
            // name
            TextField(
              controller: _name_controller_2,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_name_errors_2,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Enter your name ",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "Name *",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              maxLength: 33,
              onChanged: (String _value) {
                if (_value.isEmpty) {
                  _show_name_errors_2 = 'Please fill this field !';
                  _sendmail_for_issue = false;
                } else {
                  _show_name_errors_2 = null;
                }
              },
            ),

            // phone number
            TextField(
              controller: _phone_controller_2,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_phone_errors_2,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Enter your phone number ",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "Phone",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 13,
            ),

            // E-mail
            TextField(
              controller: _email_controller_2,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_email_errors_2,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Enter your email address ",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "E-mail *",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              maxLength: 55,
              onChanged: (String _value) {
                if (_value.isEmpty) {
                  _show_email_errors_2 = 'Please fill this field !';
                  _sendmail_for_issue = false;
                } else {
                  _show_email_errors_2 = null;
                }
              },
            ),

            // detailed issue
            TextField(
              controller: _issue_controller,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_issue_errors,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Write about issues or problems...",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "Issue *",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLength: 1000,
              maxLines: 5,
              onChanged: (String _value) {
                if (_value.isEmpty) {
                  _show_issue_errors = 'Please fill this field !';
                  _sendmail_for_issue = false;
                } else {
                  _show_issue_errors = null;
                }
              },
            ),

            _sending_email
                ? Text("Sending.....",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 21.0,
                      fontFamily: 'KiwiMaru',
                    ))
                : TextButton.icon(
                    icon: Icon(Icons.send),
                    label: Text("Send"),
                    //onPressed: sendMail,
                    onPressed: () {
                      setState(() {
                        if ((_name_controller_2.text).isEmpty) {
                          _show_name_errors_2 = 'Please fill this field !';
                          _sendmail_for_issue = false;
                        } else {
                          _name = _name_controller_2.text;
                        }
                        if ((_email_controller_2.text).isEmpty) {
                          _show_email_errors_2 = 'Please fill this field !';
                          _sendmail_for_issue = false;
                        } else {
                          _email_id = _email_controller_2.text;
                        }
                        if ((_phone_controller_2.text).isNotEmpty) {
                          _phone_no = _phone_controller_2.text;
                        }
                        if ((_issue_controller.text).isEmpty) {
                          _show_issue_errors = 'Please fill this field !';
                          _sendmail_for_issue = false;
                        } else {
                          _reviews_or_issue_message = _issue_controller.text;
                        }

                        if (_sendmail_for_issue) {
                          _subject_for_email = 'Report issue';
                          _body_of_email = "Name :: " +
                              _name +
                              "\n" +
                              "Phone no :: " +
                              _phone_no +
                              "\n" +
                              "E-mail :: " +
                              _email_id +
                              "\n" +
                              "About issue :: \n" +
                              _reviews_or_issue_message;
                          _sending_email = true;
                          _sendmail_for_issue = true;
                          sendMail();
                        }
                      });
                    },
                  ),

            // about reviews everthing ends here
          ],
        ),
      );
    } else {
      return SizedBox(height: 1.0);
    }
  }
  // method for reporting an issue ends

  // method show or hide reviews Widget starts
  Widget rate_us_reviews() {
    if (_reviwes_form_open_status) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        // reviews form
        child: Column(
          children: <Widget>[
            // name
            TextField(
              controller: _name_controller_1,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_name_errors_1,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Enter your name ",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "Name *",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              maxLength: 33,
              onChanged: (String _value) {
                if (_value.isEmpty) {
                  _show_name_errors_1 = 'Please fill this field !';
                  _sendmail_for_reviews = false;
                } else {
                  _show_name_errors_1 = null;
                }
              },
            ),

            // phone number
            TextField(
              controller: _phone_controller_1,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_phone_errors_1,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Enter your phone number ",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "Phone",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 13,
            ),

            // E-mail
            TextField(
              controller: _email_controller_1,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_email_errors_1,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Enter your email address ",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "E-mail *",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.name,
              maxLength: 55,
              onChanged: (String _value) {
                if (_value.isEmpty) {
                  _show_email_errors_1 = 'Please fill this field !';
                  _sendmail_for_reviews = false;
                } else {
                  _show_email_errors_1 = null;
                  _sendmail_for_reviews = false;
                }
              },
            ),

            // detailed reviews
            TextField(
              controller: _reviews_controller,
              style: TextStyle(
                color: Colors.grey[500],
              ),
              decoration: InputDecoration(
                errorText: _show_reviews_errors,
                fillColor: Colors.grey[900],
                filled: true,
                hintText: "Write your reviews or write about issues....",
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                ),
                alignLabelWithHint: true,
                labelText: "Reviews *",
                labelStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blue[400],
                ),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLength: 900,
              maxLines: 5,
              onChanged: (String _value) {
                if (_value.isEmpty) {
                  _show_reviews_errors = 'Please fill this field !';
                  _sendmail_for_reviews = true;
                } else {
                  _show_reviews_errors = null;
                  _sendmail_for_reviews = true;
                }
              },
            ),

            _sending_email
                ? Text("Sending.....",
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 21.0,
                      fontFamily: 'KiwiMaru',
                    ))
                : TextButton.icon(
                    icon: Icon(Icons.send),
                    label: Text("Send"),
                    //onPressed: sendMail,
                    onPressed: () {
                      setState(() {
                        if ((_name_controller_1.text).isEmpty) {
                          _show_name_errors_1 = 'Please fill this field !';
                          _sendmail_for_reviews = false;
                        } else {
                          _name = _name_controller_1.text;
                        }
                        if ((_email_controller_1.text).isEmpty) {
                          _show_email_errors_1 = 'Please fill this field !';
                          _sendmail_for_reviews = false;
                        } else {
                          _email_id = _email_controller_1.text;
                        }
                        if ((_phone_controller_1.text).isNotEmpty) {
                          _phone_no = _phone_controller_1.text;
                        }
                        if ((_reviews_controller.text).isEmpty) {
                          _show_reviews_errors = 'Please fill this field !';
                          _sendmail_for_reviews = false;
                        } else {
                          _reviews_or_issue_message = _reviews_controller.text;
                        }

                        if (_sendmail_for_reviews) {
                          _subject_for_email = 'Star ratings';
                          _body_of_email = "Star ratings :: " +
                              _star_rating +
                              "\n" +
                              "Name :: " +
                              _name +
                              "\n" +
                              "Phone no :: " +
                              _phone_no +
                              "\n" +
                              "E-mail :: " +
                              _email_id +
                              "\n" +
                              "Reviews :: \n" +
                              _reviews_or_issue_message;
                          _sending_email = true;
                          _sendmail_for_reviews = true;
                          //_reviwes_form_open_status = false;
                          sendMail();
                        }
                      });
                    },
                  ),

            // about reviews everthing ends here
          ],
        ),
      );
    } else {
      return SizedBox(height: 1.0);
    }
  }
  // method for show or hide reviews widget ends

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'KiwiMaru',
            // color: Colors.grey[600],
          ),
        ),
        //centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0.0,
      ),
      body: Padding(
        //padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
        padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
        child: SingleChildScrollView(
          child: Column(
            //scrollDirection: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/bot.jpg'),
                  //backgroundColor: Colors.amber,
                  radius: 60.0,
                ),
              ),
              SizedBox(height: 10.0),
              Divider(
                height: 25.0,
                color: Colors.grey[300],
              ),
              Text(
                "About Developer :",
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.amber[300],
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(
                height: 15.0,
                color: Colors.grey[700],
              ),
              SizedBox(
                height: 7.0,
              ),
              Text(
                "Name :",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "Siddhiraj R. K.",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "About :",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "IT Engineer ",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.0,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Divider(
                height: 10.0,
                color: Colors.grey[700],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.email,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "siddhirajk77@gmail.com",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.public,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "python-everything.blogspot.com",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.call,
                    color: Colors.grey[400],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "+91 9594106468 ",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 15.0,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.0),
              Divider(
                height: 15.0,
                color: Colors.grey[300],
              ),

              // SizedBox(height: 2.0),

              // Rate this app
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Rate this app :",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.amber[300],
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  show_or_hide_up_down_button(_up_down_icon_button_status),
                ],
              ),
              // rate us star
              SizedBox(height: 20.0),
              // Divider(
              //   height: 10.0,
              //   color: Colors.grey[700],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // star buttons
                  SizedBox(width: 5.0),
                  Expanded(
                    child: IconButton(
                      icon: star_icon_select(_rate_star_status_1),
                      color: Colors.grey[400],
                      iconSize: 40.0,
                      onPressed: () {
                        setState(() {
                          _star_rating = 'One Star';
                          _check_status_up_down_button = true;
                          _reviwes_form_open_status = true;
                          _up_down_icon_button_status = true;
                          make_all_star_false();
                          _rate_star_status_1 = true;
                        });
                      },
                    ),
                  ),
//                  SizedBox(width: 10.0),
                  Expanded(
                    child: IconButton(
                      icon: star_icon_select(_rate_star_status_2),
                      color: Colors.grey[400],
                      iconSize: 40.0,
                      onPressed: () {
                        setState(() {
                          _star_rating = 'Two Star';
                          _check_status_up_down_button = true;
                          _reviwes_form_open_status = true;
                          _up_down_icon_button_status = true;
                          make_all_star_false();
                          _rate_star_status_1 = true;
                          _rate_star_status_2 = true;
                        });
                      },
                    ),
                  ),
//                  SizedBox(width: 10.0),
                  Expanded(
                    child: IconButton(
                      icon: star_icon_select(_rate_star_status_3),
                      color: Colors.grey[400],
                      iconSize: 40.0,
                      onPressed: () {
                        setState(() {
                          _star_rating = 'Three Star';
                          _check_status_up_down_button = true;
                          _reviwes_form_open_status = true;
                          _up_down_icon_button_status = true;
                          make_all_star_false();
                          _rate_star_status_1 = true;
                          _rate_star_status_2 = true;
                          _rate_star_status_3 = true;
                        });
                      },
                    ),
                  ),
//                  SizedBox(width: 10.0),
                  Expanded(
                    child: IconButton(
                      icon: star_icon_select(_rate_star_status_4),
                      color: Colors.grey[400],
                      iconSize: 40.0,
                      onPressed: () {
                        setState(() {
                          _star_rating = 'Four Star';
                          _check_status_up_down_button = true;
                          _reviwes_form_open_status = true;
                          _up_down_icon_button_status = true;
                          make_all_star_false();
                          _rate_star_status_1 = true;
                          _rate_star_status_2 = true;
                          _rate_star_status_3 = true;
                          _rate_star_status_4 = true;
                        });
                      },
                    ),
                  ),
//                  SizedBox(width: 10.0),
                  Expanded(
                    child: IconButton(
                      icon: star_icon_select(_rate_star_status_5),
                      color: Colors.grey[400],
                      iconSize: 40.0,
                      onPressed: () {
                        setState(() {
                          _star_rating = 'Five Star';
                          _check_status_up_down_button = true;
                          _reviwes_form_open_status = true;
                          _up_down_icon_button_status = true;
                          make_all_star_false();
                          _rate_star_status_1 = true;
                          _rate_star_status_2 = true;
                          _rate_star_status_3 = true;
                          _rate_star_status_4 = true;
                          _rate_star_status_5 = true;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 5.0),
                ],
              ),
              SizedBox(height: 15.0),

              // Share your reviews start
              _sending_email_result
                  ?
                  // ? _sendmail_for_reviews
                  //     ? email_sent_or_not_message()
                  email_sent_or_not_message()
                  : rate_us_reviews(),
              // Share your reviews end

              Divider(
                height: 20.0,
                color: Colors.grey[300],
              ),

              // Report issue start
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Text(
              //       "Report an Issue :",
              //       style: TextStyle(
              //         fontSize: 25.0,
              //         color: Colors.amber[300],
              //         fontWeight: FontWeight.bold,
              //         letterSpacing: 1.0,
              //       ),
              //     ),
              //     show_or_hide_up_down_button_report_issue(),
              //   ],
              // ),
              // SizedBox(height: 15.0),
              // // report an issue form
              // _sending_email_result_issue
              //     ? _sendmail_for_issue
              //         ? email_sent_or_not_message_issue()
              //         : report_an_issue_form()
              //     : report_an_issue_form(),
              // // Report issue end

              // Divider(
              //   height: 20.0,
              //   color: Colors.grey[300],
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "v1.0.0",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
