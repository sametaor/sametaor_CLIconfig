# Nu Plugin Desktop Notifications Setup

## Installation

Follow these steps to install the `nu_plugin_desktop_notifications` plugin:

1. **Clone the repository:**
    ```bash
    git clone https://github.com/FMotalleb/nu_plugin_desktop_notifications.git ~/.config/nushell/plugins
    cd nu_plugin_desktop_notifications
    ```

2. **Build the plugin:**
    ```bash
    cargo build -r
    ```

3. **Register the plugin:**
    ```bash
    register target/release/nu_plugin_desktop_notifications
    ```

The plugin will now be available in your Nushell plugins folder and ready to use.