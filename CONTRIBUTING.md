# Contributing

Prior to contributing, please examine the [Code of Conduct][coc] and honor
these at all times.

Prerequisites:
- local webserver if you have Python installed you can simply run `python -m
  SimpleHTTPServer` for version [2.x][py-simplehttpserver]  or `python -m
  http.server` for version [3.x][py-http-server] whenever a webserver is needed
- [Firefox][firefox] or [Chrome][chrome]/[Chromium][chromium]

1. Start local webserver (e.g.: `python -m http.server`)
2. Update screenshots

## Update Screenshots

The table below provides the details for the screenshots which are to be
captured for the different templates..

| [Device Profile in Chrome DevTools][chrome-screens] | [Responsive Design Mode in FIrefox][firefox-screens] | Width (px) | Height (px) | Output file              |
|:----------------------------------------------------|:-----------------------------------------------------|-----------:|------------:|:-------------------------|
| Laptop with HiDPI                                   | Laptop with HiDPI                                    | 1440       | 900         | preview-HiDPI.png        |
| iPhone 6/7/8                                        | iPhone 6/7/8                                         | 375        | 557         | preview-iPhone_6_7_8.png |

### Firefox

<!-- #### GUI -->

Open Firefox to take screenshots:
1. Open [Web Console][firefox-screenshots] (by pressing **Ctrl + Shift + K**
   navigating from the menu "Tools" > "Web Developer" > "Web Console")
2. Enable the responsive design mode (by clicking the "Responsive Design
   Mode" button or pressing **Ctrl + Shift + M**)
3. Select the device for which to capture screenshot
4. Click "Take a screenshot of the viewport" Open the command prompt (by clicking "Run Command" from the dev tools menu
   or pressing **Ctrl + Shift + P**)
5. Enter `:screenshot` or select "Capture full size screenshot" into the
   command prompt and save 
6. Repeat for the devices listed in the table below

### Chrome/Chromium

<!-- #### GUI -->

Open Chrome/Chromium to take screenshots:
1. [Open Developer Tools][open-chrome-devtools] (by right clicking anwhere on
   the page and selecting "Inspect" or pressing **Ctrl + Shift + I**)
2. Enable the device toolbar (by clicking the "Toggle Device Toolbar" icon or
   pressing **Ctrl + Shift + M**)
3. Select the device for which to capture screenshot
4. Open the command prompt (by clicking "Run Command" from the dev tools menu
   or pressing **Ctrl + Shift + P**)
5. Enter `:screenshot` or select "Capture full size screenshot" into the
   command prompt and save 
6. Repeat for the devices listed in the table below

[chrome]: https://www.google.com/chrome/
[chromium]: https://www.chromium.org/Home
[firefox]: 
[moz-screenshots]: https://developer.mozilla.org/en-US/docs/Tools/Taking_screenshots
[py-simplehttpserver]: https://docs.python.org/2/library/simplehttpserver.html
[py-http-server]: https://docs.python.org/3/library/http.server.html
[2ality-py-server]: https://2ality.com/2014/06/simple-http-server.html
[moz-py-server]: https://developer.mozilla.org/en-US/docs/Learn/Common_questions/set_up_a_local_testing_server
[chrome-screens]: https://developers.google.com/web/tools/chrome-devtools/device-mode#viewport
[firefox-screens]: https://developer.mozilla.org/en-US/docs/Tools/Responsive_Design_Mode
[open-chrome-devtools]: https://developers.google.com/web/tools/chrome-devtools/#open
[coc]: ./CODE_OF_CONDUCT.md
