export TARGET = iphone:9.3

CFLAGS = -fobjc-arc

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = Oreo
Oreo_FILES = $(wildcard *.x) $(wildcard *.m)
Oreo_FRAMEWORKS = UIKit QuartzCore
Oreo_EXTRA_FRAMEWORKS = Cephei
Oreo_LIBRARIES = applist

SUBPROJECTS = oreo

include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
