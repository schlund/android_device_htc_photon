#
# Copyright (C) 2009 The Android Open Source Project
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


DEVICE_PACKAGE_OVERLAYS := device/htc/photon/overlay

## (1) First, the most specific values, i.e. the aspects that are specific to GSM

# Keylayouts
PRODUCT_COPY_FILES += \
    device/htc/photon/key/photon-keypad.kl:system/usr/keylayout/photon-keypad.kl \
    device/htc/photon/key/photon-keypad.kcm.bin:system/usr/keychars/photon-keypad.kcm.bin \
    device/htc/photon/key/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl

PRODUCT_COPY_FILES += \
    device/htc/photon/init.photon.rc:root/init.photon.rc

## (2) Also get non-open-source GSM-specific aspects if available
$(call inherit-product-if-exists, vendor/htc/photon/photon-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/base/data/etc/android.hardware.camera.autofocus.xml:system/etc/permissions/android.hardware.camera.autofocus.xml \
    frameworks/base/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/base/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/base/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/base/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/base/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/base/data/etc/android.hardware.touchscreen.multitouch.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.xml \
    frameworks/base/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml

# media config xml file
PRODUCT_COPY_FILES += \
    device/htc/photon/media_profiles.xml:system/etc/media_profiles.xml

PRODUCT_PACKAGES += \
    librs_jni \
    lights.photon \
    gralloc.msm7k \
    copybit.msm7k \
    sensors.photon \
    gps.photon \
    com.android.future.usb.accessory \
	libhtc_ril_wrapper \
	libhtc_acoustic

PRODUCT_PACKAGES += \
    libstagefrighthw \
    libmm-omxcore \
    libOmxCore

PRODUCT_COPY_FILES += \
    device/htc/photon/vold.fstab:system/etc/vold.fstab \
    device/common/gps/gps.conf_US:system/etc/gps.conf \
    vendor/cyanogen/prebuilt/common/etc/apns-conf.xml:system/etc/apns-conf.xml

# Kernel modules

ifeq ($(TARGET_PREBUILT_KERNEL),)
LOCAL_KERNEL := device/htc/photon/prebuilt/kernel
else
LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

# Prebuilt Modules
PRODUCT_COPY_FILES += \
    device/htc/photon/prebuilt/bcm4329.ko:system/lib/modules/bcm4329.ko \
    device/htc/photon/firmware/bcm4329.hcd:system/etc/firmware/bcm4329.hcd \
    device/htc/photon/firmware/fw_bcm4329.bin:system/etc/firmware/fw_bcm4329.bin \
    device/htc/photon/firmware/fw_bcm4329_apsta.bin:system/etc/firmware/fw_bcm4329_apsta.bin

# media profiles and capabilities spec
$(call inherit-product, device/htc/photon/media_a1026.mk)

# stuff common to all HTC phones
$(call inherit-product, device/htc/common/common.mk)

$(call inherit-product, build/target/product/full_base.mk)


PRODUCT_NAME := generic_photon
PRODUCT_DEVICE := photon
