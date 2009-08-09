# Uso. no cron coloque uma linha como:
# 0 3 * * * cd /home/otaviofcs/imightbewrong.com.br && /usr/bin/rake RAILS_ENV=production imbw:beer_votes:create > /dev/null
namespace :imbw do

  namespace :beer_votes do
    desc "Votos em cervejas"
    task :create => :environment do
      puts "Atualizando votos..."
      updated_votes = BeerVote.fetch_and_create_votes
      puts "Feito."
      puts " > #{updated_votes}"
    end
  end
  namespace :links do
    desc "links do RPLinks"
    task :create => :environment do
      puts "Atualizando links..."
      updated = Link.parse_rss_feed
      puts "Feito."
      puts " > #{updated.size} links criados"
    end
    desc "links do Google Reader"
    task :create_from_google_reader => :environment do
      puts "Atualizando links..."
      updated = Link.parse_google_reader_feed
      puts "Feito."
      puts " > #{updated.size} links criados"
    end
  end
  namespace :notes do
    desc "anotações no Twitter"
    task :create => :environment do
      puts "Atualizando anotações..."
      updated = Note.create_notes_from_twitter
      puts "Feito."
      puts " > #{updated.size} anotações criadas"
    end
  end
end