#!/usr/bin/env ruby
# 
# é só preencher a configuração abaixo e rodar este script de tantos em tantos 
# minutos, via cron, com:
# 
#   $ ruby twitter_aggregator.rb
# 

# configuração (com exemplos)
AGGREGATORS = [
  {
    :login => 'teste_agg_1',                         # login do perfil agregador
    :password => '123456',                           # senha do perfil agregador
    :profiles => %w( lidador zonasul paodeacucar ),  # perfis à observar
    :keywords => %w( cerveja chopp )                 # palavras chave para filtrar dos tweets dos perfis observados
  },
  {
    :login => 'teste_agg_2', 
    :password => '123456', 
    :profiles => %w( emporio expand lidador ),
    :keywords => %w( vinho champagne )
  }
]
# fim configuração
# não precisa alterar mais nada

$KCODE = 'utf8'
require 'rubygems'
require 'twitter'

def run
  AGGREGATORS.each do |aggregator|
    retweets = []
    aggregator[:profiles].each do |profile|
      aggregator[:keywords].each do |keyword|
        search = Twitter::Search.new(keyword).from(profile).fetch # busca no timeline público recente do perfil observado
        unless search.results.empty?
          search.results.each do |tweet|
            retweets << "RT @#{tweet.from_user}: #{tweet.text}" # texto para o retweet
          end
        end
      end
    end
    httpauth = Twitter::HTTPAuth.new(aggregator[:login], aggregator[:password]) # login como agregador atual
    client = Twitter::Base.new(httpauth)
    retweets.each do |rt|
      client.update(rt) # posta o retweet
    end
  end
end

if $0 == __FILE__
  run
end

