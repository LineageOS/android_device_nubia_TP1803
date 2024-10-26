#
# Copyright (C) 2020-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

import common
import re

def FullOTA_InstallEnd(info):
    OTA_InstallEnd(info)
    return

def IncrementalOTA_InstallEnd(info):
    OTA_InstallEnd(info)
    return

def AddImage(info, basename, dest):
    name = basename
    data = info.input_zip.read("IMAGES/" + basename)
    common.ZipWriteStr(info.output_zip, name, data)
    info.script.Print("Patching {} image unconditionally...".format(dest.split('/')[-1]))
    info.script.AppendExtra('package_extract_file("%s", "%s");' % (name, dest))

def AddImageRadio(info, basename, dest):
    name = basename
    if ("RADIO/" + basename) in info.input_zip.namelist():
        data = info.input_zip.read("RADIO/" + basename)
        common.ZipWriteStr(info.output_zip, name, data)
        info.script.Print("Patching {} image unconditionally...".format(dest.split('/')[-1]))
        info.script.AppendExtra('package_extract_file("%s", "%s");' % (name, dest))

def OTA_InstallEnd(info):
    AddImage(info, "dtbo.img", "/dev/block/bootdevice/by-name/dtbo")
    AddImage(info, "vbmeta.img", "/dev/block/bootdevice/by-name/vbmeta")

    AddImageRadio(info, "abl.img", "/dev/block/bootdevice/by-name/abl")
    AddImageRadio(info, "aop.img", "/dev/block/bootdevice/by-name/aop")
    AddImageRadio(info, "bluetooth.img", "/dev/block/bootdevice/by-name/bluetooth")
    AddImageRadio(info, "cmnlib.img", "/dev/block/bootdevice/by-name/cmnlib")
    AddImageRadio(info, "cmnlib64.img", "/dev/block/bootdevice/by-name/cmnlib64")
    AddImageRadio(info, "devcfg.img", "/dev/block/bootdevice/by-name/devcfg")
    AddImageRadio(info, "dspso.img", "/dev/block/bootdevice/by-name/dsp")
    AddImageRadio(info, "hyp.img", "/dev/block/bootdevice/by-name/hyp")
    AddImageRadio(info, "imagefv.img", "/dev/block/bootdevice/by-name/imagefv")
    AddImageRadio(info, "keymaster.img", "/dev/block/bootdevice/by-name/keymaster")
    AddImageRadio(info, "multiimgoem.img", "/dev/block/bootdevice/by-name/multiimgoem")
    AddImageRadio(info, "modem.img", "/dev/block/bootdevice/by-name/modem")
    AddImageRadio(info, "parameter.img", "/dev/block/bootdevice/by-name/parameter")
    AddImageRadio(info, "qupfw.img", "/dev/block/bootdevice/by-name/qupfw")
    AddImageRadio(info, "splash.img", "/dev/block/bootdevice/by-name/splash")
    AddImageRadio(info, "storsec.img", "/dev/block/bootdevice/by-name/storsec")
    AddImageRadio(info, "tz.img", "/dev/block/bootdevice/by-name/tz")
    AddImageRadio(info, "uefisecapp.img", "/dev/block/bootdevice/by-name/uefisecapp")
    AddImageRadio(info, "xbl.img", "/dev/block/bootdevice/by-name/xbl")
    AddImageRadio(info, "xbl_config.img", "/dev/block/bootdevice/by-name/xbl_config")

    return
