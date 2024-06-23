import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_clean_arch/presentation/pulsa/pulsa.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/common.dart';
import '../../../core/core.dart';
import '../../widget/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController nomorPengirimController = TextEditingController();
  TextEditingController nominalController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController noRekController = TextEditingController();
  TextEditingController atasNamaController = TextEditingController();
  Timer? _debounce;
  List<String> listBank = [
    'Bank BCA',
    'Bank BNI',
    'Bank BRI',
    'Bank Mandiri',
    'Bank CIMB Niaga',
    'Bank Danamon',
    'Bank Permata',
  ];

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  List<Pulsa> dataHistory = [];

  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
      return;
    }

    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
      if (result[0] == ConnectivityResult.none) {
        context.read<GetLocalListBloc>().add(GetLocalListAction());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tidak ada koneksi internet, history transaksi hanya bisa dilihat'),
          ),
        );
      } else {
        context.read<GetListPulsaBloc>().add(const GetListPulsaAction());
      }
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F7),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<GetListPulsaBloc>().add(const GetListPulsaAction());
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBar(),
                Header(context),
                const VerticalSeparator(height: 2),
                Content(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getProviderLogo(String provider, double size) {
    switch (provider) {
      case "Telkom":
        return Assets.images.logoTelkom.image(
          width: size,
        );
      case "Indosat":
        return Assets.images.logoIndoesat.image(
          width: size,
        );
      case "Axis":
        return Assets.images.logoAxis.image(
          width: size,
        );
      case "Three":
        return Assets.images.logoThree.image(
          width: size,
        );
      // Tambahkan case lain sesuai kebutuhan
      default:
        return Icon(Icons.error, size: size); // Placeholder untuk provider yang tidak dikenal
    }
  }

  // ignore: non_constant_identifier_names
  ConstrainedBox Content(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: SizeConfig.safeBlockVertical * 80,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            const Row(
              children: [
                Icon(Icons.history),
                HorizontalSeparator(width: 1),
                Text('Riwayat Transaksi'),
              ],
            ),
            const VerticalSeparator(height: 1),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xffEFEFEF),
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    context.read<GetListPulsaBloc>().add(GetListPulsaAction(search: value));
                  });
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  hintText: 'Cari Berdasarkan Nomor Pengirim...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
              ),
            ),
            const VerticalSeparator(height: 2),
            MultiBlocListener(
              listeners: [
                BlocListener<GetListPulsaBloc, BaseState<List<Pulsa>>>(
                  listener: (context, state) {
                    if (state is LoadingState) {
                      setState(() {
                        isLoading = true;
                      });
                    } else if (state is LoadedState) {
                      context.read<InsertLocalListBloc>().add(InsertLocalListAction(listPulsa: state.data!));

                      setState(() {
                        dataHistory = state.data!;
                        isLoading = false;
                      });
                    }
                  },
                ),
                BlocListener<GetLocalListBloc, BaseState<List<Pulsa>>>(
                  listener: (context, state) {
                    if (state is LoadingState) {
                      setState(() {
                        isLoading = true;
                      });
                    } else if (state is LoadedState) {
                      setState(() {
                        dataHistory = state.data!;
                        isLoading = false;
                      });
                    }
                  },
                ),
              ],
              child: isLoading == true
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Column(
                        children: List.generate(
                          5,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            height: SizeConfig.safeBlockVertical * 10,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Column(
                      children: List.generate(
                        dataHistory.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 8,
                          ),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xffEFEFEF),
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey[100],
                                ),
                                child: getProviderLogo(dataHistory[index].provider!, SizeConfig.safeBlockHorizontal * 5),
                              ),
                              const HorizontalSeparator(width: 3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataHistory[index].nomorPengirim.toString(),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    dataHistory[index].bank!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    "${dataHistory[index].nominal}".toRupiah(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    dataHistory[index].createdAt!.toString().fullDateDMMMMY,
                                    style: Theme.of(context).textTheme.labelSmall,
                                  ),
                                ],
                              ),
                              const Spacer(),
                              if (_connectionStatus[0] != ConnectivityResult.none) ...[
                                Row(
                                  children: [
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        setState(() {
                                          nomorPengirimController.text = dataHistory[index].nomorPengirim.toString();
                                          nominalController.text = dataHistory[index].nominal.toString();
                                          bankController.text = dataHistory[index].bank!;
                                          noRekController.text = dataHistory[index].noRek.toString();
                                          atasNamaController.text = dataHistory[index].atasNama!;
                                        });
                                        formUbahData(context, dataHistory, index).then((value) {
                                          setState(() {
                                            nomorPengirimController.clear();
                                            nominalController.clear();
                                            bankController.clear();
                                            noRekController.clear();
                                            atasNamaController.clear();
                                          });
                                        });
                                      },
                                      icon: const Icon(Icons.edit),
                                    ),
                                    BlocListener<DeletePulsaBloc, BaseState>(
                                      listener: (context, state) {
                                        if (state is SuccessState) {
                                          context.read<GetListPulsaBloc>().add(const GetListPulsaAction());
                                        }
                                      },
                                      child: IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          popUpDelete(context, dataHistory, index);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ),
                                  ],
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
            // BlocConsumer<GetListPulsaBloc, BaseState<List<Pulsa>>>(
            //   listener: (context, state) {
            //     if (state is LoadedState) {
            //       context.read<InsertLocalListBloc>().add(InsertLocalListAction(listPulsa: state.data!));
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is LoadedState) {
            //       return Column(
            //         children: List.generate(
            //           dataHistory.length,
            //           (index) => Container(
            //             padding: const EdgeInsets.symmetric(
            //               horizontal: 4,
            //               vertical: 8,
            //             ),
            //             decoration: BoxDecoration(
            //               border: Border(
            //                 bottom: BorderSide(
            //                   color: const Color(0xffEFEFEF),
            //                 ),
            //               ),
            //             ),
            //             child: Row(
            //               children: [
            //                 Container(
            //                   padding: const EdgeInsets.all(8),
            //                   decoration: BoxDecoration(
            //                     shape: BoxShape.circle,
            //                     color: Colors.grey[100],
            //                   ),
            //                   child: getProviderLogo(dataHistory[index].provider!, SizeConfig.safeBlockHorizontal * 5),
            //                 ),
            //                 const HorizontalSeparator(width: 3),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       dataHistory[index].nomorPengirim.toString(),
            //                       style: const TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w500,
            //                       ),
            //                     ),
            //                     Text(
            //                       dataHistory[index].bank!,
            //                       style: const TextStyle(
            //                         fontSize: 14,
            //                         fontWeight: FontWeight.w400,
            //                       ),
            //                     ),
            //                     Text(
            //                       "${dataHistory[index].nominal}".toRupiah(),
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                         fontWeight: FontWeight.w700,
            //                       ),
            //                     ),
            //                     Text(
            //                       dataHistory[index].createdAt!.toString().fullDateDMMMMY,
            //                       style: Theme.of(context).textTheme.labelSmall,
            //                     ),
            //                   ],
            //                 ),
            //                 const Spacer(),
            //                 Row(
            //                   children: [
            //                     IconButton(
            //                       constraints: const BoxConstraints(),
            //                       padding: EdgeInsets.zero,
            //                       onPressed: () {
            //                         setState(() {
            //                           nomorPengirimController.text = dataHistory[index].nomorPengirim.toString();
            //                           nominalController.text = dataHistory[index].nominal.toString();
            //                           bankController.text = dataHistory[index].bank!;
            //                           noRekController.text = dataHistory[index].noRek.toString();
            //                           atasNamaController.text = dataHistory[index].atasNama!;
            //                         });
            //                         formUbahData(context, dataHistory, index).then((value) {
            //                           setState(() {
            //                             nomorPengirimController.clear();
            //                             nominalController.clear();
            //                             bankController.clear();
            //                             noRekController.clear();
            //                             atasNamaController.clear();
            //                           });
            //                         });
            //                       },
            //                       icon: const Icon(Icons.edit),
            //                     ),
            //                     BlocListener<DeletePulsaBloc, BaseState>(
            //                       listener: (context, state) {
            //                         if (state is SuccessState) {
            //                           context.read<GetListPulsaBloc>().add(const GetListPulsaAction());
            //                         }
            //                       },
            //                       child: IconButton(
            //                         constraints: const BoxConstraints(),
            //                         padding: EdgeInsets.zero,
            //                         onPressed: () {
            //                           popUpDelete(context, state, index);
            //                         },
            //                         icon: const Icon(Icons.close),
            //                       ),
            //                     ),
            //                   ],
            //                 )
            //               ],
            //             ),
            //           ),
            //         ),
            //       );
            //     }
            //     return const Center(child: CircularProgressIndicator());
            //   },
            // )
          ],
        ),
      ),
    );
  }

  Padding Header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nilai hasil Convert Pulsa', style: Theme.of(context).textTheme.labelSmall),
          const VerticalSeparator(height: 1),
          const Row(
            children: [
              Text(
                'Rp ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              ),
              Text(
                '20,000,000',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const VerticalSeparator(height: 2),
          Text('Keuntungan', style: Theme.of(context).textTheme.labelSmall),
          const VerticalSeparator(height: 1),
          Row(
            children: [
              const Text(
                'Rp ',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
              ),
              Text(
                '1,000,000',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.primaryColor,
                ),
              ),
            ],
          ),
          const VerticalSeparator(height: 2),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: ColorConstant.secondaryColor,
                ),
                child: Row(
                  children: [
                    Text(
                      'Convert Pulsa 1 Juta+, bisa Nego Rate!✨',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: ColorConstant.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xffEFEFEF),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    cardOntapConvert(
                      logo: Assets.images.logoTelkom.image(
                        width: SizeConfig.safeBlockHorizontal * 10,
                      ),
                      provider: 'Telkom',
                    ),
                    cardOntapConvert(
                      logo: Assets.images.logoThree.image(
                        width: SizeConfig.safeBlockHorizontal * 10,
                      ),
                      provider: 'Three',
                    ),
                    cardOntapConvert(
                      logo: Assets.images.logoIndoesat.image(
                        width: SizeConfig.safeBlockHorizontal * 10,
                      ),
                      provider: 'Indosat',
                    ),
                    cardOntapConvert(
                      logo: Assets.images.logoAxis.image(
                        width: SizeConfig.safeBlockHorizontal * 10,
                      ),
                      provider: 'Axis',
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Row AppBar() {
    return Row(
      children: [
        Assets.images.logoViapulsa.image(
          width: SizeConfig.safeBlockHorizontal * 40,
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none),
        ),
      ],
    );
  }

  Future<dynamic> popUpDelete(BuildContext context, List<Pulsa> state, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Transaksi'),
          content: const Text('Apakah anda yakin ingin menghapus transaksi ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                context.read<DeletePulsaBloc>().add(DeletePulsaAction(id: dataHistory[index].id!));
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> formUbahData(BuildContext context, List<Pulsa> state, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Transaksi'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
                ),
                const VerticalSeparator(height: 1),
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
                ),
                const VerticalSeparator(height: 1),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: const BorderSide(
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
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Pilih bank';
                    }
                    return null;
                  },
                ),
                const VerticalSeparator(height: 1),
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
                ),
                const VerticalSeparator(height: 1),
                PrimaryTextField(
                  textEditingController: atasNamaController,
                  hintText: 'Atas Nama',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan atas nama';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            BlocListener<UpdatePulsaBloc, BaseState>(
              listener: (context, state) {
                if (state is SuccessState) {
                  context.read<GetListPulsaBloc>().add(const GetListPulsaAction());
                  Navigator.pop(context);
                }
              },
              child: TextButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<UpdatePulsaBloc>().add(
                          UpdatePulsaAction(
                            id: dataHistory[index].id!,
                            pulsa: Pulsa(
                              nomorPengirim: int.tryParse(nomorPengirimController.text),
                              nominal: int.parse(nominalController.text.replaceAll(RegExp(r'[^0-9]'), '')),
                              bank: bankController.text,
                              noRek: int.parse(noRekController.text),
                              atasNama: atasNamaController.text,
                            ),
                          ),
                        );
                  }
                },
                child: const Text('Simpan'),
              ),
            ),
          ],
        );
      },
    );
  }

  InkWell cardOntapConvert({
    required String? provider,
    required Widget? logo,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormPengajuanScreen(provider: provider),
          ),
        );
      },
      child: Column(
        children: [
          logo!,
          const VerticalSeparator(height: 1),
          Text(provider!),
        ],
      ),
    );
  }
}
