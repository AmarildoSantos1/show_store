# Use a imagem oficial do Ruby com a versão desejada
FROM ruby:2.7.6

# Atualize o sistema e instale as dependências necessárias
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Configure a pasta de trabalho no contêiner
WORKDIR /app

# Copie o Gemfile e o Gemfile.lock para o contêiner
COPY Gemfile Gemfile.lock ./

# Instale as gemas
RUN gem install bundler && bundle install
RUN bundle exec rails assets:precompile
RUN rails active_storage:install
RUN rails g rails_admin:install
RUN rails db:migrate RAILS_ENV=development

# Copie o restante do código-fonte para o contêiner
COPY . .

# Exponha a porta em que a aplicação Rails será executada
EXPOSE 3000

# Comando padrão para iniciar a aplicação
CMD ["rails", "server", "-b", "0.0.0.0"]
