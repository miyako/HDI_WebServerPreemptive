![version](https://img.shields.io/badge/version-20%2B-E23089)
![platform](https://img.shields.io/static/v1?label=platform&message=mac-intel%20|%20mac-arm%20|%20win-64&color=blue)

# HDI_WebServerPreemptive

Comparing 4D's preemptive and cooperative web server process modes head-to-head, from a browser. Originally published by 4D as a **HDI** (*How Do I*) example for **4D v16**; converted from the binary `.4DB` to the `.4DProject` architecture so it runs on current 4D releases.

## What it demonstrates

- Switching the web server's **"Use preemptive processes"** setting at runtime by patching the preferences XML and restarting the web server (`SetPreemptiveProperty`).
- Serving a database selection as JSON to a browser (`WebMethodArray` -> `Selection to JSON` on the `Country` table).
- Serving a dynamic image that reflects whether the *current* web process is running preemptively or cooperatively (`WebMethodType` -> `_O_PROCESS PROPERTIES`).
- Simulating CPU-bound work on the server before responding, to make the difference between modes visible (`WebMethodFakeData`).
- A minimal `4daction`/`WebFolder` HTTP endpoint layout, exercised from a plain HTML/JS test page.

## Key commands

| Command | Used for |
|---|---|
| `WEB SEND RAW DATA` | Returning the `Country` selection as a raw JSON blob to the browser |
| `WEB SEND FILE` | Returning a static image (mode indicator, benchmark result) as the HTTP response |
| `WEB START SERVER` / `WEB STOP SERVER` | Restarting the web server so a changed preemptive setting takes effect |
| `WEB Is server running` | Guarding the restart so it only stops a server that is actually running |
| `_O_PROCESS PROPERTIES` | Reading the current web process's state flags to detect preemptive vs. cooperative |
| `DOM Parse XML source` / `DOM SET XML ATTRIBUTE` / `DOM EXPORT TO FILE` | Editing the `preemptive` attribute in the web server preferences XML on disk |
| `Selection to JSON` | Serialising the `Country` table selection for the `4daction/WebMethodArray` endpoint |

## How it works

`00_Start` opens the `HDI` splash form; its `BtnDemo` object method opens the demo form `HDI2`, whose three tabs (Info / Steps to follow / Result) are populated from `Resources/SAMPLES-en.json` / `SAMPLES-ja.json` by `initHDI`, keyed off `Get database localization`.

`HDI2` has two large picture buttons that each call `SetPreemptiveProperty("true"|"false")`. That method stops the web server if it's running, edits the `preemptive` attribute of the server's preferences XML with the `DOM` commands, and starts the server again -- because the preemptive-processes setting is only re-read when the web server (re)starts.

With the server running, opening `WebFolder/test.html` in a browser triggers three requests handled by published web methods:

- `4daction/WebMethodType` -- returns `preemptive.png` or `cooperative.png` depending on the current process's flags, so the page visibly confirms which mode served it.
- `4daction/WebMethodArray` -- returns the `Country` table as JSON, which the page renders into an HTML table.
- `4daction/WebMethodFakeData` -- (invoked separately, e.g. for benchmarking) burns CPU cycles in a loop of trig/rounding calls before sending `fake_data.png`, so cooperative mode's single-threaded contention shows up as a measurable delay under load.

## Points of interest

- The preemptive/cooperative choice is a **server preference**, not a per-request option -- changing it requires a full stop/restart of the web server, which is why `SetPreemptiveProperty` brackets the XML edit with `WEB STOP SERVER` / `WEB START SERVER`.
- `WebMethodType`'s image response doubles as a lightweight status indicator: the browser can tell which mode is active just by looking at the badge image, without parsing headers or JSON.
- `WebMethodFakeData`'s loop (`Cos`, `Sin`, `Tan`, `Arctan`, `Mod`, `Round`, `Trunc`, etc. run 30,000 times) exists purely to give cooperative mode something expensive to serialise on a single thread -- it has no functional purpose beyond making the preemptive/cooperative difference measurable.
- All three web methods are `publishedWeb` project methods reachable only via `4daction/<name>` URLs; they are marked `invisible` so they don't clutter the Run Method dialog, which is for manually testable entry points.
- The `Country`/`Continent` tables and their flag images (`Resources/Country_flag/`) exist solely to give the JSON/table demo realistic sample data; they aren't otherwise part of the preemptive-vs-cooperative story.

## Modernisation notes

Converted from the 4D v16 binary `.4DB` to the `.4DProject` architecture. The branch below carries the modernisation work.

| Branch | Description | Instructions |
|--------|-------------|--------------|
| [`miyako-modernize-hdi-project`](../../tree/miyako-modernize-hdi-project) | Full HDI modernisation (XLIFF, declarations, menu, method visibility, startup, dark mode + Liquid Glass CSS) | [localisation.instructions.md](.github/instructions/localisation.instructions.md), [variable.declarations.instructions.md](.github/instructions/variable.declarations.instructions.md), [menu.instructions.md](.github/instructions/menu.instructions.md), [method.visibility.instructions.md](.github/instructions/method.visibility.instructions.md), [startup.instructions.md](.github/instructions/startup.instructions.md), [css.instructions.md](.github/instructions/css.instructions.md), [tahoe.css.instructions.md](.github/instructions/tahoe.css.instructions.md) |

## References

- [4D documentation: Preemptive processes](https://developer.4d.com/docs/Develop/preemptive-processes)
- [4D documentation: WEB SET OPTION](https://developer.4d.com/docs/commands/web-set-option)
- [4D documentation: WEB SEND RAW DATA](https://developer.4d.com/docs/commands/web-send-raw-data)
- [4D documentation: WEB SEND FILE](https://developer.4d.com/docs/commands/web-send-file)
- [4D documentation: Selection to JSON](https://developer.4d.com/docs/commands/selection-to-json)
- Original download: [HDI_WebServerPreemptive.zip](https://download.4d.com/Demos/4D_v16/HDI_WebServerPreemptive.zip)
- Index of v16/v17 HDIs: [miyako/4d-hdi](https://github.com/miyako/4d-hdi)

## Screenshots
