# Compiler
CXX    = g++

# IMPORTANT: The architecture must be i386 otherwise
# carbon will not be available and the OIS input will
# not work.
CFLAGS = -Wall -arch i386

# Output
OUT_TARGET    = OgreMake
CONTENT_PATH  = $(OUT_TARGET).app/Contents
RESOURCE_PATH = $(CONTENT_PATH)/Resources
COMP_PATH     = $(CONTENT_PATH)/Components
PLUGIN_PATH   = $(CONTENT_PATH)/Plugins
FRAME_PATH    = $(CONTENT_PATH)/Frameworks

# Ogre Directories
OGRE_HOME = /Developer/SDKs/OgreSDK
LIB_DIR   = $(OGRE_HOME)/lib
INC_DIR   = $(OGRE_HOME)/include

# Ogre sources
INCS += -I$(INC_DIR)/OGRE -I$(INC_DIR)/OGRE/OSX
LIBS += -L$(LIB_DIR)/release

# OIS
INCS += -I$(INC_DIR)/OIS
LIBS += -lOIS

# Boost
INCS += -I$(OGRE_HOME)/boost

# Frameworks (System)
FRAMEWORKS += -F/System/Library/Frameworks -F/Library/Frameworks
FRAMEWORKS += -framework Carbon -framework AppKit -framework Foundation -framework IOKit

# Frameworks (Ogre)
FRAMEWORKS += -F$(LIB_DIR)/release
FRAMEWORKS += -framework Cg -framework Ogre

#--------------------------------

# Application
SRCS += # PUT YOUR SOURCE FILES HERE # 

#--------------------------------

all: app copy
	$(CXX) $(SRCS) -o $(CONTENT_PATH)/MacOS/$(OUT_TARGET) $(CFLAGS) $(INCS) $(LIBS) $(FRAMEWORKS)

copy: app
	cp $(LIB_DIR)/libOgre* $(COMP_PATH)
	cp $(LIB_DIR)/Plugin* $(PLUGIN_PATH)
	cp $(LIB_DIR)/RenderSystem_GL.dylib $(PLUGIN_PATH)
	cp -R /Library/Frameworks/Cg.framework $(FRAME_PATH)/
	cp -R $(LIB_DIR)/release/Ogre.framework $(FRAME_PATH)/
	cp -R ./Resources/* $(RESOURCE_PATH)
	chmod -R u+rwx $(CONTENT_PATH)/*
	chmod -R go+r $(CONTENT_PATH)/*

app:
	mkdir -p ./$(OUT_TARGET).app
	mkdir -p ./$(CONTENT_PATH)
	mkdir -p ./$(CONTENT_PATH)/MacOS
	mkdir -p ./$(RESOURCE_PATH)
	mkdir -p ./$(COMP_PATH)
	mkdir -p ./$(PLUGIN_PATH)
	mkdir -p ./$(FRAME_PATH)

clean:
	rm -rf ./$(OUT_TARGET)
