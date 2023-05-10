import 'package:another/screens/account/api/nickname_check_api.dart';
import 'package:flutter/material.dart';
import 'package:another/constant/color.dart';
import 'signup_userinfo.dart';
import '../../widgets/intro_header.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;

  CustomTextField({
    required this.controller,
    required this.labelText,
    this.validator,
    this.obscureText = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    print('_CustomTextFieldState 빌드 됨/');
    print(errorText);
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: errorText,
        labelStyle: TextStyle(
          color: SERVEONE_COLOR, // 원하는 라벨 텍스트 색상으로 변경
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: SERVEONE_COLOR), // 원하는 입력란 테두리 색상으로 변경
        ),
      ),
      style: TextStyle(color: SERVEONE_COLOR), // 원하는 입력 텍스트 색상으로 변경
      onChanged: (value) {
        print('=========여기 체인지=======');
        print(value);
        print('=========여기 체인지=======');
        setState(() {
          errorText = widget.validator?.call(value);
          print('-----------');
          print(errorText);
          print('-----------');
        });
      },
    );
  }
}

class CustomInputForm extends StatefulWidget {
  const CustomInputForm({Key? key}) : super(key: key);
  @override
  State<CustomInputForm> createState() => _CustomInputFormState();
}

class _CustomInputFormState extends State<CustomInputForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pwCheckController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  bool isMaleSelected = true;
  bool isNicknameButtonActive = false;
  bool isNicknamePossible = false;
  bool isEmailPossible = false;
  bool isPwPossible = false;
  bool isPwCheckPossible = false;

  @override
  // 백엔드와 API 통신을 통해 사용 가능하다는 통신을 받으면 true로 변경 (nickname_check_api.dart)
  void nicknamePossible() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('사용 가능한 닉네임입니다.')),
    );
    setState(() {
      isNicknamePossible = true;
    });
  }

  void nicknameDuplication() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('이미 사용중인 닉네임입니다')),
    );
    setState(() {
      isNicknamePossible = false;
    });
  }

  // 닉네임 입력값 수정했을 때 발동할 함수
  Future<void> nicknameImpossible() async {
    setState(() {
      isNicknamePossible = false;
    });
  }

  // 비밀번호 입력값 수정했을 때 발동할 함수
  Future<void> pwInputChange() async {
    if (isPwPossible || isPwCheckPossible) {
      if (pwController.text != pwCheckController.text) {
        setState(() {
          isPwCheckPossible = false;
          _validatePw(pwController.text);
          _validatePwCheck(pwCheckController.text);
        });
      } else if (pwController.text == pwCheckController.text) {
        setState(() {
          isPwCheckPossible = true;
          _validatePw(pwController.text);
          _validatePwCheck(pwCheckController.text);
        });
      }
    }
  }

  // 중복확인 버튼 활성화 여부를 판단하는 함수 (닉네임 입력할때마다 확인)
  @override
  void initState() {
    super.initState();
    nicknameController.addListener(() {
      nicknameImpossible();
      setState(() {
        isNicknameButtonActive = nicknameController.text.length >= 2 &&
                nicknameController.text.length <= 12 &&
                !isNicknamePossible
            ? true
            : false;
      });
    });
    pwController.addListener(() {
      if (isPwPossible || isPwCheckPossible) {
        if (pwController.text != pwCheckController.text) {
          setState(() {
            isPwCheckPossible = false;
          });
        } else if (pwController.text == pwCheckController.text) {
          setState(() {
            isPwCheckPossible = true;
          });
        }
      }
      _validatePw(pwController.text);
      _validatePwCheck(pwCheckController.text);
      print('pwPossible변경');
      print('isPwPossible: $isPwPossible');
      print('isPwCheckPossible: $isPwCheckPossible');
    });
    pwCheckController.addListener(() {
      if (isPwPossible || isPwCheckPossible) {
        if (pwController.text != pwCheckController.text) {
          setState(() {
            isPwCheckPossible = false;
          });
        } else if (pwController.text == pwCheckController.text) {
          setState(() {
            isPwCheckPossible = true;
            _validatePw(pwController.text);
            _validatePwCheck(pwCheckController.text);
          });
        }
      }
      print('pwCheckController변경');
      print('isPwPossible: $isPwPossible');
      print('isPwCheckPossible: $isPwCheckPossible');
    });
  }

  // 이메일 유효성 검사
  String? _validateEmail(String? value) {
    // 입력값이 없는 경우
    if (value == null || value.isEmpty) {
      setState(() {
        isEmailPossible = false;
      });
      print('이메일: $value');
      print('이메일 여부: $isEmailPossible');
      return '이메일을 입력해주세요.';
    }
    // 입력한 경우 이메일 형식 검사
    String emailPattern =
        r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$'; // 이메일 정규식
    RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      setState(() {
        isEmailPossible = false;
      });
      print('이메일: $value');
      print('이메일 여부: $isEmailPossible');
      return '잘못된 이메일 형식입니다.';
    }
    // 잘 된 경우
    setState(() {
      isEmailPossible = true;
    });
    print('이메일: $value');
    print('이메일 여부: $isEmailPossible');
    return null;
  }

  // 비밀번호 유효성 검사
  String? _validatePw(String? value) {
    print('pw함수 들어옴');
    if (value == null || value.isEmpty) {
      setState(() {
        isPwPossible = false;
      });
      print('비밀번호: $value');
      print('비밀번호 여부: $isPwPossible');
      return '비밀번호를 입력해주세요.';
    }
    // 비밀번호 길이 검사
    if (value.length < 8 || value.length > 16) {
      setState(() {
        isPwPossible = false;
      });
      print('비밀번호: $value');
      print('비밀번호 여부: $isPwPossible');
      return '8~16자 사이로 입력해주세요.';
    }
    // 특수문자 포함 여부 검사
    String pattern = r'^(?=.*?[!@#$%^&*(),.?":{}|<>])';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      setState(() {
        isPwPossible = false;
      });
      print('비밀번호: $value');
      print('비밀번호 여부: $isPwPossible');
      return '특수문자를 포함하여 입력해주세요.';
    }
    // 잘 된 경우
    setState(() {
      isPwPossible = true;
    });
    if (isPwPossible == true) {
      print('비밀번호: $value');
      print('비밀번호 여부: $isPwPossible');
      return null;
    }
    print('비밀번호: $value');
    print('비밀번호 여부: $isPwPossible');
    return null;
  }

  // 비밀번호 확인 유효성 검사
  String? _validatePwCheck(String? value) {
    print('pwcheck함수 들어옴');
    if (value != pwController.text) {
      setState(() {
        isPwCheckPossible = false;
      });
      print('비밀번호 확인: $value');
      print('비밀번호 확인 여부: $isPwCheckPossible');
      return '비밀번호를 다시 입력해주세요.';
    } else if (value == pwController.text) {
      setState(() {
        isPwCheckPossible = true;
      });
      print('비밀번호 확인: $value');
      print('비밀번호 확인 여부: $isPwCheckPossible');
      return null;
    } else if (isPwCheckPossible == true){
      print('둘다 체크 완료');
    }
    return null;
  }

  // 닉네임 유효성 검사
  String? _validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요.';
    }
    // 닉네임 길이 검사
    if (value.length < 2 || value.length > 12) {
      return '2~12자 사이로 입력해주세요.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    print('=================================');
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: emailController,
            labelText: '아이디(이메일)',
            validator: _validateEmail,
          ),
          SizedBox(height: 16),
          CustomTextField(
            controller: pwController,
            labelText: '비밀번호',
            validator: _validatePw,
            obscureText: true,
          ),
          SizedBox(height: 16),
          CustomTextField(
            controller: pwCheckController,
            labelText: '비밀번호 확인',
            validator: _validatePwCheck,
            obscureText: true,
          ),
          SizedBox(height: 16),
          Stack(
            children: [
              CustomTextField(
                controller: nicknameController,
                labelText: '닉네임',
                validator: _validateNickname,
              ),
              Positioned(
                top: 15,
                right: 10,
                child: ElevatedButton(
                  onPressed: isNicknameButtonActive &&
                          isNicknamePossible == false
                      ? () async {
                          if (await doubleCheckApi.doubleCheck(
                                  nickname: nicknameController.text,
                                  nicknamePossible: nicknamePossible,
                                  nicknameDuplication: nicknameDuplication) ==
                              '사용 가능') {
                            isNicknamePossible = true;
                          } else {
                            isNicknamePossible = false;
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    onSurface: Colors.white,
                  ),
                  child: Text('중복확인'),
                ),
              )
            ],
          ),
          SizedBox(height: 24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '성별',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: SERVEONE_COLOR,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ToggleButtons(
                    children: <Widget>[
                      Text('남'),
                      Text('여'),
                    ],

                    isSelected: [isMaleSelected, !isMaleSelected],
                    borderRadius: BorderRadius.circular(20), // 테두리 radius
                    color: MAIN_COLOR, // 선택되지 않은 버튼의 색
                    borderColor: MAIN_COLOR, // 선택되지 않은 버튼의 테두리 색
                    selectedColor: Colors.black87, // 선택된 버튼의 글자색
                    selectedBorderColor: MAIN_COLOR, // 선택된 버튼의 테두리 색
                    fillColor: MAIN_COLOR, // 선택된 버튼의 배경 색
                    onPressed: (int index) {
                      setState(() {
                        isMaleSelected = index == 0 ? true : false;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 120),
          FractionallySizedBox(
              widthFactor: 1.0,
              child: ElevatedButton(
                onPressed: isEmailPossible &&
                        isPwPossible &&
                        isPwCheckPossible &&
                        isNicknamePossible
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupUserInfoPage(
                              email: emailController.text,
                              password: pwController.text,
                              nickname: nicknameController.text,
                              isMale: isMaleSelected,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  onSurface: isEmailPossible &&
                          isPwPossible &&
                          isPwCheckPossible &&
                          isNicknamePossible
                      ? MAIN_COLOR
                      : Colors.grey, // 비활성화 색상
                ),
                child: const Text('다음으로'),
              )),
        ],
      ),
    );
  }
}

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BACKGROUND_COLOR,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            IntroHeader(),
            SizedBox(height: 16),
            CustomInputForm(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
