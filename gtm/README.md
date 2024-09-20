<p align="center"><img src="https://github.com/Heewookji/gtm/assets/46276533/e74377a4-5df9-4ade-9e86-4be6bf6e66f4"></p>

Gtm is a google-tag-manager plugin.

This package is not an official package.

# Table of contents

- [Example](#example)
- [Configuration](#configuration)
  - [iOS, Android](#ios-android)
  - [Web](#web)
- [How to use](#how-to-use)
  - [iOS, Android](#ios-android-1)
    - [Push event](#push-event)
    - [CustomTag](#customtag)
  - [Web](#web-1)
    - [Push event](#push-event-1)
    - [CustomTag](#customtag-1)

# Example

```dart
import 'package:gtm/gtm.dart';

// Get instance
final gtm = Gtm.instance;

// Set CustomTagType
// Only work on ios and android platforms.
// On web platform It will throw an UnimplementedError.
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

## iOS, Android

### Firebase Analytics

To use this plugin on mobile, you need to set `Firebase Analytics` up in your project first.
Because `firebase analytics` is playing the role of `datalayer`.

For Firebase settings, you can check to the [Firebase documentation](https://firebase.google.com/docs/analytics/get-started?platform=flutter).

### iOS

You can find more configuration details at [GTM iOS Documentation](https://developers.google.com/tag-platform/tag-manager/ios/v5)

1. [Create iOS GTM Container](https://tagmanager.google.com/?/home)
2. Download Container version file(GTM-xxxxxxx.json)
3. Put it in `$Project/ios/container`
4. In Xcode, select File - Add files to Runner
5. Select `container` folder with `Create folder references` option

### Android

You can find more configuration details at [GTM Android Documentation](https://developers.google.com/tag-platform/tag-manager/android/v5)

1. [Create Android GTM Container](https://tagmanager.google.com/?/home)
2. Download Container version file(GTM-xxxxxxx.json)
3. Put it in `$Project/android/app/src/main/assets/containers` (not container)

**Note:** GTM-xxxxxxx.json is used to set initial tag configurations until the first time a container is downloaded. Once the app has connected to the internet and downloaded a container, it will never use the default container again. Applications periodically check for container updates, typically every 12 hours.
</aside>

## Web

1. [Create Web GTM Container](https://tagmanager.google.com/?/home)
2. Add [code snippet](https://support.google.com/tagmanager/answer/14847097) to `web/index.html`

# How to use

## iOS, Android

### Push event

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

### CustomTag

Sometimes the tags provided by default in gtm are not enough. In this case, custom tag is used. If you want to use a custom tag, you must create the tag in the container with the following rules.

- Set Tag Type to `Function Call`
- Set Class Name/Path
    - `CustomTag` - iOS
    - `kr.heewook.gtm_android.CustomTag` - Android
- Set tagType - this corresponds to the name property of the CustomTagType class

You can refer to the following example.

#### iOS example
![iOS example](https://user-images.githubusercontent.com/46276533/228402694-40be41e4-3f12-4de8-94e5-87f3806be116.png)

#### Android example
![Android example](https://user-images.githubusercontent.com/46276533/228402946-53f72127-4c24-4a8f-8cfa-62be48ea63a2.png)

#### Attached Trigger
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


## Web

### Push event

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

### CustomTag

Unlike iOS and Android platforms, you need to set custom tags inside the web gtm container, not in code.

If the tag you are looking for is not provided by default and is not in the gallery, you can implement it yourself through Custom Html.
