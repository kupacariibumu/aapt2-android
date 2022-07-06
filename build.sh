#!/bin/bash

compile() {
    arch="$1"
    c_compiler=""
    cxx_compiler=""
    case $arch in
    "arm64-v8a")
        c_compiler="aarch64-linux-android30-clang"
        cxx_compiler="aarch64-linux-android30-clang++"
        ;;
    "armeabi-v7a")
        c_compiler="armv7a-linux-androideabi30-clang"
        cxx_compiler="armv7a-linux-androideabi30-clang++"
        ;;
    "x86")
        c_compiler="i686-linux-android30-clang"
        cxx_compiler="i686-linux-android30-clang++"
        ;;
    "x86_64")
        c_compiler="x86_64-linux-android30-clang"
        cxx_compiler="x86_64-linux-android30-clang++"
        ;;
    *)
        echo "Unknown architecture: $arch"
        exit 1
        ;;
    esac
    currentdir="$(pwd)"
    outdir="$currentdir/dist/$arch"

    rm -rf "build"
    rm -rf "$outdir"
    
    mkdir "build" && cd "build" || exit 1

    cmake -G 'Ninja' \
        -DCMAKE_C_COMPILER="$NDK_TOOLCHAIN/bin/$c_compiler" \
        -DCMAKE_CXX_COMPILER="$NDK_TOOLCHAIN/bin/$cxx_compiler" \
        -DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
        -DCMAKE_SYSROOT="$NDK_TOOLCHAIN/sysroot" \
        -DCMAKE_BUILD_TYPE=Release \
        -DANDROID_ABI="$arch" \
        .. || exit 1

    ninja -j16 || exit 1

    "$NDK_TOOLCHAIN/bin/llvm-strip" --strip-unneeded "tools/aapt"
    "$NDK_TOOLCHAIN/bin/llvm-strip" --strip-unneeded "tools/aapt2"
    "$NDK_TOOLCHAIN/bin/llvm-strip" --strip-unneeded "tools/libaapt2_jni.so"
    "$NDK_TOOLCHAIN/bin/llvm-strip" --strip-unneeded "tools/zipalign"
    
    mkdir -p "$outdir"
    mv "tools/aapt" "$outdir"
    mv "tools/aapt2" "$outdir"
    mv "tools/libaapt2_jni.so" "$outdir"
    mv "tools/zipalign" "$outdir"
    
    cd "$currentdir" || exit 1
}

build() {
    for arch in "arm64-v8a" \
        "armeabi-v7a" \
        "x86" \
        "x86_64"; do
            compile $arch
    done
}

packageAndClean() {
    rm -rf "build"
    rm "tools-all.zip"
    zip -r "tools-all.zip" "dist/*"
    rm -rf "dist"
}

main() {
    if [[ -z "${NDK_TOOLCHAIN}" ]]; then
        echo "Please specify the Android NDK environment variable \"NDK_TOOLCHAIN\"."
        exit 1
    fi
    echo "build started"
    build
    packageAndClean
    echo "All done!"
}

main
