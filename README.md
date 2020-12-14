# DLP4710-SLM
A 3D printed modification to the DLP4710EVM DMD to turn it into a lab-usable spatial light modulator. Optimised example MATLAB code for displaying Laguerre-Gauss holograms fullscreen are in the Examples folder.

**Created by:** Mitchell A. Cox in 2020 :: www.wits.ac.za/eie [mitchell.cox@wits.ac.za]

**License:** CC-BY-SA-4.0

## Reference

Please note that build instructions, photos, etc. are in the following paper:

... Under review ...

If you find this work useful, please consider citing or acknowledging it. If you make improvements, please send a pull request.

## 3D Printer Settings

The designs have been verified with an Ultimaker S3 using Cura with the following settings:

> **Layer height:** 0.1 mm
> **Infill:** 80%
> **Adhesion:** No
> **Support:** No

**If you have been successful with other printers / settings, please let me know.**

## Useful URLs

https://www.ti.com/tool/DLPDLCR4710EVM-G2

https://www.ti.com/tool/DLP4710EVM-LC

## Updating the Firmware

Some firmware updating is required so that the LEDs are disabled on start (otherwise it won't turn on as it thinks the LEDs are broken) and to set the input source to the HDMI port.

For some reason the Texas Instruments software for the DLP4710-G2 evaluation board doesn't update the firmware. It says it does, but it doesn't (it's pretty clear that nothing happens as it's too quick when one tries). Instead, the software meant for the DLP4710-LC must be used. It will complain about the wrong board, but it still works. The screenshot below shown the place where this should be done and how it looks.

A firmware image from TI is in the firmware directory in this repo. A batch file to switch off the LEDs and set the input is also included. You are welcome to download this firmware from TI but this is more convenient... Please note that if you try to flash the wrong firmware or if something goes wrong using my "unofficial" firmware, it's at your own risk.

![DLP4710LC Update Screenshot](https://github.com/WitsOCLab/DLP4710-SLM/blob/master/Docs/firmwareupdate.jpg?raw=true)
