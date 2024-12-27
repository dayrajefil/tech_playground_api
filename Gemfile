# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.0'

# Rails Framework
gem 'rails', '~> 7.1.5', '>= 7.1.5.1'

# Banco de dados
gem 'pg', '~> 1.1'

# Servidor
gem 'puma', '>= 5.0'

# Gerenciamento de fuso horário
gem 'tzinfo-data', platforms: %i[windows jruby]

# Otimização de boot
gem 'bootsnap', require: false

# Internacionalização
gem 'i18n'

# Paginação
gem 'kaminari'

# Geração de dados fictícios
gem 'faker'

# Extensões do RuboCop para melhorar a análise de código
gem 'rubocop-factory_bot', '~> 2.22.0', require: false
gem 'rubocop-rails', '~> 2.0', require: false
gem 'rubocop-rspec', '~> 2.0', require: false
gem 'rubocop-rspec_rails', '~> 2.28.0', require: false

# Tratar CSV
gem 'csv'

gem 'enumerate_it'

group :development, :test do
  # Debugging
  gem 'byebug'

  # Testes unitários com RSpec
  gem 'rspec-rails'

  # Analisador de código RuboCop
  gem 'rubocop'

  # Criação de seeds e testes com FactoryBot
  gem 'factory_bot_rails'

  # Mocks para testes
  gem 'webmock'
end
