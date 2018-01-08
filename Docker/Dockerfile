FROM tibco/bwce:v2.3.2.centos
MAINTAINER wkarasz@tibco.com
ADD content.zip /
RUN unzip /content.zip -d /content && chmod +x /content/install_prep1.sh && chmod +x /content/install_prep2.sh && chmod +x /content/get_hostname.sh && chmod +x /content/get_ip.sh
EXPOSE 8443
ADD mftCCdocker_1.0.4.ear /