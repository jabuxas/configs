# Load existing settings made via :set
config.load_autoconfig()
solarized = {
    "base03": "#002b36",
    "base02": "#073642",
    "base01": "#586e75",
    "base00": "#657b83",
    "base0": "#839496",
    "base1": "#93a1a1",
    "base2": "#eee8d5",
    "base3": "#fdf6e3",
    "yellow": "#b58900",
    "orange": "#cb4b16",
    "red": "#dc322f",
    "magenta": "#d33682",
    "violet": "#6c71c4",
    "blue": "#268bd2",
    "cyan": "#2aa198",
    "green": "#859900",
}

## This is here so configs done via the GUI are still loaded.
## Remove it to not load settings done via the GUI.
# config.load_autoconfig()

## Aliases for commands. The keys of the given dictionary are the
## aliases, while the values are the commands they map to.
## Type: Dict
c.aliases = {"w": "session-save", "q": "close", "wq": "quit --save"}

## How often (in milliseconds) to auto-save config/cookies/etc.
## Type: Int
# c.auto_save.interval = 15000

## Always restore open sites when qutebrowser is reopened.
## Type: Bool
# c.auto_save.session = False

## The backend to use to display websites. qutebrowser supports two
## different web rendering engines / backends, QtWebKit and QtWebEngine.
## QtWebKit was discontinued by the Qt project with Qt 5.6, but picked up
## as a well maintained fork: https://github.com/annulen/webkit/wiki -
## qutebrowser only supports the fork. QtWebEngine is Qt's official
## successor to QtWebKit. It's slightly more resource hungry that
## QtWebKit and has a couple of missing features in qutebrowser, but is
## generally the preferred choice. This setting requires a restart.
## Type: String
## Valid values:
##   - webengine: Use QtWebEngine (based on Chromium)
##   - webkit: Use QtWebKit (based on WebKit, similar to Safari)
# c.backend = 'webengine'

## This setting can be used to map keys to other keys. When the key used
## as dictionary-key is pressed, the binding for the key used as
## dictionary-value is invoked instead. This is useful for global
## remappings of keys, for example to map Ctrl-[ to Escape. Note that
## when a key is bound (via `bindings.default` or `bindings.commands`),
## the mapping is ignored.
## Type: Dict
# c.bindings.key_mappings = {'<Ctrl-[>': '<Escape>', '<Ctrl-6>': '<Ctrl-^>', '<Ctrl-M>': '<Return>', '<Ctrl-J>': '<Return>', '<Shift-Return>': '<Return>', '<Enter>': '<Return>', '<Shift-Enter>': '<Return>', '<Ctrl-Enter>': '<Ctrl-Return>'}

## Background color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.bg = solarized["base03"]

## Bottom border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.bottom = solarized["base03"]

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.category.border.top = solarized["base03"]

## Foreground color of completion widget category headers.
## Type: QtColor
c.colors.completion.category.fg = solarized["base3"]

## Background color of the completion widget for even rows.
## Type: QssColor
c.colors.completion.even.bg = solarized["base02"]

## Text color of the completion widget.
## Type: QtColor
c.colors.completion.fg = solarized["base1"]

## Background color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.bg = solarized["cyan"]

## Bottom border color of the selected completion item.
## Type: QssColor
c.colors.completion.item.selected.border.bottom = solarized["cyan"]

## Top border color of the completion widget category headers.
## Type: QssColor
c.colors.completion.item.selected.border.top = solarized["cyan"]

## Foreground color of the selected completion item.
## Type: QtColor
c.colors.completion.item.selected.fg = solarized["base3"]

## Foreground color of the matched text in the completion.
## Type: QssColor
c.colors.completion.match.fg = solarized["base2"]

## Background color of the completion widget for odd rows.
## Type: QssColor
c.colors.completion.odd.bg = solarized["base02"]

## Color of the scrollbar in completion view
## Type: QssColor
c.colors.completion.scrollbar.bg = solarized["base1"]

## Color of the scrollbar handle in completion view.
## Type: QssColor
c.colors.completion.scrollbar.fg = solarized["base2"]

## Background color for the download bar.
## Type: QssColor
c.colors.downloads.bar.bg = solarized["base03"]

## Background color for downloads with errors.
## Type: QtColor
c.colors.downloads.error.bg = solarized["red"]

## Foreground color for downloads with errors.
## Type: QtColor
c.colors.downloads.error.fg = solarized["base3"]

## Color gradient start for download backgrounds.
## Type: QtColor
# c.colors.downloads.start.bg = '#0000aa'

## Color gradient start for download text.
## Type: QtColor
c.colors.downloads.start.fg = solarized["base3"]

## Color gradient stop for download backgrounds.
## Type: QtColor
# c.colors.downloads.stop.bg = '#00aa00'

## Color gradient end for download text.
## Type: QtColor
# c.colors.downloads.stop.fg = solarized['base3']

## Color gradient interpolation system for download backgrounds.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.downloads.system.bg = 'rgb'

## Color gradient interpolation system for download text.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.downloads.system.fg = 'rgb'

## Background color for hints. Note that you can use a `rgba(...)` value
## for transparency.
## Type: QssColor
c.colors.hints.bg = solarized["violet"]

## Font color for hints.
## Type: QssColor
c.colors.hints.fg = solarized["base3"]

## Font color for the matched part of hints.
## Type: QssColor
c.colors.hints.match.fg = solarized["base1"]

## Background color of the keyhint widget.
## Type: QssColor
# c.colors.keyhint.bg = 'rgba(0, 0, 0, 80%)'

## Text color for the keyhint widget.
## Type: QssColor
c.colors.keyhint.fg = solarized["base3"]

## Highlight color for keys to complete the current keychain.
## Type: QssColor
c.colors.keyhint.suffix.fg = solarized["yellow"]

## Background color of an error message.
## Type: QssColor
c.colors.messages.error.bg = solarized["red"]

## Border color of an error message.
## Type: QssColor
c.colors.messages.error.border = solarized["red"]

## Foreground color of an error message.
## Type: QssColor
c.colors.messages.error.fg = solarized["base3"]

## Background color of an info message.
## Type: QssColor
c.colors.messages.info.bg = solarized["base03"]

## Border color of an info message.
## Type: QssColor
c.colors.messages.info.border = solarized["base03"]

## Foreground color an info message.
## Type: QssColor
c.colors.messages.info.fg = solarized["base3"]

## Background color of a warning message.
## Type: QssColor
c.colors.messages.warning.bg = solarized["orange"]

## Border color of a warning message.
## Type: QssColor
c.colors.messages.warning.border = solarized["orange"]

## Foreground color a warning message.
## Type: QssColor
c.colors.messages.warning.fg = solarized["base3"]

## Background color for prompts.
## Type: QssColor
c.colors.prompts.bg = solarized["base02"]

## Border used around UI elements in prompts.
## Type: String
c.colors.prompts.border = "1px solid " + solarized["base3"]

## Foreground color for prompts.
## Type: QssColor
c.colors.prompts.fg = solarized["base3"]

## Background color for the selected item in filename prompts.
## Type: QssColor
c.colors.prompts.selected.bg = solarized["base01"]

## Background color of the statusbar in caret mode.
## Type: QssColor
c.colors.statusbar.caret.bg = solarized["blue"]

## Foreground color of the statusbar in caret mode.
## Type: QssColor
c.colors.statusbar.caret.fg = solarized["base1"]

## Background color of the statusbar in caret mode with a selection.
## Type: QssColor
c.colors.statusbar.caret.selection.bg = solarized["violet"]

## Foreground color of the statusbar in caret mode with a selection.
## Type: QssColor
c.colors.statusbar.caret.selection.fg = solarized["base1"]

## Background color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.bg = solarized["base03"]

## Foreground color of the statusbar in command mode.
## Type: QssColor
c.colors.statusbar.command.fg = solarized["base1"]

## Background color of the statusbar in private browsing + command mode.
## Type: QssColor
c.colors.statusbar.command.private.bg = solarized["base01"]

## Foreground color of the statusbar in private browsing + command mode.
## Type: QssColor
c.colors.statusbar.command.private.fg = solarized["base3"]

## Background color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.bg = solarized["base02"]

## Foreground color of the statusbar in insert mode.
## Type: QssColor
c.colors.statusbar.insert.fg = solarized["base1"]

## Background color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.bg = solarized["base03"]

## Foreground color of the statusbar.
## Type: QssColor
c.colors.statusbar.normal.fg = solarized["base1"]

## Background color of the statusbar in passthrough mode.
## Type: QssColor
c.colors.statusbar.passthrough.bg = solarized["base02"]

## Foreground color of the statusbar in passthrough mode.
## Type: QssColor
c.colors.statusbar.passthrough.fg = solarized["base1"]

## Background color of the statusbar in private browsing mode.
## Type: QssColor
c.colors.statusbar.private.bg = solarized["base01"]

## Foreground color of the statusbar in private browsing mode.
## Type: QssColor
c.colors.statusbar.private.fg = solarized["base3"]

## Background color of the progress bar.
## Type: QssColor
c.colors.statusbar.progress.bg = solarized["base1"]

## Foreground color of the URL in the statusbar on error.
## Type: QssColor
c.colors.statusbar.url.error.fg = solarized["red"]

## Default foreground color of the URL in the statusbar.
## Type: QssColor
c.colors.statusbar.url.fg = solarized["base1"]

## Foreground color of the URL in the statusbar for hovered links.
## Type: QssColor
c.colors.statusbar.url.hover.fg = solarized["base2"]

## Foreground color of the URL in the statusbar on successful load
## (http).
## Type: QssColor
c.colors.statusbar.url.success.http.fg = solarized["base1"]

## Foreground color of the URL in the statusbar on successful load
## (https).
## Type: QssColor
c.colors.statusbar.url.success.https.fg = solarized["base1"]

## Foreground color of the URL in the statusbar when there's a warning.
## Type: QssColor
c.colors.statusbar.url.warn.fg = solarized["yellow"]

## Background color of the tab bar.
## Type: QtColor
# c.colors.tabs.bar.bg = '#555555'

## Background color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.bg = solarized["base02"]

## Foreground color of unselected even tabs.
## Type: QtColor
c.colors.tabs.even.fg = solarized["base1"]

## Color for the tab indicator on errors.
## Type: QtColor
c.colors.tabs.indicator.error = solarized["red"]

## Color gradient start for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.start = solarized["violet"]

## Color gradient end for the tab indicator.
## Type: QtColor
c.colors.tabs.indicator.stop = solarized["orange"]

## Color gradient interpolation system for the tab indicator.
## Type: ColorSystem
## Valid values:
##   - rgb: Interpolate in the RGB color system.
##   - hsv: Interpolate in the HSV color system.
##   - hsl: Interpolate in the HSL color system.
##   - none: Don't show a gradient.
# c.colors.tabs.indicator.system = 'rgb'

## Background color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.bg = solarized["base03"]

## Foreground color of unselected odd tabs.
## Type: QtColor
c.colors.tabs.odd.fg = solarized["base1"]

## Background color of selected even tabs.
## Type: QtColor
c.colors.tabs.selected.even.bg = solarized["cyan"]

## Foreground color of selected even tabs.
## Type: QtColor
c.colors.tabs.selected.even.fg = solarized["base2"]

## Background color of selected odd tabs.
## Type: QtColor
c.colors.tabs.selected.odd.bg = solarized["cyan"]

## Foreground color of selected odd tabs.
## Type: QtColor
c.colors.tabs.selected.odd.fg = solarized["base2"]

## Background color for webpages if unset (or empty to use the theme's
## color)
## Type: QtColor
# c.colors.webpage.bg = 'white'

## How many commands to save in the command history. 0: no history / -1:
## unlimited
## Type: Int
# c.completion.cmd_history_max_items = 100

## Delay in ms before updating completions after typing a character.
## Type: Int
# c.completion.delay = 0

## The height of the completion, in px or as percentage of the window.
## Type: PercOrInt
c.completion.height = "40%"

## Minimum amount of characters needed to update completions.
## Type: Int
# c.completion.min_chars = 1

## Move on to the next part when there's only one possible completion
## left.
## Type: Bool
# c.completion.quick = True

## Padding of scrollbar handle in the completion window (in px).
## Type: Int
# c.completion.scrollbar.padding = 2

## Width of the scrollbar in the completion window (in px).
## Type: Int
# c.completion.scrollbar.width = 12

## When to show the autocompletion window.
## Type: String
## Valid values:
##   - always: Whenever a completion is available.
##   - auto: Whenever a completion is requested.
##   - never: Never.
# c.completion.show = 'always'

## Shrink the completion to be smaller than the configured size if there
## are no scrollbars.
## Type: Bool
# c.completion.shrink = False

## How to format timestamps (e.g. for the history completion).
## Type: TimestampTemplate
# c.completion.timestamp_format = '%Y-%m-%d'

## Whether to execute the best-matching command on a partial match.
## Type: Bool
# c.completion.use_best_match = False

## How many URLs to show in the web history. 0: no history / -1:
## unlimited
## Type: Int
# c.completion.web_history_max_items = -1

## Whether quitting the application requires a confirmation.
## Type: ConfirmQuit
## Valid values:
##   - always: Always show a confirmation.
##   - multiple-tabs: Show a confirmation if multiple tabs are opened.
##   - downloads: Show a confirmation if downloads are running
##   - never: Never show a confirmation.
# c.confirm_quit = ['never']

## Whether support for the HTML 5 web application cache feature is
## enabled. An application cache acts like an HTTP cache in some sense.
## For documents that use the application cache via JavaScript, the
## loader engine will first ask the application cache for the contents,
## before hitting the network.
## Type: Bool
# c.content.cache.appcache = True

## The maximum number of pages to hold in the global memory page cache.
## The Page Cache allows for a nicer user experience when navigating
## forth or back to pages in the forward/back history, by pausing and
## resuming up to _n_ pages. For more information about the feature,
## please refer to: http://webkit.org/blog/427/webkit-page-cache-i-the-
## basics/
## Type: Int
# c.content.cache.maximum_pages = 0

## Size of the HTTP network cache. Null to use the default value.
## Type: Int
# c.content.cache.size = None

## Control which cookies to accept.
## Type: String
## Valid values:
##   - all: Accept all cookies.
##   - no-3rdparty: Accept cookies from the same origin only.
##   - no-unknown-3rdparty: Accept cookies from the same origin only, unless a cookie is already set for the domain.
##   - never: Don't accept cookies at all.
# c.content.cookies.accept = 'no-3rdparty'

## Store cookies. Note this option needs a restart with QtWebEngine on Qt
## < 5.9.
## Type: Bool
# c.content.cookies.store = True

## Default encoding to use for websites. The encoding must be a string
## describing an encoding such as _utf-8_, _iso-8859-1_, etc.
## Type: String
# c.content.default_encoding = 'iso-8859-1'

## Enable extra tools for Web developers. This needs to be enabled for
## `:inspector` to work and also adds an _Inspect_ entry to the context
## menu. For QtWebEngine, see `--enable-webengine-inspector` in
## `qutebrowser --help` instead.
## Type: Bool
# c.content.developer_extras = False

## Try to pre-fetch DNS entries to speed up browsing.
## Type: Bool
# c.content.dns_prefetch = True

## Expand each subframe to its contents. This will flatten all the frames
## to become one scrollable page.
## Type: Bool
# c.content.frame_flattening = False

## Allow websites to request geolocations.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.geolocation = 'ask'

## Value to send in the `Accept-Language` header.
## Type: String
# c.content.headers.accept_language = 'en-US,en'

## Set custom headers for qutebrowser HTTP requests.
## Type: Dict
# c.content.headers.custom = {}

## Value to send in the `DNT` header. When this is set to true,
## qutebrowser asks websites to not track your identity. If set to null,
## the DNT header is not sent at all.
## Type: Bool
# c.content.headers.do_not_track = True

## Send the Referer header. The Referer header tells websites from which
## website you were coming from when visting them.
## Type: String
## Valid values:
##   - always: Always send the Referer.
##   - never: Never send the Referer. This is not recommended, as some sites may break.
##   - same-domain: Only send the Referer for the same domain. This will still protect your privacy, but shouldn't break any sites.
# c.content.headers.referer = 'same-domain'

## User agent to send. Unset to send the default.
## Type: String
# c.content.headers.user_agent = None

## Whether host blocking is enabled.
## Type: Bool
# c.content.host_blocking.enabled = True

## List of URLs of lists which contain hosts to block.  The file can be
## in one of the following formats:  - An `/etc/hosts`-like file - One
## host per line - A zip-file of any of the above, with either only one
## file, or a file named   `hosts` (with any extension).
## Type: List of Url
# c.content.host_blocking.lists = ['https://www.malwaredomainlist.com/hostslist/hosts.txt', 'http://someonewhocares.org/hosts/hosts', 'http://winhelp2002.mvps.org/hosts.zip', 'http://malwaredomains.lehigh.edu/files/justdomains.zip', 'https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&mimetype=plaintext']

## List of domains that should always be loaded, despite being ad-
## blocked. Domains may contain * and ? wildcards and are otherwise
## required to exactly match the requested domain. Local domains are
## always exempt from hostblocking.
## Type: List of String
# c.content.host_blocking.whitelist = ['piwik.org']

## Enable or disable hyperlink auditing (`<a ping>`).
## Type: Bool
# c.content.hyperlink_auditing = False

## Whether images are automatically loaded in web pages.
## Type: Bool
# c.content.images = True

## Show javascript alerts.
## Type: Bool
# c.content.javascript.alert = True

## Whether JavaScript can read from or write to the clipboard. With
## QtWebEngine, writing the clipboard as response to a user interaction
## is always allowed.
## Type: Bool
# c.content.javascript.can_access_clipboard = False

## Whether JavaScript can close tabs.
## Type: Bool
# c.content.javascript.can_close_tabs = False

## Whether JavaScript can open new tabs without user interaction.
## Type: Bool
# c.content.javascript.can_open_tabs_automatically = False

## Enables or disables JavaScript.
## Type: Bool
# c.content.javascript.enabled = True

## Log levels to use for JavaScript console logging messages. When a
## JavaScript message with the level given in the dictionary key is
## logged, the corresponding dictionary value selects the qutebrowser
## logger to use. On QtWebKit, the "unknown" setting is always used.
## Type: Dict
# c.content.javascript.log = {'unknown': 'debug', 'info': 'debug', 'warning': 'debug', 'error': 'debug'}

## Use the standard JavaScript modal dialog for `alert()` and `confirm()`
## Type: Bool
# c.content.javascript.modal_dialog = False

## Show javascript prompts.
## Type: Bool
# c.content.javascript.prompt = True

## Whether locally loaded documents are allowed to access other local
## urls.
## Type: Bool
# c.content.local_content_can_access_file_urls = True

## Whether locally loaded documents are allowed to access remote urls.
## Type: Bool
# c.content.local_content_can_access_remote_urls = False

## Whether support for HTML 5 local storage and Web SQL is enabled.
## Type: Bool
# c.content.local_storage = True

## Allow websites to record audio/video.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.media_capture = 'ask'

## Location of a netrc-file for HTTP authentication. If unset, `~/.netrc`
## is used.
## Type: File
# c.content.netrc_file = None

## Allow websites to show notifications.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.notifications = 'ask'

## Enable pdf.js to view PDF files in the browser. Note that the files
## can still be downloaded by clicking the download button in the pdf.js
## viewer.
## Type: Bool
# c.content.pdfjs = False

## Enables or disables plugins in Web pages.
## Type: Bool
# c.content.plugins = False

## Whether the background color and images are also drawn when the page
## is printed.
## Type: Bool
# c.content.print_element_backgrounds = True

## Open new windows in private browsing mode which does not record
## visited pages.
## Type: Bool
# c.content.private_browsing = False

## The proxy to use. In addition to the listed values, you can use a
## `socks://...` or `http://...` URL.
## Type: Proxy
## Valid values:
##   - system: Use the system wide proxy.
##   - none: Don't use any proxy
# c.content.proxy = 'system'

## Send DNS requests over the configured proxy.
## Type: Bool
# c.content.proxy_dns_requests = True

## Validate SSL handshakes.
## Type: BoolAsk
## Valid values:
##   - true
##   - false
##   - ask
# c.content.ssl_strict = 'ask'

## A list of user stylesheet filenames to use.
## Type: List of File, or File
# c.content.user_stylesheets = []

## Enables or disables WebGL.
## Type: Bool
# c.content.webgl = True

## Whether load requests should be monitored for cross-site scripting
## attempts. Suspicious scripts will be blocked and reported in the
## inspector's JavaScript console. Enabling this feature might have an
## impact on performance.
## Type: Bool
# c.content.xss_auditing = False

## The directory to save downloads to. If unset, a sensible os-specific
## default is used.
## Type: Directory
# c.downloads.location.directory = None

## Prompt the user for the download location. If set to false,
## `downloads.location.directory` will be used.
## Type: Bool
# c.downloads.location.prompt = True

## Remember the last used download directory.
## Type: Bool
c.downloads.location.remember = True

## What to display in the download filename input.
## Type: String
## Valid values:
##   - path: Show only the download path.
##   - filename: Show only download filename.
##   - both: Show download path and filename.
c.downloads.location.suggestion = "both"

## The default program used to open downloads. If null, the default
## internal handler is used. Any `{}` in the string will be expanded to
## the filename, else the filename will be appended.
## Type: String
# c.downloads.open_dispatcher = None

## Where to show the downloaded files.
## Type: VerticalPosition
## Valid values:
##   - top
##   - bottom
# c.downloads.position = 'top'

## Number of milliseconds to wait before removing finished downloads. If
## set to -1, downloads are never removed.
## Type: Int
c.downloads.remove_finished = 15

## The editor (and arguments) to use for the `open-editor` command. `{}`
## gets replaced by the filename of the file to be edited.
## Type: ShellCommand
c.editor.command = ["termite", "-e", "nvim", "{}"]

## Encoding to use for the editor.
## Type: Encoding
# c.editor.encoding = 'utf-8'

## Font used in the completion categories.
## Type: Font
c.fonts.completion.category = "bold 12pt monospace"

## Font used in the completion widget.
## Type: Font
c.fonts.completion.entry = "12pt monospace"

## Font used for the debugging console.
## Type: QtFont
c.fonts.debug_console = "12pt monospace"

## Font used for the downloadbar.
## Type: Font
c.fonts.downloads = "12pt monospace"

## Font used for the hints.
## Type: Font
c.fonts.hints = "bold 14pt monospace"

## Font used in the keyhint widget.
## Type: Font
c.fonts.keyhint = "12pt monospace"

## Font used for error messages.
## Type: Font
c.fonts.messages.error = "12pt monospace"

## Font used for info messages.
## Type: Font
c.fonts.messages.info = "12pt monospace"

## Font used for warning messages.
## Type: Font
c.fonts.messages.warning = "12pt monospace"

## Default monospace fonts. Whenever "monospace" is used in a font
## setting, it's replaced with the fonts listed here.
## Type: Font
c.fonts.default_family = ["CartographCF Nerd Font"]

## Font used for prompts.
## Type: Font
c.fonts.prompts = "12pt sans-serif"

## Font used in the statusbar.
## Type: Font
c.fonts.statusbar = "12pt CartographCF Nerd Font"

## Font used in the tab bar.
## Type: QtFont
c.fonts.tabs.selected = "12pt CartographCF Nerd Font"
c.fonts.tabs.unselected = "12pt CartographCF Nerd Font"

## Font family for cursive fonts.
## Type: FontFamily
# c.fonts.web.family.cursive = ''

## Font family for fantasy fonts.
## Type: FontFamily
# c.fonts.web.family.fantasy = ''

## Font family for fixed fonts.
## Type: FontFamily
c.fonts.web.family.fixed = "Consolas"

## Font family for sans-serif fonts.
## Type: FontFamily
c.fonts.web.family.sans_serif = "Noto Sans"

## Font family for serif fonts.
## Type: FontFamily
c.fonts.web.family.serif = "Georgia"

## Font family for standard fonts.
## Type: FontFamily
c.fonts.web.family.standard = "Noto Sans"

## The default font size for regular text.
## Type: Int
# c.fonts.web.size.default = 16

## The default font size for fixed-pitch text.
## Type: Int
# c.fonts.web.size.default_fixed = 13

## The hard minimum font size.
## Type: Int
# c.fonts.web.size.minimum = 0

## The minimum logical font size that is applied when zooming out.
## Type: Int
# c.fonts.web.size.minimum_logical = 6

## Controls when a hint can be automatically followed without pressing
## Enter.
## Type: String
## Valid values:
##   - always: Auto-follow whenever there is only a single hint on a page.
##   - unique-match: Auto-follow whenever there is a unique non-empty match in either the hint string (word mode) or filter (number mode).
##   - full-match: Follow the hint when the user typed the whole hint (letter, word or number mode) or the element's text (only in number mode).
##   - never: The user will always need to press Enter to follow a hint.
# c.hints.auto_follow = 'unique-match'

## A timeout (in milliseconds) to ignore normal-mode key bindings after a
## successful auto-follow.
## Type: Int
# c.hints.auto_follow_timeout = 0

## CSS border value for hints.
## Type: String
c.hints.border = "1px solid " + solarized["base03"]

## Chars used for hint strings.
## Type: UniqueCharString
# c.hints.chars = 'asdfghjkl'

## The dictionary file to be used by the word hints.
## Type: File
# c.hints.dictionary = '/usr/share/dict/words'

## Which implementation to use to find elements to hint.
## Type: String
## Valid values:
##   - javascript: Better but slower
##   - python: Slightly worse but faster
# c.hints.find_implementation = 'python'

## Hide unmatched hints in rapid mode.
## Type: Bool
# c.hints.hide_unmatched_rapid_hints = True

## Minimum number of chars used for hint strings.
## Type: Int
# c.hints.min_chars = 1

## Mode to use for hints.
## Type: String
## Valid values:
##   - number: Use numeric hints. (In this mode you can also type letters from the hinted element to filter and reduce the number of elements that are hinted.)
##   - letter: Use the chars in the `hints.chars` setting.
##   - word: Use hints words based on the html elements and the extra words.
# c.hints.mode = 'letter'

## A comma-separated list of regexes to use for 'next' links.
## Type: List of Regex
# c.hints.next_regexes = ['\\bnext\\b', '\\bmore\\b', '\\bnewer\\b', '\\b[>→≫]\\b', '\\b(>>|»)\\b', '\\bcontinue\\b']

## A comma-separated list of regexes to use for 'prev' links.
## Type: List of Regex
# c.hints.prev_regexes = ['\\bprev(ious)?\\b', '\\bback\\b', '\\bolder\\b', '\\b[<←≪]\\b', '\\b(<<|«)\\b']

## Scatter hint key chains (like Vimium) or not (like dwb). Ignored for
## number hints.
## Type: Bool
# c.hints.scatter = True

## Make chars in hint strings uppercase.
## Type: Bool
# c.hints.uppercase = False

## The maximum time in minutes between two history items for them to be
## considered being from the same browsing session. Items with less time
## between them are grouped when being displayed in `:history`. Use -1 to
## disable separation.
## Type: Int
# c.history_gap_interval = 30

## Find text on a page case-insensitively.
## Type: String
## Valid values:
##   - always: Search case-insensitively
##   - never: Search case-sensitively
##   - smart: Search case-sensitively if there are capital chars
# c.ignore_case = 'smart'

## Forward unbound keys to the webview in normal mode.
## Type: String
## Valid values:
##   - all: Forward all unbound keys.
##   - auto: Forward unbound non-alphanumeric keys.
##   - none: Don't forward any keys.
# c.input.forward_unbound_keys = 'auto'

## Leave insert mode if a non-editable element is clicked.
## Type: Bool
# c.input.insert_mode.auto_leave = True

## Automatically enter insert mode if an editable element is focused
## after loading the page.
## Type: Bool
# c.input.insert_mode.auto_load = False

## Switch to insert mode when clicking flash and other plugins.
## Type: Bool
# c.input.insert_mode.plugins = False

## Include hyperlinks in the keyboard focus chain when tabbing.
## Type: Bool
# c.input.links_included_in_focus_chain = True

## Timeout (in milliseconds) for partially typed key bindings. If the
## current input forms only partial matches, the keystring will be
## cleared after this time.
## Type: Int
# c.input.partial_timeout = 5000

## Enable Opera-like mouse rocker gestures. This disables the context
## menu.
## Type: Bool
# c.input.rocker_gestures = False

## Enable Spatial Navigation. Spatial navigation consists in the ability
## to navigate between focusable elements in a Web page, such as
## hyperlinks and form controls, by using Left, Right, Up and Down arrow
## keys. For example, if a user presses the Right key, heuristics
## determine whether there is an element he might be trying to reach
## towards the right and which element he probably wants.
## Type: Bool
# c.input.spatial_navigation = False

## Keychains that shouldn't be shown in the keyhint dialog. Globs are
## supported, so `;*` will blacklist all keychains starting with `;`. Use
## `*` to disable keyhints.
## Type: List of String
# c.keyhint.blacklist = []

## Time from pressing a key to seeing the keyhint dialog (ms).
## Type: Int
# c.keyhint.delay = 500

## The rounding radius for the edges of the keyhint dialog.
## Type: Int
# c.keyhint.radius = 6

## Time (in ms) to show messages in the statusbar for. Set to 0 to never
## clear messages.
## Type: Int
# c.messages.timeout = 2000

## How to open links in an existing instance if a new one is launched.
## This happens when e.g. opening a link from a terminal. See
## `new_instance_open_target_window` to customize in which window the
## link is opened in.
## Type: String
## Valid values:
##   - tab: Open a new tab in the existing window and activate the window.
##   - tab-bg: Open a new background tab in the existing window and activate the window.
##   - tab-silent: Open a new tab in the existing window without activating the window.
##   - tab-bg-silent: Open a new background tab in the existing window without activating the window.
##   - window: Open in a new window.
# c.new_instance_open_target = 'tab'

## Which window to choose when opening links as new tabs. When
## `new_instance_open_target` is not set to `window`, this is ignored.
## Type: String
## Valid values:
##   - first-opened: Open new tabs in the first (oldest) opened window.
##   - last-opened: Open new tabs in the last (newest) opened window.
##   - last-focused: Open new tabs in the most recently focused window.
##   - last-visible: Open new tabs in the most recently visible window.
# c.new_instance_open_target_window = 'last-focused'

## Show a filebrowser in upload/download prompts.
## Type: Bool
# c.prompt.filebrowser = True

## The rounding radius for the edges of prompts.
## Type: Int
# c.prompt.radius = 8

## Additional arguments to pass to Qt, without leading `--`. With
## QtWebEngine, some Chromium arguments (see
## https://peter.sh/experiments/chromium-command-line-switches/ for a
## list) will work. This setting requires a restart.
## Type: List of String
# c.qt.args = []

## Force a Qt platform to use. This sets the `QT_QPA_PLATFORM`
## environment variable and is useful to force using the XCB plugin when
## running QtWebEngine on Wayland.
## Type: String
# c.qt.force_platform = None

## Force software rendering for QtWebEngine. This is needed for
## QtWebEngine to work with Nouveau drivers. This setting requires a
## restart.
## Type: Bool
# c.qt.force_software_rendering = False

## Show a scrollbar.
## Type: Bool
# c.scrolling.bar = False

## Enable smooth scrolling for web pages. Note smooth scrolling does not
## work with the `:scroll-px` command.
## Type: Bool
# c.scrolling.smooth = False

## The name of the session to save by default. If this is set to null,
## the session which was last loaded is saved.
## Type: SessionName
# c.session_default_name = None

## Spell checking languages. You can check for available languages and
## install dictionaries using scripts/install_dict.py. Run the script
## with -h/--help for instructions.
## Type: List of String
## Valid values:
##   - af-ZA: Afrikaans (South Africa)
##   - bg-BG: Bulgarian (Bulgaria)
##   - ca-ES: Catalan (Spain)
##   - cs-CZ: Czech (Czech Republic)
##   - da-DK: Danish (Denmark)
##   - de-DE: German (Germany)
##   - el-GR: Greek (Greece)
##   - en-CA: English (Canada)
##   - en-GB: English (United Kingdom)
##   - en-US: English (United States)
##   - es-ES: Spanish (Spain)
##   - et-EE: Estonian (Estonia)
##   - fa-IR: Farsi (Iran)
##   - fo-FO: Faroese (Faroe Islands)
##   - fr-FR: French (France)
##   - he-IL: Hebrew (Israel)
##   - hi-IN: Hindi (India)
##   - hr-HR: Croatian (Croatia)
##   - hu-HU: Hungarian (Hungary)
##   - id-ID: Indonesian (Indonesia)
##   - it-IT: Italian (Italy)
##   - ko: Korean
##   - lt-LT: Lithuanian (Lithuania)
##   - lv-LV: Latvian (Latvia)
##   - nb-NO: Norwegian (Norway)
##   - nl-NL: Dutch (Netherlands)
##   - pl-PL: Polish (Poland)
##   - pt-BR: Portuguese (Brazil)
##   - pt-PT: Portuguese (Portugal)
##   - ro-RO: Romanian (Romania)
##   - ru-RU: Russian (Russia)
##   - sh: Serbo-Croatian
##   - sk-SK: Slovak (Slovakia)
##   - sl-SI: Slovenian (Slovenia)
##   - sq: Albanian
##   - sr: Serbian
##   - sv-SE: Swedish (Sweden)
##   - ta-IN: Tamil (India)
##   - tg-TG: Tajik (Tajikistan)
##   - tr-TR: Turkish (Turkey)
##   - uk-UA: Ukrainian (Ukraine)
##   - vi-VN: Vietnamese (Viet Nam)
# c.spellcheck.languages = []

## Hide the statusbar unless a message is shown.
## Type: Bool
# c.statusbar.hide = False

## Padding for the statusbar.
## Type: Padding
# c.statusbar.padding = {'top': 1, 'bottom': 1, 'left': 0, 'right': 0}

## The position of the status bar.
## Type: VerticalPosition
## Valid values:
##   - top
##   - bottom
# c.statusbar.position = 'bottom'

## Open new tabs (middleclick/ctrl+click) in the background.
## Type: Bool
c.tabs.background = True

## On which mouse button to close tabs.
## Type: String
## Valid values:
##   - right: Close tabs on right-click.
##   - middle: Close tabs on middle-click.
##   - none: Don't close tabs using the mouse.
# c.tabs.close_mouse_button = 'middle'

## Behavior when the close mouse button is pressed on the tab bar.
## Type: String
## Valid values:
##   - new-tab: Open a new tab.
##   - close-current: Close the current tab.
##   - close-last: Close the last tab.
##   - ignore: Don't do anything.
# c.tabs.close_mouse_button_on_bar = 'new-tab'

## Scaling for favicons in the tab bar. The tab size is unchanged, so big
## favicons also require extra `tabs.padding`.
## Type: Float
# c.tabs.favicons.scale = 1.0

## Show favicons in the tab bar.
## Type: Bool
# c.tabs.favicons.show = True

## Padding for tab indicators
## Type: Padding
c.tabs.indicator.padding = {"top": 2, "bottom": 2, "left": 0, "right": 4}

## Behavior when the last tab is closed.
## Type: String
## Valid values:
##   - ignore: Don't do anything.
##   - blank: Load a blank page.
##   - startpage: Load the start page.
##   - default-page: Load the default page.
##   - close: Close the window.
# c.tabs.last_close = 'ignore'

## Switch between tabs using the mouse wheel.
## Type: Bool
# c.tabs.mousewheel_switching = True

## How new tabs opened from another tab are positioned.
## Type: NewTabPosition
## Valid values:
##   - prev: Before the current tab.
##   - next: After the current tab.
##   - first: At the beginning.
##   - last: At the end.
# c.tabs.new_position.related = 'next'

## How new tabs which aren't opened from another tab are positioned.
## Type: NewTabPosition
## Valid values:
##   - prev: Before the current tab.
##   - next: After the current tab.
##   - first: At the beginning.
##   - last: At the end.
# c.tabs.new_position.unrelated = 'last'

## Padding around text for tabs
## Type: Padding
c.tabs.padding = {"top": 4, "bottom": 4, "left": 5, "right": 5}

## The position of the tab bar.
## Type: Position
## Valid values:
##   - top
##   - bottom
##   - left
##   - right
c.tabs.position = "left"

## Which tab to select when the focused tab is removed.
## Type: SelectOnRemove
## Valid values:
##   - prev: Select the tab which came before the closed one (left in horizontal, above in vertical).
##   - next: Select the tab which came after the closed one (right in horizontal, below in vertical).
##   - last-used: Select the previously selected tab.
# c.tabs.select_on_remove = 'next'

## When to show the tab bar.
## Type: String
## Valid values:
##   - always: Always show the tab bar.
##   - never: Always hide the tab bar.
##   - multiple: Hide the tab bar if only one tab is open.
##   - switching: Show the tab bar when switching tabs.
# c.tabs.show = 'always'

## Time to show the tab bar before hiding it when tabs.show is set to
## 'switching'.
## Type: Int
# c.tabs.show_switching_delay = 800

## Open a new window for every tab.
## Type: Bool
# c.tabs.tabs_are_windows = False

## Alignment of the text inside of tabs.
## Type: TextAlignment
## Valid values:
##   - left
##   - right
##   - center
# c.tabs.title.alignment = 'left'

## The format to use for the tab title. The following placeholders are
## defined:  * `{perc}`: The percentage as a string like `[10%]`. *
## `{perc_raw}`: The raw percentage, e.g. `10` * `{title}`: The title of
## the current web page * `{title_sep}`: The string ` - ` if a title is
## set, empty otherwise. * `{index}`: The index of this tab. * `{id}`:
## The internal tab ID of this tab. * `{scroll_pos}`: The page scroll
## position. * `{host}`: The host of the current web page. * `{backend}`:
## Either ''webkit'' or ''webengine'' * `{private}` : Indicates when
## private mode is enabled. * `{current_url}` : The url of the current
## web page.
## Type: FormatString
# c.tabs.title.format = '{index}: {title}'

## The format to use for the tab title for pinned tabs. The same
## placeholders like for `tabs.title.format` are defined.
## Type: FormatString
# c.tabs.title.format_pinned = '{index}'

## The width of the tab bar if it's vertical, in px or as percentage of
## the window.
## Type: PercOrInt
c.tabs.width = "10%"

## Width of the progress indicator (0 to disable).
## Type: Int
# c.tabs.width.indicator = 3

## Whether to wrap when changing tabs.
## Type: Bool
# c.tabs.wrap = True

## Whether to start a search when something else than a URL is entered.
## Type: String
## Valid values:
##   - naive: Use simple/naive check.
##   - dns: Use DNS requests (might be slow!).
##   - never: Never search automatically.
# c.url.auto_search = 'naive'

## The page to open if :open -t/-b/-w is used without URL. Use
## `about:blank` for a blank page.
## Type: FuzzyUrl
# c.url.default_page = 'https://start.duckduckgo.com/'

## The URL segments where `:navigate increment/decrement` will search for
## a number.
## Type: FlagList
## Valid values:
##   - host
##   - path
##   - query
##   - anchor
# c.url.incdec_segments = ['path', 'query']

## Definitions of search engines which can be used via the address bar.
## Maps a searchengine name (such as `DEFAULT`, or `ddg`) to a URL with a
## `{}` placeholder. The placeholder will be replaced by the search term,
## use `{{` and `}}` for literal `{`/`}` signs. The searchengine named
## `DEFAULT` is used when `url.auto_search` is turned on and something
## else than a URL was entered to be opened. Other search engines can be
## used by prepending the search engine name to the search term, e.g.
## `:open google qutebrowser`.
## Type: Dict
c.url.searchengines = {
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "g": "https://encrypted.google.com/search?q={}",
}

## The page(s) to open at the start.
## Type: List of FuzzyUrl, or FuzzyUrl
# c.url.start_pages = ['https://start.duckduckgo.com']

## The URL parameters to strip with `:yank url`.
## Type: List of String
# c.url.yank_ignored_parameters = ['ref', 'utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content']

## Hide the window decoration when using wayland (requires restart)
## Type: Bool
# c.window.hide_wayland_decoration = False

## The format to use for the window title. The following placeholders are
## defined:  * `{perc}`: The percentage as a string like `[10%]`. *
## `{perc_raw}`: The raw percentage, e.g. `10` * `{title}`: The title of
## the current web page * `{title_sep}`: The string ` - ` if a title is
## set, empty otherwise. * `{id}`: The internal window ID of this window.
## * `{scroll_pos}`: The page scroll position. * `{host}`: The host of
## the current web page. * `{backend}`: Either ''webkit'' or
## ''webengine'' * `{private}` : Indicates when private mode is enabled.
## * `{current_url}` : The url of the current web page.
## Type: FormatString
# c.window.title_format = '{perc}{title}{title_sep}qutebrowser'

## The default zoom level.
## Type: Perc
c.zoom.default = "100%"

## The available zoom levels.
## Type: List of Perc
# c.zoom.levels = ['25%', '33%', '50%', '67%', '75%', '90%', '100%', '110%', '125%', '150%', '175%', '200%', '250%', '300%', '400%', '500%']

## How much to divide the mouse wheel movements to translate them into
## zoom increments.
## Type: Int
# c.zoom.mouse_divider = 512

## Whether the zoom factor on a frame applies only to the text or to all
## content.
## Type: Bool
# c.zoom.text_only = False

config.bind("<Ctrl-e>", "config-cycle tabs.show always never")
config.set("colors.webpage.darkmode.enabled", True)
config.set("colors.webpage.preferred_color_scheme", "dark")
