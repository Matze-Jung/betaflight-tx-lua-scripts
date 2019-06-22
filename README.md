# betaflight-tx-lua-scripts-mod

*based on release [1.3.0](https://github.com/betaflight/betaflight-tx-lua-scripts/releases/tag/1.3.0)*

## Changes

**+ Display external telemetry templates beside betaflight screens**

**+ Configurable navigation controls, radio type independent**
  - added user events: `longPress.page`, `release.page`
  - added radio schemes: Taranis X-Lite, Taranis X9E
  - added controls:
    * ***Page back*** on long press [PAGE]
    * ***Back to first page*** on long press [MENU]
    * ***Close menu*** on release [MENU] button
    * ***Quit editing*** on release [MENU] button *(not discarding changes)*

**+ Minified script files, shrinked down to 75% the size of 1.3.0** (thanks to [mathiasbynens/luamin](https://github.com/mathiasbynens/luamin))

## Notes

I wanted to explore the potential of the popular betaflight-tx-lua-scripts a bit, as I wasn't quit satisfied with a few things. Came up with this mod and it upgraded the UX for me so well, that I decided to share it with the community. Runs nique smooth on my FrSky Taranis Q X7, but I wasn't able to do tests with any *Horus* or other model than *FrSky Taranis* so far.

Install and use this modified version just the way you're used to. First time users should have a glimpse at the [install instructions](#installing).

### Loading telemetry scripts
To add, change or reorder pages, edit the `PageFiles = { ... }` table in your `SCRIPTS/BF/[platform]/[platform]pre.lua` file.

As a point to start, uncomment the first line of `PageFiles` to load the example home screen `exmpl1.lua` *(except Horus)*.

Order the pages to your needs (I prefer the vtx settings as my second, after the custom home screen).

Prepend `-- ` to the line to hide a page (e.g. rescue.lua and gps.lua, if you don't use GPS).

Use relative pathnames to refer external templates.
If you add or edit pages, keep in mind that the radios internal memory isn't endless.

### Navigation controls
The code wich handles the user events was extracted from `ui.lua` into a table `ctrlSchema = { ... }` and placed in each `SCRIPTS/BF/[platform]/[platform]pre.lua` file.
The assignment of radio inputs to script actions depends now on this platform specific config.

For instance: if you want to have switching pages on the [DIAL WHEEL] input, change the condition of `ctrlSchema.display.prevPage` to `dial.left` and `ctrlSchema.display.nextPage` to `dial.right`.

To add a radio control schema based on its platform, just overwrite the affected table fields below the schema table (see overrides for X9E in `SCRIPTS/BF/X9/x9pre.lua` for example).

### Memory warning
If you just copied the files, launched the script and a `not enough memory` warning appears, probably restarting the radio is the only thing to do here. If OpenTX still complains, try to delete all `.luac` files (compiled them with LUAC 5.3, don't know if that's a problem with some radios).

### Test environment
* OpenTX v2.2.3 on FrSky Taranis Q X7 Hardware
* Betaflight 4.0.3 on OmnibusF4 FC
* Companion v2.2.3 Simulator (*all FrSky, **except Horus***)

> *Any feedback about testing on different hardware welcome.*

### Download

Please go to the [releases page](https://github.com/Matze-Jung/betaflight-tx-lua-scripts-mod/releases) to download the latest files.


## Control schema layout

| State  | Action | Condition (X7) |
| - | - | - |
| display | prevPage | *longPress.page* |
| | nextPage | *release.page* |
| | prevLine | *dial.left* |
| | nextLine | *dial.right* |
| | edit | *release.enter* |
| | menu | *release.menu* |
| | home | *longPress.menu* |
| | exit | *release.exit* |
| editing | decValue | *dial.left* |
| | stepValue | *dial.right* |
| | exit | *release.exit* or *release.enter* or *release.menu* |
| displayMenu | prev | *dial.left* |
| | next | *dial.right* |
| | cnfrm | *release.enter* |
| | exit | *release.exit* or *release.menu* |


## User events

| Action  | Name |
| - | - |
| press | minus |
|   | plus |
|   | pageDown |
|   | pageUp |
| longPress | enter |
|   | menu |
|   | page |
| repeatPress | minus |
|   | plus |
| release | enter |
|   | exit |
|   | menu |
|   | minus |
|   | plus |
|   | page |
| dial | enter |
|   | left |
|   | right |


---


# betaflight-tx-lua-scripts

### Important:

Some changes in the recently released OpenTX 2.2.1 cause this version to have less RAM available for lua scripts than previous versions. This often leads to problems when using the Betaflight TX lua scripts on the Taranis X9D. A discussion of these problems can be found [here](https://github.com/betaflight/betaflight-tx-lua-scripts/issues/97).
A potential fix to increase the amount of RAM available has been identified: (https://github.com/opentx/opentx/pull/5579).
For now, the recommendation is for users wanting to update OpenTX from 2.2.0 to 2.2.1 on a Taranis X9D (and keep using the Betaflight TX lua scripts) to hold on and monitor the situation, in the hope that OpenTX will release a version with this bugfix in the near future.

## Firmware Considerations
- Betaflight - As a best practice, it is recommended to use the most recent stable release of Betaflight to obtain the best possible results.
- Crossfire - v2.11 or greater
- FrSky - While most receivers work fine, it's recommended to update the XSR family of receivers to their most recent firmware version to correct any known bugs in SmartPort telemetry.

## Building from source
- Be sure to have `LUA 5.2` installed in the path
- Run `./bin/build.sh` from the root folder
- Compiled files will be created a the `obj` in the root folder. Copy the files to your transmitter as instructed in the `Installing` section below as if you unzipped from a downloaded file.

## Installing

!! IMPORTANT: DON'T COPY THE CONTENTS OF THIS REPOSITORY ONTO YOUR SDCARD !!

Unzip the files from the link above and drag the contents to your radio. If you do this correctly, the SCRIPTS directory will merge with your existing directories, placing the scripts in their appropriate paths.  You will know if you did this correctly if the bf.lua file shows up in your /SCRIPTS/TELEMETRY directory.

The src directory is not required for use and is only available for maintenance of the code.  While it may work to use this directory, you may encounter memory issues on your transmitter.

How to install:

Bootloader Method
1. Power off your transmitter and power it back on in boot loader mode.
2. Connect a USB cable and open the SD card drive on your computer.
3. Unzip the file and copy the scripts to the root of the SD card.
4. Unplug the USB cable and power cycle your transmitter.

Manual method (varies, based on the model of your transmitter)
1. Power off your transmitter.
2. Remove the SD card and plug it into a computer
3. Unzip the file and copy the scripts to the root of the SD card.
4. Reinsert your SD card into the transmitter
5. Power up your transmitter.

If you copied the files correctly, you can now go into the telemetry screen setup page and set up the script as telemetry page.

## Adding the script as a telemetry page
Setting up the script as a telemetry page will enable access at the press of a button. (For now, this only applies to the Taranis X9D series).
1. Hit the [MENU] button and select the model for which you would like to enable the script.
2. While on the [MODEL SELECTION] screen, long-press the [PAGE] button to navigate to the [DISPLAY] page.
3. Use the [-] button to move the cursor down to [Screen 1] and hit [ENT].
4. Use the [+] or [-] buttons to select the [Script] option and press [ENT].
5. Press [-] to move the cursor to the script selection field and hit [ENT].
6. Select 'bf' and hit [ENT].
7. Long-press [EXIT] to return to your model screen.

To invoke the script, simply long-press the [PAGE] button from the model screen.
