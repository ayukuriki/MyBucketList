FROM amd64/ruby:2.7.3

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && \
    apt-get install -y nodejs    

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /bucketlist
WORKDIR /bucketlist

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /bucketlist/Gemfile
ADD Gemfile.lock /bucketlist/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /bucketlist

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets

FROM ubuntu:latest
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

RUN apt-get update && apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:mozillateam/firefox-next
RUN apt-get update && apt-get install -y firefox \
  && rm -rf /var/lib/apt/lists/*

RUN firefox -CreateProfile "headless /moz-headless"  -headless
ADD user.js /moz-headless/

ADD index.html /root/

EXPOSE 6000
CMD ["firefox", "-p", "headless", "-headless", "--start-debugger-server", "6000", "file:///root/index.html"]
