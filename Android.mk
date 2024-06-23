#
# Copyright (C) 2021-2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),TP1803)

include $(call all-makefiles-under,$(LOCAL_PATH))

include $(CLEAR_VARS)

# A/B builds require us to create the mount points at compile time.
# Just creating it for all cases since it does not hurt.
FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/firmware_mnt
$(FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/firmware_mnt

BT_FIRMWARE_MOUNT_POINT := $(TARGET_OUT_VENDOR)/bt_firmware
$(BT_FIRMWARE_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(BT_FIRMWARE_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/bt_firmware

DSP_MOUNT_POINT := $(TARGET_OUT_VENDOR)/dsp
$(DSP_MOUNT_POINT): $(LOCAL_INSTALLED_MODULE)
	@echo "Creating $(DSP_MOUNT_POINT)"
	@mkdir -p $(TARGET_OUT_VENDOR)/dsp

ALL_DEFAULT_INSTALLED_MODULES += $(FIRMWARE_MOUNT_POINT) $(BT_FIRMWARE_MOUNT_POINT) $(DSP_MOUNT_POINT)

EGL_SYMLINKS := $(TARGET_OUT_VENDOR)/lib/
$(EGL_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno $@/libGLESv2_adreno

EGL64_SYMLINKS := $(TARGET_OUT_VENDOR)/lib64/
$(EGL64_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	mkdir -p $@
	$(hide) ln -sf egl/libEGL_adreno.so $@/libEGL_adreno.so
	$(hide) ln -sf egl/libGLESv2_adreno $@/libGLESv2_adreno

ALL_DEFAULT_INSTALLED_MODULES += $(EGL_SYMLINKS) $(EGL64_SYMLINKS)

IMS_LIBS := libimscamera_jni.so libimsmedia_jni.so
IMS_SYMLINKS := $(addprefix $(TARGET_OUT_SYSTEM_EXT_APPS_PRIVILEGED)/ims/lib/arm64/,$(notdir $(IMS_LIBS)))
$(IMS_SYMLINKS): $(LOCAL_INSTALLED_MODULE)
	@echo "IMS lib link: $@"
	@mkdir -p $(dir $@)
	@rm -rf $@
	$(hide) ln -sf /system_ext/lib64/$(notdir $@) $@

ALL_DEFAULT_INSTALLED_MODULES += $(IMS_SYMLINKS)

endif
