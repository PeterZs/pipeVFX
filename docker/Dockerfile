FROM centos:centos7.6.1810

RUN yum update -y && yum install -y \
    nano \
    csh \
    libXp \
    libXmu \
    libXpm \
    libXi \
    libtiff \
    libXinerama \
    elfutils \
    gcc \
    gstreamer-plugins-base.x86_64 \
    gamin \
    git \
    scons \
    mesa-utils \
    mesa-libGL-devel \
    tcsh \
    xorg-x11-server-Xorg \
    xorg-x11-server-Xvfb \
    git \
    gcc-c++ \
    make \
    libXinerama-devel \
    libXext-devel \
    libXrandr-devel \
    libXi-devel \
    libXcursor-devel \
    libXxf86vm-devel \
    mesa-libGLU libpng12 SDL freetype2 xorg-x11-fonts* \
    vulkan-devel \
    wget && \
    yum groupinstall -y "X Window System" "Fonts"


RUN yum group install -y "Development Tools"
RUN yum -y install xorg-x11-fonts*
RUN fc-cache

RUN yum -y install epel-release && yum -y install python2-scons

RUN ln -s /lib64/libbz2.so.1 /lib64/libbz2.so.1.0 ; \
    ln -s libcrypto.so.1.0.2k /usr/lib64/libcrypto.so.10 ; \
    ln -s libcrypto.so.0.9.8e /usr/lib64/libcrypto.so.6 ; \
    ln -s libssl.so.1.0.2k /usr/lib64/libssl.so.10 ; \
    ln -s libssl.so.0.9.8e /usr/lib64/libssl.so.6 ; \
    ln -s /usr/bin/ar /usr/sbin/ar

RUN fc-cache
RUN yum -y install source-highlight
RUN yum -y install ncurses ncurses-devel ncurses-static
RUN yum -y install sqlite-devel libdb-devel
RUN yum -y install gdbm-devel tkinter
RUN yum -y install libcurl-devel
RUN yum -y install mesa-libGLU-devel
RUN yum -y install dbus-devel dbus-glib-devel
RUN yum -y install cmake
RUN yum clean all
RUN rm -rf /var/cache/yum/*

#_tkinter           bsddb185           dl
#imageop            sunaudiodev

RUN ln -s /usr/bin/ranlib /usr/sbin/ranlib
