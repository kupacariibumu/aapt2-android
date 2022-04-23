#!/bin/bash

installDeps() {
  echo "Installing dependencies..."
  pkg install build-essential unzip nasm cmake ninja || exit 1
}

compileTools() {
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

  if [ -d "$outdir" ]; then
    echo "Skipping compilation against target $arch because it already exists."
    echo "Please delete $outdir and re-run this script to recompile against target $arch."
    return 0
  fi

  echo "Compiling against target: $arch"
  echo "NDK toolchain: ${NDK_TOOLCHAIN}"
  echo "Output will be saved in: $outdir"
  echo "Compiling..."
  rm -rf "build"
  mkdir "build" && cd "build" || exit 1

  cmake -G 'Ninja' \
    -DCMAKE_C_COMPILER="$NDK_TOOLCHAIN/bin/$c_compiler" \
    -DCMAKE_CXX_COMPILER="$NDK_TOOLCHAIN/bin/$cxx_compiler" \
    -DCMAKE_BUILD_WITH_INSTALL_RPATH=True \
    -DCMAKE_SYSROOT="$NDK_TOOLCHAIN/sysroot" \
    -DCMAKE_BUILD_TYPE=Release \
    -DARCH="$arch" \
    .. || exit 1

  ninja -j16 || exit 1

  llvm-strip -g "aapt2"
  llvm-strip -g "libaapt2_jni.so"
  llvm-strip -g "aapt"
  llvm-strip -g "aidl"
  llvm-strip -g "zipalign"
  llvm-strip -g "protoc"

  mkdir -p "$outdir"
  
  mv "aapt2" "$outdir"
  mv "libaapt2_jni.so" "$outdir"
  mv "aapt" "$outdir"
  mv "aidl" "$outdir"
  mv "zipalign" "$outdir"
  mv "protoc" "$outdir"

  cd "$currentdir" || exit 1
}

buildTools() {
  echo "Building tools, this may take a while..."
  
  echo "Unzipping sources..."
  unzip -q -o src.zip

  mkdir -p "dist"
  for arch in "arm64-v8a" \
    "armeabi-v7a" \
    "x86" \
    "x86_64"; do
      compileTools $arch
  done
}

cleanBuild() {
  echo "Cleaning..."
  rm -rf "build"
  rm -rf "src"
}

main() {
  if [[ -z "${NDK_TOOLCHAIN}" ]]; then
    echo "Please specify the Android NDK environment variable \"NDK_TOOLCHAIN\"."
    exit 1
  fi
  echo "Building..."
  installDeps
  buildTools
  cleanBuild
  echo "All done!"
}

main
