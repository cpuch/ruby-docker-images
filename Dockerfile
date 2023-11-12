# Base image.
FROM debian:bookworm-slim

# Build arguments.
ARG RUBY_VERSION

# Environnment variables.
ENV DEBIAN_FRONTEND=noninteractive
ENV RUBY_VERSION=${RUBY_VERSION}

# Update base image.
RUN apt-get update && \
    apt-get upgrade -y

# Install base packages.
RUN apt-get install -y \
	autoconf \
	build-essential \
	ca-certificates \
	curl \
	git \
	gnupg \
	libdb-dev \
	libffi-dev \
	libgdbm6 \
	libgdbm-dev \
	libgmp-dev \
	libmariadb-dev-compat \
	libncurses5-dev \
	libpq-dev \
	libreadline6-dev \
	libsqlite3-dev \
	libssl-dev \
	libyaml-dev \
	lsb-release \
	nano \
	patch \
	rustc \
	uuid-dev \
	zlib1g-dev 

# Clear apt cache.
RUN rm -rf /var/libn/apt/lists/*

# Install rbenv and ruby-build.
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv
RUN git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
RUN echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> /etc/profile.d/rbenv
RUN echo 'eval "$(~/.rbenv/bin/rbenv init - bash)"' >> ~/.bashrc

# Install ruby.
RUN rbenv install ${RUBY_VERSION}
RUN rbenv gloabel ${RUBY_VERSION}

# Install bundler.
RUN gem install bundler
