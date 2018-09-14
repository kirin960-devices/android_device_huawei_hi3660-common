#
# Copyright (C) 2018 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

VENDOR_PATH := device/huawei/hi3660-common

# Platform
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# Android generic system image always create metadata partition
BOARD_USES_METADATA_PARTITION := true
# Audio
USE_XML_AUDIO_POLICY_CONF := 1
# Android Verified Boot (AVB):
#   Builds a special vbmeta.img that disables AVB verification.
#   Otherwise, AVB will prevent the device from booting the generic system.img.
#   Also checks that BOARD_AVB_ENABLE is not set, to prevent adding verity
#   metadata into system.img.
ifeq ($(BOARD_AVB_ENABLE),true)
$(error BOARD_AVB_ENABLE cannot be set for Treble GSI)
endif
BOARD_BUILD_DISABLED_VBMETAIMAGE := true
# Bootloader, kernel and recovery are not part of generic AOSP image
TARGET_NO_BOOTLOADER := true
# Generic AOSP image does NOT support HWC1
TARGET_USES_HWC2 := true

# Kernel
BOARD_CUSTOM_BOOTIMG_MK := $(VENDOR_PATH)/mkbootimg.mk
BOARD_BOOTIMAGE_WITHOUT_RAMDISK := true
BOARD_KERNEL_BASE := 0x00078000
BOARD_KERNEL_CMDLINE := loglevel=4 initcall_debug=n page_tracker=on slub_min_objects=16 unmovable_isolate1=2:192M,3:224M,4:256M printktimer=0xfff0a000,0x534,0x538
BOARD_KERNEL_IMAGE_NAME := Image.gz
BOARD_KERNEL_PAGESIZE := 2048
BOARD_MKBOOTIMG_ARGS := --kernel_offset 0x00008000 --ramdisk_offset 0x07b88000 --second_offset 0x00e88000 --tags_offset 0x07988000
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_CONFIG := merge_hi3660_defconfig
TARGET_KERNEL_SOURCE := kernel/huawei/hi3660
TARGET_KERNEL_CROSS_COMPILE_PREFIX := aarch64-linux-android-

# Bluetooth
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := $(VENDOR_PATH)/bluetooth
BOARD_HAVE_BLUETOOTH := true

# Camera
TARGET_CAMERA_NEEDS_ADD_STATES_IN_ENUMERATE := true

# Display
TARGET_ADDITIONAL_GRALLOC_10_USAGE_BITS := 0x2080000U

# Enable 64-bits binder
TARGET_USES_64_BIT_BINDER := true

# Extended Filesystem Support
TARGET_EXFAT_DRIVER := exfat

# Generic AOSP image always requires separate vendor.img
TARGET_COPY_OUT_VENDOR := vendor

# HW Composer
TARGET_HAS_HWC_HUAWEI := true

# Lineage hardware
JAVA_SOURCE_OVERLAYS := org.lineageos.hardware|$(VENDOR_PATH)/lineagehw|**/*.java

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE		:= 25165824 # kernel 24576 Kilobytes
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3724541952 # 4541MB  3552MB for ASIA
BOARD_CACHEIMAGE_PARTITION_SIZE := 126877696 # 121MB

# Properties
TARGET_SYSTEM_PROP := $(VENDOR_PATH)/system.prop
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true

# Radio
TARGET_PROVIDES_QTI_TELEPHONY_JAR := true

# Recovery
BOARD_PROVIDES_BOOTLOADER_MESSAGE := true
TARGET_RECOVERY_FSTAB := $(VENDOR_PATH)/rootdir/etc/fstab.hi3660

# Release tools
TARGET_RELEASETOOLS_EXTENSIONS := $(VENDOR_PATH)/releasetools

# SELinux
BOARD_PLAT_PRIVATE_SEPOLICY_DIR += $(VENDOR_PATH)/sepolicy/private
BOARD_PLAT_PUBLIC_SEPOLICY_DIR += $(VENDOR_PATH)/sepolicy/public

# Set emulator framebuffer display device buffer count to 3
NUM_FRAMEBUFFER_SURFACE_BUFFERS := 3

# Shims
TARGET_LD_SHIM_LIBS := \
    /system/lib64/libdisplayenginesvc_1_0.so|libshims_hwsmartdisplay_jni.so \
    /system/lib64/libdisplayenginesvc_1_1.so|libshims_hwsmartdisplay_jni.so \
    /system/lib64/libhwsmartdisplay_jni.so|libshims_hwsmartdisplay_jni.so \
    /vendor/bin/hw/vendor.huawei.hardware.hisupl@1.0-service|libshims_hisupl.so

# Don't dex preopt apps to avoid I/O congestion due to paging larger sized
# pre-compiled .odex files as opposed to background generated interpret-only
# odex files.
WITH_DEXPREOPT_BOOT_IMG_AND_SYSTEM_SERVER_ONLY := true

# system.img is always ext4 with sparse option
# GSI also includes make_f2fs to support userdata parition in f2fs
# for some devices
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := false
TARGET_USES_MKE2FS := true
# VNDK
BOARD_VNDK_VERSION := current

# vintf
DEVICE_FRAMEWORK_MANIFEST_FILE := $(VENDOR_PATH)/framework_manifest.xml
