// Calculator

//import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import './widgets/CalcButton.dart';
import './pages/developer_information.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(CalcApp());
}

class CalcApp extends StatefulWidget {
  const CalcApp({Key key}) : super(key: key);
  @override
  CalcAppState createState() => CalcAppState();
}

class CalcAppState extends State<CalcApp> {
  // All varibles
  String _expression_1 = '';
  String _expression_2 = '';
  bool _operator_status = false;
  String _whole_expression = '';
  String _result = '';
  String _selected_operator = '';
  double _expression_font = 40.0;
  double _result_font = 30.0;
  String _just_check_exp_length = '';
  bool _operation_complete_run_again = false;
  int _expression_length = 12;
  //double _button_box_height = 75.0;
  bool _negative_number_1_status = false;
  bool _negative_number_2_status = false;
  bool _result_as_expression = false;
  String _error_message_for_user = "";
  String _minus_sign = "-";
  String _exp_num_1;
  String _exp_num_2;
  bool _negative_number_2_bracket = false;
  Map _expression_font_map = {
    11: 36.0,
    12: 35.0,
    13: 35.0,
    14: 34.0,
    15: 31.0,
    16: 31.0,
    17: 29.0,
    18: 27.0,
    19: 25.0,
    20: 24.0,
    21: 24.0,
    22: 23.0,
    23: 22.0,
    24: 21.0,
    25: 20.0,
    26: 20.0,
    27: 21.0,
    28: 20.0,
    29: 17.0,
    30: 16.0,
    31: 15.0,
    32: 14.0,
    33: 13.0
  };
  Map _expression_font_negative_map = {
    11: 35.0,
    12: 32.0,
    13: 27.0,
    14: 26.0,
    15: 25.0,
    16: 24.0,
    17: 23.0,
    18: 22.0,
    19: 22.0,
    20: 21.0,
    21: 21.0,
    22: 20.0,
    23: 19.0,
    24: 19.0,
    25: 19.0,
    26: 18.0,
    27: 17.0,
    28: 13.0,
    29: 12.0,
    30: 11.0,
    31: 13.0,
    32: 13.0,
    33: 12.0
  };

  Map _result_font_map = {
    12: 38.0,
    13: 35.0,
    14: 34.0,
    15: 32.0,
    16: 30.0,
    17: 28.0,
    18: 27.0,
    19: 26.0,
    20: 25.0,
    21: 24.0,
    22: 23.0,
    23: 22.0,
    24: 21.0,
    25: 20.0,
    26: 19.0,
    27: 18.0,
    28: 18.0,
    29: 17.0
  };

  // double adjust_result_font() {
  //   setState(() {
  //     if (_result.length >= 12 && _result.length <= 25) {
  //       return _result_font_map[_result.length];
  //     } else {
  //       return 40.0;
  //     }
  //   });
  // }

  double adjust_font_expression(String _call_owner) {
    print("Call Owner : $_call_owner");
    _just_check_exp_length = _expression_1 + _selected_operator + _expression_2;
    // Increase Font

    if (_negative_number_1_status || _negative_number_2_status) {
      if (_just_check_exp_length.length >= 11) {
        print(_expression_font_negative_map[_just_check_exp_length.length]);
        return _expression_font_negative_map[_just_check_exp_length.length];
      } else {
        return 40.0;
      }
    } else {
      if (_just_check_exp_length.length >= 11) {
        return _expression_font_map[_just_check_exp_length.length];
      } else {
        return 40.0;
      }
    }
  }

  void show_error_message(String _message_for_user) {
    setState(() {
      _error_message_for_user = _message_for_user;
    });

    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _error_message_for_user = "";
      });
    });
  }

  bool exp_length_check(String _check_expression) {
    // if (_check_expression.length <= _expression_length) {
    //   _error_message_for_user = "";
    // }
    if (_check_expression.length > _expression_length) {
      print("No more Numbers Only 12 ");
      show_error_message("Can't enter more than 13 digits");
      return false;
    } else {
      print("You can enter more Number ");
      _error_message_for_user = "";
      return true;
    }
  }

  void check_negative_number(String _text_value) {
    if (_text_value == '(-)' && _operator_status == false) {
      print("Checking for Negative Number !");
      //_expression_length += 3;
      _negative_number_1_status = true;
    }

    if (_text_value == '(-)' && _operator_status == true) {
      print("Checking for Negative Number !");
      //_expression_length += 3;
      _negative_number_2_status = true;
    }

    if (_text_value == '(-)' && _result_as_expression) {
      _negative_number_1_status = true;
      _negative_number_2_status = false;
      _result_as_expression = false;
    }

    if (_negative_number_2_bracket && _operator_status) {
      _negative_number_2_status = true;
    }
  }

  void erase_result() {
    setState(() {
      if (_expression_1 == '' ||
          _selected_operator == '' ||
          _expression_2 == '') {
        _result = '';
      }
    });
  }

  void numClick(String text) {
    setState(() {
      // adjust a font size depends on number length
      _expression_font = adjust_font_expression("numClick");
      erase_result();
      if (_operator_status) {
        //_whole_expression += text;
        if (exp_length_check(_expression_2)) {
          _expression_2 += text;
        }
        print(
            "$_expression_1, $_expression_2, $_whole_expression, $_operator_status, $_result, $_selected_operator");
      } else {
        //_whole_expression += text;
        if (exp_length_check(_expression_1)) {
          _expression_1 += text;
        }
        print(
            "$_expression_1, $_expression_2, $_whole_expression, $_operator_status, $_result, $_selected_operator");
      }
    });
  }

  void allClear(String text) {
    setState(() {
      _expression_1 = '';
      _expression_2 = '';
      _selected_operator = '';
      _result = '';
      _operator_status = false;
      _operation_complete_run_again = false;
      _negative_number_1_status = false;
      _negative_number_2_status = false;
      _result_as_expression = false;
      _expression_length = 12;
      _expression_font = 40.0;
      _result_font = 30.0;
      _error_message_for_user = "";
      _negative_number_2_bracket = false;
      erase_result();
    });
  }

  String show_whole_expression() {
    String _tp_expression_1 = _expression_1;
    String _tp_expression_2 = _expression_2;
    String _tp_selected_operator = _selected_operator;

    if (_negative_number_1_status) {
      _tp_expression_1 = '(-$_expression_1)';
    }
    if (_negative_number_2_status) {
      _tp_expression_2 = '(-$_expression_2)';
    }
    erase_result();
    //return _tp_expression_1 + "\n" + _tp_selected_operator + " " + _tp_expression_2;
    if ((_tp_expression_1 + _tp_selected_operator + _tp_expression_2) == '') {
      return '0';
    } else {
      return _tp_expression_1 + _tp_selected_operator + _tp_expression_2;
    }
  }

  void operator_select(String text) {
    setState(() {
      if (_operation_complete_run_again) {
        int _check_result_in_int = int.parse(_result);
        _negative_number_1_status = false;
        _negative_number_2_status = false;

        if (_check_result_in_int < 0) {
          _negative_number_1_status = true;
          String _tp_result = _result.substring(1, _result.length);
          _expression_1 = _tp_result;
        } else {
          _expression_1 = _result;
          _negative_number_1_status = false;
        }

        _expression_2 = '';
        _selected_operator = '';
        _operation_complete_run_again = false;
        _negative_number_2_status = false;
        _operator_status = true;
      }

      if (_expression_1 != '') {
        if (_expression_2 == '') {
          if (text != '(-)') {
            _selected_operator = text;
            _operator_status = true;
            //_negative_number_2_bracket = true;
          }
        }
      }

      _expression_font = adjust_font_expression("operator_select");
      check_negative_number(text);
      erase_result();

      print(
          "$_expression_1, $_expression_2, $_whole_expression, $_operator_status, $_result, $_selected_operator");
    });
  }

  String compare_int_double(double _check_value) {
    int _timepass_var = _check_value.toInt();
    if ((_check_value - _timepass_var) == 0.0) {
      print("Converting Double into Int");
      return _timepass_var.toString();
    } else {
      return _check_value.toString();
    }
  }

  void backspace_minus_bracket() {
    setState(() {
      // if (_expression_1 == '') {
      //   _negative_number_1_status = false;
      // }
      if (_negative_number_1_status) {
        if (_selected_operator == '' &&
            _expression_2 == '' &&
            _expression_1 == '') {
          _negative_number_1_status = false;
          _expression_length = 12;
        }
      }
      if (_negative_number_2_status) {
        if (_selected_operator != '' && _expression_2 == '') {
          _negative_number_2_status = false;
          _expression_length = 12;
        }
      }
      erase_result();
    });
  }

  void backspace_operator() {
    if (_selected_operator == '' &&
        _expression_1 == '' &&
        _expression_2 == '') {}

    if (_operator_status) {
      if (_expression_2 == '') {
        if (_negative_number_2_status == false) {
          _selected_operator = '';
          _operator_status = false;
          _expression_1 += ' ';
        }
      }
    }
    backspace_minus_bracket();
    erase_result();
  }

  void _backspace_num(String text) {
    setState(() {
      _expression_font = adjust_font_expression("backspace_num");
      _operation_complete_run_again = false;
      backspace_operator();
      if (_expression_1.length <= _expression_length ||
          _expression_2.length <= _expression_length) {
        _error_message_for_user = "";
      }
      if (_operator_status) {
        _expression_2 = _expression_2.substring(0, _expression_2.length - 1);
      } else {
        _expression_1 = _expression_1.substring(0, _expression_1.length - 1);
      }

      erase_result();
    });
  }

  void get_result(String text) {
    setState(() {
      if (_expression_1 != '' &&
          _selected_operator != '' &&
          _expression_2 != '') {
        _operation_complete_run_again = true;
        _result_as_expression = true;

        _exp_num_1 = _expression_1;
        _exp_num_2 = _expression_2;

        if (_negative_number_1_status) {
          _exp_num_1 = _minus_sign + _exp_num_1;
        }
        if (_negative_number_2_status) {
          _exp_num_2 = _minus_sign + _exp_num_2;
        }

        switch (_selected_operator) {
          case '+':
            print("Addition");
            double _number_1 = double.parse(_exp_num_1);
            double _number_2 = double.parse(_exp_num_2);
            double _raw_result = _number_1 + _number_2;
            print("$_number_1, $_number_2, $_raw_result");
            _result = compare_int_double(_raw_result);
            break;
          case '-':
            print("Subtraction");
            double _number_1 = double.parse(_exp_num_1);
            double _number_2 = double.parse(_exp_num_2);
            double _raw_result = _number_1 - _number_2;

            print("$_number_1, $_number_2, $_raw_result");
            _result = compare_int_double(_raw_result);
            break;
          // Multiplication
          case '*':
            print("Multiplication");
            double _number_1 = double.parse(_exp_num_1);
            double _number_2 = double.parse(_exp_num_2);
            double _raw_result = _number_1 * _number_2;
            print("$_number_1, $_number_2, $_raw_result");
            _result = compare_int_double(_raw_result);
            break;
          // Division
          case '/':
            print("Division");
            double _number_1 = double.parse(_exp_num_1);
            double _number_2 = double.parse(_exp_num_2);
            if (_number_2 == 0) {
              show_error_message("Can't Divide any number by value Zero (0)");
              print("Can't Divide with value Zero (0)");
              break;
            }
            double _raw_result = _number_1 / _number_2;
            print("$_number_1, $_number_2, $_raw_result");
            _result = compare_int_double(_raw_result);
            break;

          default:
            print("Invalid operator Error !");
            show_error_message("Invalid operator Error !");
        }

        //_result_font = adjust_result_font();
      }
    });
  }

  // void evaluate(String text) {
  //   Parser p = Parser();
  //   Expression exp = p.parse(_expression);
  //   ContextModel cm = ContextModel();
  //   setState(() {
  //     _history = _expression;
  //     _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
  //   });
  // }

// ###########################################################################################################

  // Main Widget Starts Here

  @override
  Widget build(BuildContext context) {
    // var _device_screen_height = MediaQuery.of(context).size.height;
    // var _device_screen_width = MediaQuery.of(context).size.width;

    // print(
    //     "Screen height :: $_device_screen_height & Screen width :: $_device_screen_width");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      routes: {
        '/developerInformation': (context) => developer_information_page(),
      },
      home: Scaffold(
        backgroundColor: Colors.black,

        appBar: AppBar(
          backgroundColor: Colors.blue[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  "Calculator",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'KiwiMaru',
                  ),
                ),
              ),
              Builder(
                builder: (context) => IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, '/developerInformation'),
                  // {
                  //   print("Developer Information Page");
                  //   Navigator.pushNamed(context, '/developerInformation');
                  //   print("Page Developer_information work !");
                  // },
                  tooltip: "Settings",
                  icon: Icon(Icons.settings),
                ),
              ),
            ],
          ),
        ),
        //backgroundColor: Color(0xFF283637),

        // body widget
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            //height: 1,
            //width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(flex: 2, child: SizedBox(height: 10.0)),
                Container(
                  height: 45,
                  //color: Colors.grey[500],
                  padding: const EdgeInsets.only(right: 3),
                  alignment: Alignment.center,
                  //color: Colors.grey[850],
                  child: Text(
                    _error_message_for_user,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      //backgroundColor: Colors.grey[500],
                      color: Colors.grey[700],
                      fontSize: 18.0,
                      fontFamily: 'kiwimaru',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                Expanded(flex: 2, child: SizedBox(height: 10.0)),
                //SizedBox(height: 10.0),
                // Container for Showing Whole Expression
                Container(
                  height: 60.0,
                  //color: Colors.grey[500],
                  child: Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: Text(
                      show_whole_expression(),
                      style: TextStyle(
                        color: Colors.amberAccent[200],
                        letterSpacing: 1.0,
                        fontSize: _expression_font,
                        fontFamily: 'KiwiMaru',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  alignment: Alignment(1.0, 1.0),
                ),

                Expanded(flex: 1, child: SizedBox(height: 10.0)),
                //SizedBox(height: 10.0),
                // Container for Showing Result
                Container(
                  height: 40.0,
                  //color: Colors.grey[500],
                  child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: Text(
                      _result,
                      style: TextStyle(
                        color: Colors.grey[400],
                        letterSpacing: 1.0,
                        //fontSize: _result_font,
                        fontSize: 25.0,
                        fontFamily: 'KiwiMaru',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  alignment: Alignment(1.0, 1.0),
                ),
                //Expanded(flex: 1, child: SizedBox(height: 10.0)),
                SizedBox(height: 41.0),
                Divider(
                  height: 10.0,
                  color: Colors.grey[600],
                ),
                SizedBox(
                  height: 5.0,
                ),

                // All Buttons Here

                Container(
                  height: 85.0,
                  //color: Colors.grey[500],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      CalcButton(
                        text: 'C',
                        textColor: 0xFFFFFFFF,
                        fillColor: 0xFFDB4437,
                        // textColor: 0xFFDB4437,
                        // fillColor: 0xFF6C807F,
                        //textSize: 30,
                        callback: allClear,
                      ),
                      CalcButton(
                        extraWidget: Icon(
                          Icons.backspace,
                        ),
                        text: '*',
                        fillColor: 0xFF6C807F,
                        callback: _backspace_num,
                      ),
                      CalcButton(
                        text: '(-)',
                        fillColor: 0xFFFFFFFF,
                        //textColor: 0xFF65BDAC,
                        textColor: 0xFF000000,

                        callback: operator_select,
                      ),
                      CalcButton(
                        text: '/',
                        fillColor: 0xFFFFFFFF,
                        textColor: 0xFF000000,
                        callback: operator_select,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 85.0,
                  //color: Colors.grey[500],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CalcButton(
                        text: '7',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '8',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '9',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        extraWidget: Icon(Icons.close),
                        text: '*',
                        fillColor: 0xFFFFFFFF,
                        textColor: 0xFF000000,
                        textSize: 24,
                        callback: operator_select,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 85.0,
                  //color: Colors.grey[500],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CalcButton(
                        text: '4',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '5',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '6',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '-',
                        fillColor: 0xFFFFFFFF,
                        textColor: 0xFF000000,
                        textSize: 38,
                        callback: operator_select,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 85.0,
                  //color: Colors.grey[500],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CalcButton(
                        text: '1',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '2',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '3',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '+',
                        fillColor: 0xFFFFFFFF,
                        textColor: 0xFF000000,
                        textSize: 30,
                        callback: operator_select,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 85.0,
                  //color: Colors.grey[500],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      CalcButton(
                        text: '.',
                        textColor: 0xFF228B22,
                        callback: numClick,
                      ),
                      CalcButton(
                        textColor: 0xFF228B22,
                        text: '0',
                        callback: numClick,
                      ),
                      CalcButton(
                        text: '00',
                        textColor: 0xFF228B22,
                        callback: numClick,
                        textSize: 26,
                      ),
                      CalcButton(
                        text: '=',
                        textColor: 0xFFFFFFFF,
                        fillColor: 0xFF228B22,
                        // fillColor: 0xFFFFFFFF,
                        // textColor: 0xFF65BDAC,
                        callback: get_result,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
