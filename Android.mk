ifeq ($(PLATFORM_TDK_VERSION), 38)
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES_32 := ca_export_arm/bin_android/tee-supplicant
LOCAL_SRC_FILES_64 := ca_export_arm64/bin_android/tee-supplicant
LOCAL_INIT_RC := ca_export_arm/bin_android/tee-supplicant.rc
LOCAL_MODULE := tee-supplicant
LOCAL_SHARED_LIBRARIES := libteec libcutils
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

ifneq ($(filter userdebug eng,$(TARGET_BUILD_VARIANT)),)
include $(CLEAR_VARS)
LOCAL_SRC_FILES_32 := ca_export_arm/bin_android/tee_stest
LOCAL_SRC_FILES_64 := ca_export_arm64/bin_android/tee_stest
LOCAL_MODULE := tee_stest
LOCAL_SHARED_LIBRARIES := libteec
LOCAL_MODULE_CLASS := EXECUTABLES
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)
endif

include $(CLEAR_VARS)
LOCAL_SRC_FILES_32 := ca_export_arm/lib_android/libteec.so
LOCAL_SRC_FILES_64 := ca_export_arm64/lib_android/libteec.so
LOCAL_MODULE := libteec
LOCAL_MULTILIB := both
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_SRC_FILES_32 := ca_export_arm/lib_android/libteec_sys.so
LOCAL_SRC_FILES_64 := ca_export_arm64/lib_android/libteec_sys.so
LOCAL_MODULE := libteec_sys
LOCAL_MULTILIB := both
LOCAL_MODULE_SUFFIX := .so
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
include $(BUILD_PREBUILT)

endif
