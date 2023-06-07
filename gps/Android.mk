ifneq ($(BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE),)

# Set required flags
GNSS_CFLAGS := \
    -Werror \
    -Wno-error=undefined-bool-conversion

LOCAL_PATH := $(call my-dir)
include $(call all-makefiles-under,$(LOCAL_PATH))

GNSS_SANITIZE := cfi bounds null unreachable integer

endif # ifneq ($(BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE),)
