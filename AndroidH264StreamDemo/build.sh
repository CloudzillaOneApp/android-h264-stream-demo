#!/bin/bash
ANDROID_BUILD=28.0.3
ANDROID_VERSION=android-25

echo "Clean..."
rm -rf ./bin/* ./obj/*

${ANDROID_HOME}/build-tools/${ANDROID_BUILD}/aapt package -f -m -J src -M AndroidManifest.xml -S res -I ${ANDROID_HOME}/platforms/${ANDROID_VERSION}/android.jar

echo "Compile..."
javac -d obj -classpath src -bootclasspath ${ANDROID_HOME}/platforms/${ANDROID_VERSION}/android.jar src/com/jemi/androidh264streamdemo/*.java

echo "Package..."
${ANDROID_HOME}/build-tools/${ANDROID_BUILD}/dx --dex --output=bin/classes.dex obj
${ANDROID_HOME}/build-tools/${ANDROID_BUILD}/aapt package -f -m -F ./bin/androidh264streamdemo.unaligned.apk -M AndroidManifest.xml -S res -I ${ANDROID_HOME}/platforms/${ANDROID_VERSION}/android.jar

cd bin; ${ANDROID_HOME}/build-tools/${ANDROID_BUILD}/aapt add androidh264streamdemo.unaligned.apk classes.dex; cd ..

echo "Align and sign..."
${ANDROID_HOME}/build-tools/${ANDROID_BUILD}/zipalign -f 4 ./bin/androidh264streamdemo.unaligned.apk ./bin/androidh264streamdemo.apk

# >>>> Put the right path to the keystore as needed.
${ANDROID_HOME}/build-tools/${ANDROID_BUILD}/apksigner sign --ks ~/.ssh/mykey.keystore ./bin/androidh264streamdemo.apk
