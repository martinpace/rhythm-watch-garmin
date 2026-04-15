# rhythm-watch-garmin

A custom Connect IQ application developed for the Garmin Forerunner 165.

## 🛠 Development Environment Setup

This project is developed using **Cursor** (AI-native IDE) and the **Garmin Connect IQ SDK**. Follow these steps to replicate the environment on a new machine.

### 1. Core Dependencies
* **Java Development Kit (JDK):** Required for the Monkey C compiler.
    * *Recommended:* OpenJDK 11 or 17 (e.g., Eclipse Temurin).
    * *Verification:* Run `java -version` in the terminal.
* **Garmin SDK Manager:** * Download from the [Garmin Developer Portal](https://developer.garmin.com/connect-iq/sdk/).
    * Use the Manager to download the latest **SDK** and the **Forerunner 165 device files**.

### 2. Cursor / VS Code Configuration
* **Extension:** Install the official **Monkey C** extension by Garmin.
* **Language Server Fix:** If you encounter `spawn java ENOENT`, ensure Java is in your System PATH or explicitly set the path in Cursor:
    * `Settings` > `Monkey C: Java Runtime Path` > Path to your `java.exe`.

### 3. Developer Authentication
* **Developer Key:** All builds must be signed.
    * Generate via `Ctrl+Shift+P` > `Monkey C: Generate a Developer Key`.
    * **Note:** Store the `developer_key.der` outside of version control but keep a secure backup.

## 🚀 Building and Running

### Running in Simulator
1. Open the command palette: `Ctrl+Shift+P`.
2. Select `Monkey C: Build Project`.
3. Press `F5` to launch the **Connect IQ Simulator**.
4. Set the device to **Forerunner 165**.

### Sideloading to Physical Watch
To test on your wrist without affecting standard watch operations:
1. Connect the Forerunner 165 via USB.
2. Run `Monkey C: Build for Device`.
3. Copy the generated `.prg` file from `/bin` to the `/GARMIN/APPS` folder on the watch.
4. The app will appear in your Activities/Apps list and can be uninstalled at any time via the watch menu or Garmin Connect.

## 📱 Hardware Targets: Forerunner 165
* **Display:** 390 x 390 pixels (AMOLED).
* **Sensor Focus:** Gyroscope integration for movement-based metronome feedback.
* **Memory Limit:** Ensure bitmaps and resources fit within the device-specific memory heap to prevent app crashes.

## 📝 Project Notes
* **Sandbox Safety:** This application runs in a sandbox and does not modify the underlying Garmin OS or tracking data.
* **Battery Management:** High-frequency sensor polling is used; ensure the app is closed when not in use to preserve standard battery life.
