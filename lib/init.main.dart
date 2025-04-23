import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:leaf_scan/firebase_options.dart';
import 'package:path_provider/path_provider.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initFirebase();
  _initHive();
  _initFirebaseAuth();
  _initFirebaseFirestore();
}

Future<void> _initHive() async {
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);
  final Box<String> box = await Hive.openBox("user_details");
  serviceLocator.registerLazySingleton(() => box);
}

Future<void> _initFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void _initFirebaseAuth() {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  serviceLocator.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
}

void _initFirebaseFirestore() {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  serviceLocator
      .registerLazySingleton<FirebaseFirestore>(() => firebaseFirestore);
}
