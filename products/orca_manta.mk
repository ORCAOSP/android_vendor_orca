# Copyright (C) 2013 The Orca Project
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

# Inherit AOSP device configuration
$(call inherit-product, device/samsung/manta/full_manta.mk)

# Define Orca bootanimation size
ORCA_BOOTANIMATION_NAME := XHDPI

# OVERLAY_TARGET adds overlay asset source
OVERLAY_TARGET := pa_manta

# Build paprefs from sources
PREFS_FROM_SOURCE ?= true

# Include ORCA common configuration
include vendor/orca/config/orca_common.mk

# Product Package Extras - Repos can be added manually or via addprojects.py
-include vendor/orca/packages/manta.mk

# CM Package Extras
-include vendor/orca/packages/cm.mk

# Override AOSP build properties
PRODUCT_NAME := orca_manta
PRODUCT_BRAND := google
PRODUCT_MODEL := Nexus 10
PRODUCT_MANUFACTURER := Samsung
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=mantaray BUILD_FINGERPRINT="google/mantaray/manta:4.3/JWR66V/737497:user/release-keys" PRIVATE_BUILD_DESC="mantaray-user 4.3 JWR66V 737497 release-keys"

