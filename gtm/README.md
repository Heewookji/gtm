Gtm is a google-tag-manager plugin.
This package is not an official package. 
Likes help me a lot! 👍

# Table of contents

- [Example](#example)
- [Configuration](#configuration)
  - [Firebase Analytics](#firebase-analytics)
  - [iOS](#ios)
  - [Android](#android)
- [How to use](#how-to-use)
  - [Push event](#push-event)
  - [CustomTag](#customtag)

# Example

```dart
import 'package:gtm/gtm.dart';

// Get instance
final gtm = Gtm.instance;

// Set CustomTagType
gtm.setCustomTagTypes(
  [
    CustomTagType(
      'amplitude',
      handler: (eventName, parameters) {
        print('amplitude!');
        print(eventName);
        print(parameters);
      },
    ),
  ],
);

// Push event
gtm.push(
  'test',
  parameters: {
    'user_no': 912342,
  },
);
```

# Configuration

## Firebase Analytics

![datalayer](https://user-images.githubusercontent.com/46276533/228402526-c6d9c9c7-6099-4696-8f7c-d433a9bb073e.png)

To use this plugin you need to set `Firebase Analytics` up in your project first.
Because `firebase analytics` is playing the role of `datalayer` in the app.

For Firebase settings, you can check to the [Firebase documentation](https://firebase.google.com/docs/analytics/get-started?platform=flutter).

## iOS

You can find more configuration details at [GTM iOS Documentation](https://developers.google.com/tag-platform/tag-manager/ios/v5)

1. Create iOS GTM Container ([https://tagmanager.google.com/?/home](https://tagmanager.google.com/?/home))
2. Download Container version file(GTM-xxxxxxx.json)
3. Put it in `$Project/ios/container`
4. In Xcode, select File - Add files to Runner
5. Select `container` folder with `Create folder references` option

## Android

You can find more configuration details at [GTM Android Documentation](https://developers.google.com/tag-platform/tag-manager/android/v5)

1. Create Android GTM Container ([https://tagmanager.google.com/?/home](https://tagmanager.google.com/?/home))
2. Download Container version file(GTM-xxxxxxx.json)
3. Put it in `$Project/android/app/src/main/assets/containers` (not container)

**Note:** GTM-xxxxxxx.json is used to set initial tag configurations until the first time a container is downloaded. Once the app has connected to the internet and downloaded a container, it will never use the default container again. Applications periodically check for container updates, typically every 12 hours.
</aside>

# **How to use**

## Push event

```dart
// Push event
gtm.push(
  'test',
  parameters: {
    'user_no': 912342,
  },
);
```

Parameter value can be `String`, `bool`, `int`, `double`, `List`, `Map`.

Since `ga4` is used to push events, `ga4` events are automatically triggered(unless you ignore it).

## CustomTag

Sometimes the tags provided by default in gtm are not enough. In this case, custom tag is used. If you want to use a custom tag, you must create the tag in the container with the following rules.

- Set Tag Type to `Function Call`
- Set Class Name/Path
    - `CustomTag` - iOS
    - `kr.heewook.gtm_android.CustomTag` - Android
- Set tagType - this corresponds to the name property of the CustomTagType class

You can refer to the following example.

### iOS example
![iOS example](https://user-images.githubusercontent.com/46276533/228402694-40be41e4-3f12-4de8-94e5-87f3806be116.png)

### Android example
![Android example](https://user-images.githubusercontent.com/46276533/228402946-53f72127-4c24-4a8f-8cfa-62be48ea63a2.png)

### Attached Trigger
![Attached Trigger](https://user-images.githubusercontent.com/46276533/228402997-b4725512-ab6e-4bf6-aa05-4a23596568c6.png)

```dart
// Set CustomTagType
gtm.setCustomTagTypes(
  [
    CustomTagType(
      'amplitude',
      handler: (eventName, parameters) {
        print('amplitude!');
	// will print 'test'
        print(eventName);
        print(parameters);
      },
    ),
  ],
);

// Push event
gtm.push(
  'test',
  parameters: {
    'user_no': 912342,
  },
);
```

Now, you can listen to the CustomTag you want by passing the list of `CustomTagType` to the `setCustomTagTypes` method.

In the `CustomTagType`, specify the `tagType` set in the container earlier, and use the `eventName` and `parameters` in the handler.
