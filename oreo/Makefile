include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = Oreo
Oreo_FILES = $(wildcard *.m)
Oreo_INSTALL_PATH = /Library/PreferenceBundles
Oreo_CFLAGS = -fobjc-arc
Oreo_FRAMEWORKS = UIKit
Oreo_PRIVATE_FRAMEWORKS = Preferences
Oreo_EXTRA_FRAMEWORKS = Cephei CepheiPrefs

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/Oreo.plist$(ECHO_END)
