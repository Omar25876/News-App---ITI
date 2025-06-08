import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/features/profile/user_controller.dart';
import 'package:news_app/features/profile/user_details.dart';
import 'package:provider/provider.dart';
import 'app_controller.dart';
import 'language_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    Provider.of<UserController>(context, listen: false).loadUserData();
    final appController = Provider.of<AppController>(context);

    return Consumer<UserController>(
      builder: (context, userController, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFf5f5f5),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF141414),
                fontWeight: FontWeight.w700,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          userController.userImagePath == null
                              ?
                            CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.person_outline,
                                  size: 60,
                                  color: Colors.black,
                                ),
                              )

                          :CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(File(userController.userImagePath!))
                            as ImageProvider,
                          ),

                          GestureDetector(
                            onTap: () async {
                              showImageSourceDialog(context, (XFile file) {
                                userController.updateUserImage(file.path);
                              });
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey.shade300,
                              child: Container(
                                width: 34,
                                height: 34,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  size: 26,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        userController.username ?? "Usama Elgendy",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return UserDetailsScreen(
                            userName: userController.username ?? '',
                            email: userController.email ?? '',
                            pass: userController.pass ?? '',
                          );
                        }));

                    if (result == true) {
                      userController.loadUserData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Personal Info',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  leading:Icon(
                    Icons.person_outline_rounded,
                    size: 24,
                    color: Color(0xFF161F1B),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 24),
                ),
                const Divider(thickness: 1, color: Colors.grey),
                ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      backgroundColor: Colors.transparent,
                      builder: (_) => const LanguageBottomSheet(),

                    );

                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text('Language',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  subtitle: Text(
                    appController.selectedLanguage.isEmpty
                        ? 'Select Language'
                        : appController.selectedLanguage,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  leading:Icon(
                    Icons.language_outlined,
                    size: 24,
                    color: Color(0xFF161F1B),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 24),
                ),
                const Divider(thickness: 1, color: Colors.grey),
                ListTile(
                  onTap: () {
                    showCountryPicker(
                      useSafeArea: true,
                      context: context,
                      showPhoneCode: false,
                      countryListTheme: CountryListThemeData(
                        padding: const EdgeInsets.only(top: 16, bottom: 16),
                        backgroundColor: Colors.white,
                        textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        bottomSheetHeight: MediaQuery.of(context).size.height * 0.9,
                      ),
                      onSelect: (Country country) {
                        appController.setCountry(country.name, country.countryCode);
                      },

                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text('Country',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  subtitle: Text(
                    appController.selectedCountry.isEmpty
                        ? 'Select Country'
                        : appController.selectedCountry,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  leading: Icon(
                    Icons.flag_outlined,
                    size: 24,
                    color: Color(0xFF161F1B),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 24),
                ),
                const Divider(thickness: 1, color: Colors.grey),
                ListTile(
                  onTap: () {},
                  contentPadding: EdgeInsets.zero,
                  title: Text('Terms & Conditions',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      )),
                  leading: Icon(
                    Icons.description_outlined,
                    size: 24,
                    color: Color(0xFF161F1B),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 24),
                ),


                const Divider(thickness: 1, color: Colors.grey),
                ListTile(
                  onTap: () async {
                    await userController.clearUserData();
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/signin', (route) => false);
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    'Logout',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  leading: Icon(
                    Icons.logout_outlined,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }



}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Text(
          'Choose Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
              await ImagePicker().pickImage(source: ImageSource.camera);
              if (image != null) selectedFile(image);
            },
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Camera')
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () async {
              Navigator.pop(context);
              XFile? image =
              await ImagePicker().pickImage(source: ImageSource.gallery);
              if (image != null) selectedFile(image);
            },
            padding: const EdgeInsets.all(16),
            child: const Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Gallery')
              ],
            ),
          ),
        ],
      );
    },
  );
}
