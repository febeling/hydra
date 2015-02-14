
# Minimal iOS app

The application starts a hydra service in the Documents directory of
the app's sandbox. Posts are shown in a generic list by subject and
location.

# Building

The hydra repository has to be in a directory alongside it's
dependencies: libsodium, libzmq, czmq, zyre, and [ios-autotools][]. Of
these, all but the last are just dependencies of hydra itself.

```shell
cd app/ios/Hydra
./build_frameworks.sh
open Hydra.xcodeproj
```

Then run from Xcode IDE.

What happens in the `build_frameworks.sh` script? For all these
libraries to work on iOS devices and the simulators, they need to be
cross-compiled to the right processor architectures and linked against
the iOS SDK. This step is necessary before opening the Xcode project,
which already references the libraries as static, universal frameworks
in the right location.

Because of the way universal binaries are built from Autotools-based
projects, incremental building isn't possible with iOS targets. Maybe
there are better workarounds, but for now the whole project is
configure for one architecture at a time in a seperate location. This
is more time-consuming if development of the hydra components (or any
of the other Autotools-based dependencies) is involved, but necessary
as of now.

# References

[ios-autotools]: https://github.com/szanni/ios-autotools "ios-autotools scripts, for cross-compilation targeting iOS"
