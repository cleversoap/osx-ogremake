# OSX OgreMake

[OGRE3D](http://www.ogre3d.org/) is an extraordinary multi-platform rendering engine that focuses on simplicity and flexibility - so why is it always tied to (in my opinion) clunky IDEs?

Configuring and getting started with OGRE is extremely simple on other platforms such as Windows but the configuration process in XCode has become an annoyance (and now uneccessary). As a Vim fanatic I much prefer plain text editing and so with that I present a Makefile for building OGRE applications quickly and easily with minimal effort, just add your source files and you're ready to go (but please read the rest of this README).

## Prerequisites

This Makefile was created on OSX 10.8 but as the requirements for OGRE on OSX are actually quite low it's entirely likely that this will not need any or just minimal changes to work with pre 10.6 systems. As this is just a Makefile it's up to you edit the compilation process as the primary function here is just to link libraries and files to make an App and not the actual compilation itself - I've tried to make this process as simple as possible. I don't know why I'm telling you this, you know what a Makefile is.

### [Ogre OSX SDK](http://sourceforge.net/projects/ogre/files/ogre/1.8/1.8.0/OgreSDK_v1-8-0.dmg/download)
The standard location for this is in __/Developer/SDKs/OgreSDK__ however you can just change _$OGRE_HOME_ in the Makefile to wherever you extracted it.

### [NVIDIA Cg Toolkit](http://developer.download.nvidia.com/cg/Cg_3.1/Cg-3.1_April2012.dmg)
The standard location for this is in __/Library/Frameworks__

### G++
I used the g++ (4.2.1) provided by [XCode](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12) however there is no reason why you can't use the one provided by [Homebrew](http://mxcl.github.com/homebrew/). If you do choose to use XCode then please install the Command Line Tools package. Please check if there are any changes for framework and library linking for your compiler.

## Notes
__There is a _SRCS_ variable in the Makefile. This is where you will put your source files for compilation. Simple add on to the _INCS_ variable if you have any additional header directories.__

The XCode 4 manual on the OGRE wiki explains this more fully but OGRE requires some additional work to get running on OSX.

```c++
#include <macUtils.h>
```

Add then add this to the top of your main function:

```c++
Ogre::String workingDir = Ogre::macBundlePath()+"/Contents/Resources";
chdir(workingDir.c_str());
```

This will work with the [OGRE Wiki Tutorial Framework](http://www.ogre3d.org/tikiwiki/tiki-index.php?page=Ogre+Wiki+Tutorial+Framework) as per the edits above (more info in the manual configuration for XCode article).

Simply call ```make all``` to build the app in the current directory.

## References
[Manually Configure an Xcode 4 Project @ Ogre3D Wiki](http://www.ogre3d.org/tikiwiki/tiki-index.php?page=Manually+configure+an+Xcode+4+project)
