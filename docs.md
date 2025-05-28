# Home Assistant Add-on: Heimdall

Heimdall is an elegant solution to organize all your web applications. It's dedicated to this purpose so you won't lose your links in a sea of bookmarks.

## Installation

Follow these steps to get the add-on installed on your system:

1. Navigate in your Home Assistant frontend to **Supervisor** → **Add-on Store**.
2. Add the repository URL: `https://github.com/MeighenHouse/heimdall-hassio-addon`
3. Find the "Heimdall" add-on and click it.
4. Click on the "INSTALL" button.

## How to use

1. Set the add-on options to your preferences
2. Save the configuration.
3. Start the add-on.
4. Check the add-on log output to see the result.
5. Open the Web UI using the "OPEN WEB UI" button

## Configuration

Add-on configuration:

```yaml
http_port: 80
https_port: 443
ssl: false
certfile: fullchain.pem
keyfile: privkey.pem
```

### Option: `http_port` (required)

The port number for HTTP access to Heimdall. Default is 80.

### Option: `https_port` (required)

The port number for HTTPS access to Heimdall when SSL is enabled. Default is 443.

### Option: `ssl` (required)

Enables/Disables SSL (HTTPS) on Heimdall. Set it `true` to enable it, `false` otherwise.

### Option: `certfile` (required)

The certificate file to use for SSL. If SSL is enabled, this file must exist in the `/ssl/` directory.

### Option: `keyfile` (required)

The private key file to use for SSL. If SSL is enabled, this file must exist in the `/ssl/` directory.

## Support

Got questions?

You have several options to get them answered:

- The [Home Assistant Discord Chat Server][discord].
- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

In case you've found a bug, please [open an issue on GitHub][issue].

[discord]: https://discord.gg/c5DvZ4e
[forum]: https://community.home-assistant.io
[issue]: https://github.com/yourusername/heimdall-hassio-addon/issues
[reddit]: https://reddit.com/r/homeassistant
[repository]: https://github.com/yourusername/heimdall-hassio-addon

## Changelog

All notable changes to this project will be documented in the CHANGELOG.md file.

## Authors & contributors

The original setup of this repository is by [Your Name].

## License

MIT License

Copyright (c) 2025

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
