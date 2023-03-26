# Ruby 3.2.1
FROM ruby:3.2.1 

# パッケージ管理システムを最新版に更新(エラー以外表示しない) && ビルドツール
RUN apt-get update -qq && apt-get install -y build-essential nodejs vim

# docker build時に--build-arg <変数名>=<値>フラグを定義するもの
ARG WORKDIR
ENV WORKDIR $WORKDIR

# 作業ディレクトリを作成 & 指定
RUN mkdir ${WORKDIR}
WORKDIR ${WORKDIR}

# GemfileとGemfile.lockを作業ディレクトリにコピーして、gemをインストール
COPY Gemfile Gemfile.lock ${WORKDIR}/

RUN gem update --system
RUN bundle update --bundler

RUN bundle install

COPY . ${WORKDIR}

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# # 3000ポートを指定（実際に開けるわけではなくドキュメンテーションとして記載）
# EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]