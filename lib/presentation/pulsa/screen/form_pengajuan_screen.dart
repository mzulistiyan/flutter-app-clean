import 'package:flutter/material.dart';
import 'package:flutter_application_clean_arch/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/common.dart';
import '../../presentation.dart';

class FormPengajuanScreen extends StatefulWidget {
  final String provider;
  const FormPengajuanScreen({super.key, required this.provider});

  @override
  State<FormPengajuanScreen> createState() => _FormPengajuanScreenState();
}

class _FormPengajuanScreenState extends State<FormPengajuanScreen> with TickerProviderStateMixin {
  TextEditingController nomorPengirimController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController noRekController = TextEditingController();
  TextEditingController atasNamaController = TextEditingController();

  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  List<String> listBank = [
    'Bank BCA',
    'Bank BNI',
    'Bank BRI',
    'Bank Mandiri',
    'Bank CIMB Niaga',
    'Bank Danamon',
    'Bank Permata',
  ];

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool _isForm1Valid = false;
  bool _isForm2Valid = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPageIndex == 0) {
          return true;
        } else if (_currentPageIndex == 1) {
          _updateCurrentPageIndex(_currentPageIndex - 1);
          return false;
        } else if (_currentPageIndex == 2) {
          _updateCurrentPageIndex(_currentPageIndex - 1);
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: Text(
            _currentPageIndex == 0
                ? 'Informasi Utama'
                : _currentPageIndex == 1
                    ? 'Informasi Bank'
                    : 'Konfirmasi Pengajuan',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (_currentPageIndex == 0) {
                Navigator.pop(context);
              } else if (_currentPageIndex == 1) {
                _updateCurrentPageIndex(_currentPageIndex - 1);
              } else if (_currentPageIndex == 2) {
                _updateCurrentPageIndex(_currentPageIndex - 1);
              }
            },
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Text(
                  "${_currentPageIndex + 1} / 3",
                ),
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 2,
              width: _currentPageIndex == 0
                  ? SizeConfig.safeBlockHorizontal * 30
                  : _currentPageIndex == 1
                      ? SizeConfig.safeBlockHorizontal * 60
                      : SizeConfig.safeBlockHorizontal * 100,
              // color: const Color(0xff08A705),
              color: ColorConstant.primaryColor,
            ),
            Expanded(
              child: PageView(
                controller: _pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: _handlePageViewChanged,
                children: <Widget>[
                  step1(),
                  step2(),
                  step3(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget step1() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSeparator(height: 5),
                    Center(
                      child: Assets.images.ilFinnance.image(
                        height: SizeConfig.safeBlockVertical * 50,
                      ),
                    ),
                    const Text(
                      'Informasi Utama',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Masukkan nominal pulsa yang akan diconvert dan nomor pengirim',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const VerticalSeparator(height: 2),
                    PrimaryTextField(
                      textEditingController: nominalController,
                      hintText: 'Masukkan Nominal Minimal Rp30,000',
                      inputFormatters: [CurrencyInputFormatter()],
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan nominal pulsa';
                        }
                        // Remove all non-digit characters
                        String numericOnly = value.replaceAll(RegExp(r'[^0-9]'), '');
                        if (numericOnly.isEmpty || int.parse(numericOnly) < 30000) {
                          return 'Nominal minimal Rp30,000';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _isForm1Valid = _formKey1.currentState?.validate() ?? false;
                        });
                      },
                    ),
                    const VerticalSeparator(height: 2),
                    PrimaryTextField(
                      textEditingController: nomorPengirimController,
                      hintText: 'Nomor Pengirim minimal 13 digit',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty || value.length < 10) {
                          return 'Masukkan nomor pengirim minimal 13 digit';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _isForm1Valid = _formKey1.currentState?.validate() ?? false;
                        });
                      },
                    ),
                    const VerticalSeparator(height: 0.5),
                    // Text('${nomorPengirimController.text.length} / 13'),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PrimaryButton(
              text: 'Selanjutnya',
              backgroundColor: _isForm1Valid ? ColorConstant.primaryColor : Colors.grey,
              onTap: () {
                if (_formKey1.currentState?.validate() ?? false) {
                  _updateCurrentPageIndex(1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget step2() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const VerticalSeparator(height: 5),
                    Center(
                      child: Assets.images.ilWallet.image(
                        height: SizeConfig.safeBlockVertical * 30,
                      ),
                    ),
                    const Text(
                      'Informasi Bank',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'Masukkan informasi bank yang akan digunakan untuk transfer',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black54,
                      ),
                    ),
                    const VerticalSeparator(height: 2),
                    //create dropdown
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                          borderSide: BorderSide(
                            color: Color(0xFFE5E5E5),
                          ),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      ),
                      value: bankController.text == '' ? null : bankController.text,
                      items: listBank.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          bankController.text = value!;
                          setState(() {
                            _isForm2Valid = _formKey2.currentState?.validate() ?? false;
                          });
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Pilih bank';
                        }
                        return null;
                      },
                    ),
                    const VerticalSeparator(height: 2),
                    PrimaryTextField(
                      textEditingController: noRekController,
                      hintText: 'Nomor Rekening',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan nomor rekening';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _isForm2Valid = _formKey2.currentState?.validate() ?? false;
                        });
                      },
                    ),
                    const VerticalSeparator(height: 2),
                    PrimaryTextField(
                      textEditingController: atasNamaController,
                      hintText: 'Atas Nama',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan atas nama';
                        }

                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _isForm2Valid = _formKey2.currentState?.validate() ?? false;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: PrimaryButton(
                text: 'Selanjutnya',
                backgroundColor: _isForm2Valid ? ColorConstant.primaryColor : Colors.grey,
                onTap: () {
                  if (_formKey2.currentState?.validate() ?? false) {
                    _updateCurrentPageIndex(2);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget step3() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalSeparator(height: 5),
                  Center(
                    child: Assets.images.ilWallet.image(
                      height: SizeConfig.safeBlockVertical * 30,
                    ),
                  ),
                  const Text(
                    'Konfirmasi Pengajuan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Pastikan informasi pengajuan sudah benar sebelum melanjutkan',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                  ),
                  const VerticalSeparator(height: 2),
                  _buildConfirmationDetail('Provider', widget.provider),
                  const VerticalSeparator(height: 2),
                  _buildConfirmationDetail('Nominal', nominalController.text),
                  const VerticalSeparator(height: 2),
                  _buildConfirmationDetail('Nomor Pengirim', nomorPengirimController.text),
                  const VerticalSeparator(height: 2),
                  _buildConfirmationDetail('Bank', bankController.text),
                  const VerticalSeparator(height: 2),
                  _buildConfirmationDetail('Nomor Rekening', noRekController.text),
                  const VerticalSeparator(height: 2),
                  _buildConfirmationDetail('Atas Nama', atasNamaController.text),
                ],
              ),
            ),
          ),
          BlocListener<CreatePulsaBloc, BaseState>(
            listener: (context, state) {
              if (state is LoadingState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Mengirim pengajuan...'),
                  ),
                );
              } else if (state is SuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pengajuan berhasil dikirim'),
                  ),
                );
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
              } else if (state is ErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: PrimaryButton(
                  text: 'Kirim Pengajuan',
                  backgroundColor: ColorConstant.primaryColor,
                  onTap: () {
                    final pulsa = Pulsa(
                      provider: widget.provider,
                      nominal: int.parse(nominalController.text.replaceAll(RegExp(r'[^0-9]'), '')),
                      nomorPengirim: int.parse(nomorPengirimController.text),
                      bank: bankController.text,
                      noRek: int.parse(noRekController.text),
                      atasNama: atasNamaController.text,
                      uangDiterima: int.parse(nominalController.text.replaceAll(RegExp(r'[^0-9]'), '')),
                    );
                    context.read<CreatePulsaBloc>().add(CreatePulsaAction(pulsa: pulsa));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfirmationDetail(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
