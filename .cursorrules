---
trigger: always_on
---

# Yellow Pass Developer & AI Coding Rules

This file establishes the architecture, code conventions, styling guidelines, and structures for the **Yellow Pass** Flutter application. Follow these rules consistently whenever generating code or analyzing the workspace.

---

## 1. Project Directory Structure
All new features, widgets, and service methods must align with this folder layout:

- **`lib/ApiServices/`**: Contains the API client implementation (`api_service.dart`), route paths/endpoints (`api_end_points.dart`), and network info/error handling.
- **`lib/core/`**:
  - `theme/`: Light and dark application theme specifications (`light_theme.dart`, `dark_theme.dart`).
  - `utils/`: Global constants (`color_constant.dart`, `image_constant.dart`, `string_constant.dart`), helpers, sizing utilities (`size_utils.dart`), and shared preferences (`shared_prefs.dart`, `pref_utils.dart`).
- **`lib/data/`**: Data layer holding serialization schemas (`models/`) for requests and responses.
- **`lib/packages/`**: Custom, vendored, or wrapper packages (e.g., `OverlayLoading`).
- **`lib/presentation/`**: Screen layouts grouped by feature namespace (e.g., `splash_screen/`, `home_screen/`).
- **`lib/routes/`**: Handles routing paths and pages configuration (`app_routes.dart`).
- **`lib/widgets/`**: Reusable global UI widgets (e.g., elevated buttons, custom text fields, image viewers).

---

## 2. State Management & Architecture Rules (GetX)
The project utilizes **GetX** for dependency injection, navigation, and state management.

- **Feature Directory Structure**: Each screen directory in `lib/presentation/<feature_screen_name>/` must contain:
  - `binding/`: `<feature_screen_name>_binding.dart` (defining `Get.lazyPut(() => FeatureController())`).
  - `controller/`: `<feature_screen_name>_controller.dart` (extends `GetxController`).
  - `repository/`: `<feature_screen_name>_repository.dart` (handles data fetching for this specific feature via `ApiService`).
  - `<feature_screen_name>.dart`: The UI page component extending either `GetWidget<FeatureController>` or standard `StatelessWidget`/`StatefulWidget` with controller lookup.
- **UI & Logic Separation**: No network requests or heavy business logic should exist directly in UI widgets. The UI should only trigger controller methods and react to state changes using `Obx` or `GetBuilder`.
- **Navigation**:
  - Register routing names and pages list inside `AppRoutes` (`lib/routes/app_routes.dart`).
  - Use `Get.toNamed()`, `Get.offNamed()`, or `Get.offAllNamed()` for page transitions.
- **Resource Management**: Dispose controllers and cancel active streams/subscriptions within the controller's `onClose()` or screen's `dispose()` lifecycle.

---

## 3. Responsive Layout & Sizing Rules
All size parameters (width, height, padding, margins, font sizes) must be scaled dynamically to ensure multi-screen compatibility.
- Design base dimensions: **360px width** and **759px height**.
- **Sizing Functions** (`lib/core/utils/size_utils.dart`):
  - Use `getWidth(double px)` for widths, horizontal padding, and horizontal margins.
  - Use `getHeight(double px)` for heights, vertical padding, vertical margins, and line/border thickness.
  - Use `getFontSize(double px)` for all `fontSize` declarations.

*Example:*
```dart
Container(
  width: getWidth(120),
  height: getHeight(50),
  padding: EdgeInsets.symmetric(
    horizontal: getWidth(16),
    vertical: getHeight(12),
  ),
  child: Text(
    "Label",
    style: TextStyle(fontSize: getFontSize(14)),
  ),
)
```

---

## 4. UI Theming, Colors, & Typography
- **Typography** (`lib/theme/app_style.dart`): Use text styles defined under `AppStyle` which utilize the **Gilroy** font family family variants:
  - `Gilroy-Bold` via `AppStyle.txtGilroy` or `AppStyle.txtGilroyBold`
  - `Gilroy-Medium` via `AppStyle.txtGilroyMedium`
  - `Gilroy-SemiBold` via `AppStyle.txtGilroySemiBold`
  - `Gilroy-ExtraBold` via `AppStyle.txtGilroyExtraBold`
- **Colors** (`lib/core/utils/color_constant.dart`): Always use `ColorConstant` for project-specific custom colors (e.g., `ColorConstant.primaryColor`, `ColorConstant.textGreyColor`) or retrieve them via `Theme.of(context).colorScheme`.
- **Theme Definition**: Core themes are configured using `FlexThemeData` from `flex_color_scheme` inside `lib/main.dart` with color schemes defined in `lib/core/theme/`.

---

## 5. Common Reusable Widgets
Avoid recreating standard layout elements. Use the existing global widgets defined under `lib/widgets/`:
1. **`CustomImageView`** (`lib/widgets/custom_image_view.dart`):
   - Use for loading network images (uses cached network image with shimmer loaders), asset SVGs, PNGs, and local files.
   - Automatically handles fallback placeholder assets.
2. **`AppElevatedButton` & `AppElevatedButton2`** (`lib/widgets/custom_elavated_button.dart`):
   - Standardized action buttons featuring built-in loading status, gradients, and custom SVGs support.
3. **`CommonTextField`** (`lib/widgets/custom_app_text_form_field.dart`):
   - Text inputs with customized styling, pre-configured borders, and suffix/prefix icon integrations.
4. **`BouncingButton`** (`lib/widgets/bouncing_button.dart`):
   - Wrap interactive items in this widget to add scale-based interactive feedback animations on tap.

---

## 6. API Services & Data Integration
- **Endpoints**: Always add paths to `ApiEndPoints` inside `lib/ApiServices/api_end_points.dart`. Do not hardcode URL strings.
- **HTTP Client**: Use `ApiService` (`lib/ApiServices/api_service.dart`) which extends `GetConnect`. Make all GET, POST, PUT, and Multipart requests via its wrapper functions:
  - `callGetApi(...)`
  - `callPostApi(...)`
  - `callPutApi(...)`
  - `uploadMultipart(...)`
- **Error Handling**: `ApiService` automatically parses network errors, unauthorized status codes (automatically redirecting to login on 401), and logs response patterns.
- **Model Parsing**: Map response maps to strongly-typed Dart model classes placed inside `lib/data/models/`.

---

## 7. Persistent Storage
- Use `SharedPrefs` (`lib/core/utils/shared_prefs.dart`) or `PrefUtils` (`lib/core/utils/pref_utils.dart`) to store/retrieve localized keys such as auth tokens, user profiles, or cached onboarding flags.
- **Avoid** initializing `SharedPreferences` instances manually outside these utility classes.

---

## 8. Best Practices & Guidelines
- **Import Statements**: Prefer package relative imports (e.g., `import 'package:yellow_pass/core/utils/...'`) over relative path imports (e.g., `import '../../core/utils/...'`) for high-level structure clarity.
- **Safety**: Ensure null safety configurations are strictly followed. Use optional chaining (`?.`) and fallback operators (`??`) when working with dynamic JSON payloads.
- **UI Feedback**: Use `OverlayLoading` wrapper package logic (`startLoadingOverlay()` / `stopLoadingOverlay()`) from `CommonConstant` for blocking loading overlays.
