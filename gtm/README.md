# README

# gtm

gtm is a google-tag-manager plugin.

## Example

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

## Configuration

### Firebase Analytics

![Untitled](README%20b8e16e002d9542a5adfc2e91cbf96fcc/Untitled.png)

To use this plugin you need to set `Firebase Analytics` up in your project first.
Because `firebase analytics` is playing the role of `datalayer` in the app.

For Firebase settings, you can check to the [Firebase documentation](https://firebase.google.com/docs/analytics/get-started?platform=flutter).

### iOS

You can find more configuration details at [GTM iOS Documentation](https://developers.google.com/tag-platform/tag-manager/ios/v5)

1. Create iOS GTM Container ([https://tagmanager.google.com/?/home](https://tagmanager.google.com/?/home))
2. Download Container version file(GTM-xxxxxxx.json)
3. Put it in `$Project/ios/container`
4. In Xcode, select File - Add files to Runner
5. Select `container` folder with `Create folder references` option

### Android

You can find more configuration details at [GTM Android Documentation](https://developers.google.com/tag-platform/tag-manager/android/v5)

1. Create Android GTM Container ([https://tagmanager.google.com/?/home](https://tagmanager.google.com/?/home))
2. Download Container version file(GTM-xxxxxxx.json)
3. Put it in `$Project/android/app/src/main/assets/containers` (not container)

<aside>
💡 GTM-xxxxxxx.json is used when setting up GTM on first launch of the app and when the app is offline. Otherwise, the latest version of the GTM container is automatically reflected.

</aside>

## **How to use**

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

Parameter value can be `String`, `bool`, `num`.

Since `ga4` is used to push events, `ga4` events are automatically triggered(unless you ignore it).

### CustomTag

Sometimes the tags provided by default in gtm are not enough. In this case, custom tag is used. If you want to use a custom tag, you must create the tag in the container with the following rules.

- Set Tag Type to `Function Call`
- Set Class Name/Path
    - `CustomTag` - iOS
    - `kr.heewook.gtm_android.CustomTag` - Android
- Set tagType - this corresponds to the name property of the CustomTagType class

You can refer to the following example.

![iOS example](README%20b8e16e002d9542a5adfc2e91cbf96fcc/Untitled%201.png)

iOS example

![Android example](README%20b8e16e002d9542a5adfc2e91cbf96fcc/Untitled%202.png)

Android example

![Attached Trigger](README%20b8e16e002d9542a5adfc2e91cbf96fcc/Untitled%203.png)

Attached Trigger

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
