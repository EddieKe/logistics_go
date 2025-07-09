# PRD: LogisticsGo Showcase App
- This document outlines the design, features, and technical architecture for the "LogisticsGo" mobile application, a portfolio project designed to showcase advanced UI/UX and Flutter development skills.

## 1. Project Overview & Goal 🎯
- LogisticsGo is a UI/UX-focused mobile application prototype for a logistics company.

- The primary goal is not to build a functional product, but to serve as a high-quality portfolio piece. It must demonstrate proficiency in:

- Translating a professional Figma design into a pixel-perfect Flutter application.

- Implementing a scalable and maintainable app structure using Clean Architecture and BLoC.

- Creating a clean, intuitive, and modern user interface.

## 2. Key Features & Screens 📱
- We will implement four main screens. All data will be hardcoded (mocked) within the application.

**Login Screen:**

- A visually appealing, UI-only login screen.

- Fields for "Email" and "Password".

- Buttons for "Sign In", "Forgot Password", and "Sign In with Google".

- Functionality: Tapping "Sign In" will navigate to the Dashboard. No actual authentication will occur.

- Dashboard Screen:

- Displays a summary of user activity.

- A welcome message (e.g., "Hello, [User Name]").

- Key stats displayed in cards (e.g., "Active Shipments", "Completed", "Issues").

- A list of recent shipments with status indicators (e.g., "In Transit", "Delivered").

- A Floating Action Button (FAB) to "Book a New Shipment".

**Booking Screen:**

- A multi-step form to simulate booking a shipment.

- Fields for pickup address, destination address, package details, etc.

- Functionality: A "Confirm Booking" button will show a success dialog and navigate back to the dashboard.

- Shipment Tracking Screen:

- The core UI showcase.

- Displays an embedded Google Map showing a polyline route from a start to an end point.

- Shows shipment details (ID, status, ETA).

- A timeline view of the shipment's progress (e.g., "Picked Up," "In Transit," "Out for Delivery").

## 3. Design Guidelines 🎨
- The visual theme should be modern, clean, and professional, suitable for a logistics/tech company.

**Color Palette:**

**Primary:** A corporate blue (e.g., 0xFF0D47A1).

**Secondary/Accent:** A vibrant orange or yellow (e.g., 0xFFFFA000).

**Background:** Off-white or light gray (e.g., 0xFFF5F5F5).

**Text:** Dark charcoal/black (e.g., 0xFF212121).

**Success:** Green (e.g., 0xFF388E3C), Error: Red (e.g., 0xFFD32F2F).

**Typography:**

**Font:** Poppins or Roboto (from google_fonts package).

**Headings:** Poppins Bold (24pt, 20pt).

**Body:** Roboto Regular (16pt).

**Buttons/Labels:** Roboto Medium (14pt).

**Constants File:**

- All colors, text styles, and common sizes (paddings, border radius) must be defined in a theme folder to ensure consistency.

- Example files: lib/app/theme/app_colors.dart, lib/app/theme/app_text_styles.dart, lib/app/theme/app_sizes.dart.

## 4. App Architecture (README.md Preview) 🏗️
### Folder Structure
- The project will follow Clean Architecture principles.

---
lib/
├── app/
│   ├── di/
│   │   └── service_locator.dart  # get_it setup
│   ├── navigation/
│   │   └── app_router.dart
│   └── theme/
│       ├── app_colors.dart
│       ├── app_sizes.dart
│       └── app_text_styles.dart
│
├── data/
│   ├── datasources/
│   │   └── shipment_mock_datasource.dart # Fake data source
│   ├── models/
│   │   └── shipment_model.dart         # Extends entity, has fromJson/toJson
│   └── repositories/
│       └── shipment_repository_impl.dart
│
├── domain/
│   ├── entities/
│   │   └── shipment_entity.dart        # Pure Dart object
│   ├── repositories/
│   │   └── shipment_repository.dart    # Abstract class
│   └── usecases/
│       ├── get_shipments.dart
│       └── get_shipment_details.dart
│
└── presentation/
    ├── dashboard/
    │   ├── bloc/
    │   │   ├── dashboard_bloc.dart
    │   │   ├── dashboard_event.dart
    │   │   └── dashboard_state.dart
    │   └── view/
    │       └── dashboard_screen.dart
    └── tracking/
        ├── bloc/
        │   ├── tracking_bloc.dart
        │   ├── tracking_event.dart
        │   └── tracking_state.dart
        └── view/
            └── tracking_screen.dart
    ---
### Architectural Layers
**Presentation:** Contains UI (Screens) and State Management (BLoCs). BLoCs will call use cases. The UI will react to states emitted by the BLoC.

**Domain:** The core of the app. Contains business logic (Use Cases), business objects (Entities), and repository contracts (abstract classes). It is pure Dart with no dependencies on Flutter or external packages.

**Data:** Implements the repository contracts. It will fetch data from a Mock DataSource. This layer is responsible for converting data from models (like JSON) to domain entities. In our case, it will just return hardcoded ShipmentModel objects.

**Error Handling:** We will use the dartz package. Use cases will return Future<Either<Failure, SuccessType>>. This forces the UI layer to handle both success and failure states gracefully.

## 5. Technical Specifications & Dependencies 🛠️
**State Management:** flutter_bloc

**Dependency Injection:** get_it

**Functional Programming:** dartz

**Value Equality:** equatable (for BLoC states/events and entities)

**Maps:** Maps_flutter

**Icons/Assets:** flutter_svg (for cleaner icons)

**Fonts:** google_fonts

**APIs Needed**
**Google Maps API Key:** You will need to generate an API key from the Google Cloud Platform console and enable the "Maps SDK for Android" and "Maps SDK for iOS".

