export THEOS=/opt/theos
ARCHS = arm64 arm64e
# TARGET := iphone:clang:15.2:9.0
TARGET := iphone:clang:latest:7.0
MODULES = jailed
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = bb
bb_USE_FLEX=1
DISPLAY_NAME = bb
BUNDLE_ID = com.yourcompany.bb
PACKAGE_FORMAT=exo
bb_FILES = Tweak.xm
bb_IPA = /Users/kalashrah/Downloads/Jodel++_4.111_1667641638.ipa
bb__CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk
