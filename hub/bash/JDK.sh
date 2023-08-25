#!/bin/bash
echo "JDK PATH(/usr/lib/jvm/jdk_xxx/):"
read path
echo "Select JDK Version:"
echo "update-alternatives --install /usr/bin/java java ${path}bin/java 1"
echo "kali" | sudo -S update-alternatives --install /usr/bin/java java ${path}bin/java 1
echo "update-alternatives --install /usr/bin/javac javac ${path}bin/javac 1"
echo "kali" | sudo -S update-alternatives --install /usr/bin/javac javac ${path}bin/javac 1
echo "update-alternatives --set java ${path}bin/java"
echo "kali" | sudo -S update-alternatives --set java ${path}bin/java
echo "update-alternatives --set javac ${path}bin/javac"
echo "kali" | sudo -S update-alternatives --set javac ${path}bin/javac
echo "Select JDK Version:"
echo "update-alternatives --config java"
update-alternatives --config java