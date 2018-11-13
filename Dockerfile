FROM fedora 
# Install the appropriate software RUN dnf -y update && \
    dnf -y install firefox \
                   xorg-x11-twm \
                   tigervnc-server \
                   xterm xulrunner \
                   dejavu-sans-fonts  \
                   dejavu-serif-fonts \
				   java-openjdk-1.8.0 \
                   icedtea-web \
                   xdotool && \
    dnf clean all
# Add the xstartup file into the image and set the default password. RUN mkdir /root/.vnc
ADD ./xstartup /root/.vnc/
RUN chmod -v +x /root/.vnc/xstartup
RUN echo 123456 | vncpasswd -f > /root/.vnc/passwd
RUN chmod -v 600 /root/.vnc/passwd
RUN sed -i '/\/etc\/X11\/xinit\/xinitrc-common/a [ -x /usr/bin/firefox ] && /usr/bin/firefox &' /etc/X11/xinit/xinitrc
EXPOSE 5901 CMD    ["vncserver", "-fg" ]
# ENTRYPOINT ["vncserver", "-fg" ]
