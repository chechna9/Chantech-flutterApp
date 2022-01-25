import 'package:chantech/consts.dart';

bool? IsAdmin = true;
bool? IsOuvrier = false;
bool? IsProp = false;
bool? IsResp = false;
String? emailGlob;
int? idGlob;
String urlResponsable = localhost + 'ouvrier/idOuvrier/$idGlob/responsable';
String urlProp = localhost + 'ouvrier/idPersonne/$idGlob/proprietaire';
String urlOuv = localhost + 'ouvrier/idOuvrier/$idGlob/affecter';
