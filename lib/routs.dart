import 'package:get/get.dart';
import 'package:model_bottom/binding/binding.dart';
import 'package:model_bottom/screen/forgot_password_screen/forgot_password_screen.dart';
import 'package:model_bottom/screen/pagination_screen/pagination_screen.dart';
import 'package:model_bottom/screen/screen.dart';

final List<GetPage> appPage = [
  GetPage(
      name: PaginationScreen.pageId,
      page: () => PaginationScreen(),
      binding: PaginationBinding()),
  GetPage(
      name: SqliteDbScreen.pageId,
      page: () => SqliteDbScreen(),
      binding: SqliteDbBindings()),
  GetPage(
      name: TypesAhesScreen.pageId,
      page: () => TypesAhesScreen(),
      binding: TypesAhedBinding()),
  GetPage(
      name: LoginScreen.pageId,
      page: () => LoginScreen(),
      binding: LoginBinding()),
  GetPage(
      name: RegisterScreen.pageId,
      page: () => RegisterScreen(),
      binding: RegisterBinding()),
  GetPage(
      name: HomeScreen.pageId,
      page: () => HomeScreen(),
      binding: HomeBinding()),
  GetPage(
      name: SplashScreen.pageId,
      page: () => SplashScreen(),
      binding: SplashBinding()),
  GetPage(
      name: ProfileScreen.pageId,
      page: () => ProfileScreen(),
      binding: ProfileBinding()),
  GetPage(
      name: UsersScreen.pageId,
      page: () => UsersScreen(),
      binding: UsersBinding()),
  GetPage(
      name: ProductScreen.pageId,
      page: () => ProductScreen(),
      binding: ProductBinding()),
  GetPage(
      name: CartScreen.pageId,
      page: () => CartScreen(),
  binding: CartBinding()),
  GetPage(
      name: CheckOutScreen.pageId,
      page: () => CheckOutScreen(),
  binding: CheckOutBindings()),
  GetPage(
      name: ForgotPasswordScreen.pageId,
      page: () => const ForgotPasswordScreen(),
      binding: ForgotPasswordBinding())
];
