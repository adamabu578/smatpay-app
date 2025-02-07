import 'package:firebase_remote_config/firebase_remote_config.dart'; // For Firebase Remote Config
import 'package:flutter/material.dart'; // Flutter's UI toolkit
import 'package:package_info_plus/package_info_plus.dart'; // For getting app version details

class TRemoteConfig extends StatefulWidget {
  const TRemoteConfig({super.key});

  @override
  State<TRemoteConfig> createState() => _TRemoteConfigState();
}

class _TRemoteConfigState extends State<TRemoteConfig> {
  String _currentAppVersion =
      '1'; // Holds the current version of the app (default '1')

  @override
  void initState() {
    super.initState();
    _checkForUpdate(); // Call the update check when the widget is initialized
  }

  // This function checks if an app update is required by comparing the current version with the one in Firebase Remote Config.
  Future<void> _checkForUpdate() async {
    try {
      final remoteConfig = FirebaseRemoteConfig
          .instance; // Get an instance of Firebase Remote Config

      // Set config settings such as fetch timeout and minimum fetch interval
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(
            seconds: 10), // Set the time to wait for fetching the config
        minimumFetchInterval:
            const Duration(seconds: 10), // Minimum interval between fetches
      ));

      await remoteConfig
          .fetchAndActivate(); // Fetch new config values from the Firebase server and activate them

      // Check if the widget is still in the widget tree to avoid errors
      if (!mounted) return;

      // Get the latest enforced version from Firebase Remote Config
      String enforcedVersion = remoteConfig.getString('latest_version');

      // Get the current version of the app using PackageInfo
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String currentVersion = packageInfo.version;

      // Update the state with the current app version (to display in the UI)
      setState(() {
        _currentAppVersion = currentVersion;
      });

      // Check if the app update is required by comparing the enforced version with the current version
      if (_isUpdateRequired(enforcedVersion, currentVersion)) {
        _showUpdateDialog(); // Show the update dialog if an update is needed
      }
    } catch (e) {
      print(
          'Remote Config fetch error: $e'); // Print error message if there is an issue fetching config
    }
  }

  // This function compares the enforced version from Firebase with the current app version.
  bool _isUpdateRequired(String enforcedVersion, String currentVersion) {
    // Split the version strings by '.' to compare major, minor, and patch versions
    List<String> enforcedParts = enforcedVersion.split('.');
    List<String> currentParts = currentVersion.split('.');

    // Ensure both versions have the same number of parts by padding the current version with '0'
    while (currentParts.length < enforcedParts.length) {
      currentParts.add(
          '0.0'); // Add '.0' if the current version has fewer parts than the enforced version
    }

    // Compare each part of the version numbers
    for (int i = 0; i < enforcedParts.length; i++) {
      int enforced =
          int.parse(enforcedParts[i]); // Parse enforced version part to int
      int current =
          int.parse(currentParts[i]); // Parse current version part to int
      if (current < enforced) {
        return true; // If any part of the current version is lower, an update is required
      } else if (current > enforced) {
        return false; // If the current version is higher, no update is needed
      }
    }
    return false; // If all parts are equal, no update is needed
  }

  // This function displays a dialog asking the user to update the app.
  void _showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Prevents the dialog from being dismissed by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Update Required'), // Title of the dialog
          content: const Text(
              'A new version of the app is available. Please update to continue.'), // Content of the dialog
          actions: [
            TextButton(
              onPressed: () {
                // Close the dialog when the 'Update' button is pressed (for now, this should redirect to the app store)
                Navigator.pop(context);
              },
              child: const Text('Update'), // Label of the button
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // Displays the current app version in the center of the screen
      child: Text('Current App Version: $_currentAppVersion'),
    );
  }
}
