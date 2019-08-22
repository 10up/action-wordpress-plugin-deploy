FROM debian:stable-slim

LABEL "com.github.actions.name"="WordPress Plugin Deploy"
LABEL "com.github.actions.description"="Deploy to the WordPress Plugin Repository"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

LABEL maintainer="Helen Hou-Sandí <helen.y.hou@gmail.com>"
LABEL version="1.2.1"
LABEL repository="http://github.com/helen/action-wordpress-plugin-deploy"

RUN apt-get update \
	&& apt-get install -y subversion rsync git \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/* \
	&& git config --global user.email "10upbot+github@10up.com" \
	&& git config --global user.name "10upbot on GitHub"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
