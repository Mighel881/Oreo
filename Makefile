export TARGET = iphone:9.3

CFLAGS = -fobjc-arc -O2

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Oreo
Oreo_FILES = Tweak.x $(wildcard *.x) $(wildcard *.m)
Oreo_FRAMEWORKS = UIKit QuartzCore
Oreo_EXTRA_FRAMEWORKS = Cephei

include $(THEOS_MAKE_PATH)/tweak.mk
