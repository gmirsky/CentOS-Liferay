FROM centos-jdk

MAINTAINER Gregory N. Mirsky <gmirsky@gmail.com>

RUN yum update -y
RUN yum install -y epel-release
RUN yum install -y \
    unzip \
    supervisor
RUN yum clean all
RUN groupadd liferay && useradd  -g liferay -d /home/liferay -s /bin/bash -p 'L1f3r@y' liferay 

ENV LIFERAY_HOME=/usr/local/liferay-ce-portal-7.0-ga4
ENV CATALINA_HOME=$LIFERAY_HOME/tomcat-8.0.32
ENV PATH=$CATALINA_HOME/bin:$PATH
ENV LIFERAY_TOMCAT_URL=https://sourceforge.net/projects/lportal/files/Liferay%20Portal/7.0.3%20GA4/liferay-ce-portal-tomcat-7.0-ga4-20170613175008905.zip/download

WORKDIR /usr/local

RUN mkdir -p "$LIFERAY_HOME" \
			&& set -x \
			&& curl -fSL "$LIFERAY_TOMCAT_URL" -o liferay-ce-portal-tomcat-7.0-ga4-20170613175008905.zip \
			&& unzip liferay-ce-portal-tomcat-7.0-ga4-20170613175008905.zip \
			&& rm liferay-ce-portal-tomcat-7.0-ga4-20170613175008905.zip \
      && chown -R liferay:liferay $LIFERAY_HOME

EXPOSE 8080/tcp
EXPOSE 11311/tcp

USER liferay

ENTRYPOINT ["catalina.sh", "run"]

