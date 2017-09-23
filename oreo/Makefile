CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = oreo
oreo_FILES = $(wildcard *.m)
oreo_INSTALL_PATH = /Library/PreferenceBundles
oreo_FRAMEWORKS = UIKit
oreo_PRIVATE_FRAMEWORKS = Preferences
oreo_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/oreo.plist$(ECHO_END)
