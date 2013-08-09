PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/orca/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/orca/prebuilt/common/bin/50-slim.sh:system/addon.d/50-slim.sh \
    vendor/orca/prebuilt/common/bin/99-backup.sh:system/addon.d/99-backup.sh \
    vendor/orca/prebuilt/common/etc/backup.conf:system/etc/backup.conf

# SLIM-specific init file
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/etc/init.local.rc:root/init.slim.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
    
# APPS TO COPY
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/app/GooManager.apk:system/app/GooManager.apk    

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/orca/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Audio Config for DSPManager
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/vendor/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf
#LOCAL ORCA CHANGES  - END

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/orca/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/orca/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/orca/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/orca/prebuilt/common/bin/sysinit:system/bin/sysinit
    
ifneq ($(ORCA_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/orca/prebuilt/common/bootanimation/$(ORCA_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
else
    PRODUCT_COPY_FILES += \
        vendor/orca/prebuilt/common/bootanimation/XHDPI.zip:system/media/bootanimation.zip
endif    

# Embed SuperUser
SUPERUSER_EMBEDDED := true

# Orca Packages
PRODUCT_PACKAGES += \
    OrcaWallpapers \
    Focal \
    Torch \
    DaskClock
    LockClock 

# More Packages
PRODUCT_PACKAGES += \
    Apollo \
    CMFileManager 

# Extra tools
PRODUCT_PACKAGES += \
    openvpn \
    e2fsck \
    mke2fs \
    tune2fs

PRODUCT_PACKAGE_OVERLAYS += vendor/orca/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/orca/overlay/common

# T-Mobile theme engine
include vendor/orca/config/themes_common.mk

# Versioning System
# Prepare for Nightlies
PRODUCT_VERSION_MAJOR = 3
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 3
ifdef ORCA_BUILD_EXTRA
    ORCA_POSTFIX := -$(ORCA_BUILD_EXTRA)
endif
ifndef ORCA_BUILD_TYPE
    ORCA_BUILD_TYPE := UNOFFICIAL
    PLATFORM_VERSION_CODENAME := UNOFFICIAL
    ORCA_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
ORCA_VERSION := Orca-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(ORCA_BUILD_TYPE)$(ORCA_POSTFIX)
ORCA_MOD_VERSION := Orca-$(SLIM_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(ORCA_BUILD_TYPE)$(ORCA_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    orca.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.orca.version=$(ORCA_VERSION) \
    ro.modversion=$(ORCA_MOD_VERSION)

# goo.im properties
ifneq ($(DEVELOPER_VERSION),true)
    PRODUCT_PROPERTY_OVERRIDES += \
      ro.goo.developerid=drewgaren \
      ro.goo.rom=Orca_Nightlies \
      ro.goo.version=$(shell date +%s)
endif