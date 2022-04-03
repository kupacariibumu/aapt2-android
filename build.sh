NDK_TOOLCHAIN=$HOME/android-ndk-r23b/toolchains/llvm/prebuilt/linux-aarch64

cmake -G 'Ninja' \
    -DCMAKE_C_COMPILER=$NDK_TOOLCHAIN/bin/aarch64-linux-android30-clang \
    -DCMAKE_CXX_COMPILER=$NDK_TOOLCHAIN/bin/aarch64-linux-android30-clang++ \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
    -DCMAKE_SYSROOT=$NDK_TOOLCHAIN/sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    ..
      
cmake -G 'Ninja' \
    -DCMAKE_C_COMPILER=$NDK_TOOLCHAIN/bin/armv7a-linux-androideabi30-clang \
    -DCMAKE_CXX_COMPILER=$NDK_TOOLCHAIN/bin/armv7a-linux-androideabi30-clang++ \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
    -DCMAKE_SYSROOT=$NDK_TOOLCHAIN/sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    ..
    
cmake -G 'Ninja' \
    -DCMAKE_C_COMPILER=$NDK_TOOLCHAIN/bin/x86_64-linux-android30-clang \
    -DCMAKE_CXX_COMPILER=$NDK_TOOLCHAIN/bin/x86_64-linux-android30-clang++ \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
    -DCMAKE_SYSROOT=$NDK_TOOLCHAIN/sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    ..
    
cmake -G 'Ninja' \
    -DCMAKE_C_COMPILER=$NDK_TOOLCHAIN/bin/i686-linux-android30-clang \
    -DCMAKE_CXX_COMPILER=$NDK_TOOLCHAIN/bin/i686-linux-android30-clang++ \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
    -DCMAKE_SYSROOT=$NDK_TOOLCHAIN/sysroot \
    -DCMAKE_BUILD_TYPE=Release \
    ..

ninja -j16

llvm-strip -g aapt2
llvm-strip -g libaapt2_jni.so
llvm-strip -g aapt
llvm-strip -g aidl
llvm-strip -g zipalign
llvm-strip -g protoc

cp aapt2 /sdcard
cp libaapt2_jni.so /sdcard
cp aapt /sdcard
cp aidl /sdcard
cp zipalign /sdcard
cp protoc /sdcard