# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"

  # sistema de autenticação
  config.gem "authlogic", :version => ">= 2.1.1"

  # Biblioteca para escrever views em haml ao inves de html
  config.gem "haml", :lib => "haml", :version => ">= 2.2.3"

  # gem para tornar mais simples buscas e ordenação
  config.gem "binarylogic-searchlogic", :lib => 'searchlogic', :source => 'http://gems.github.com', :version => '~> 2.3.3'

  # tagging
  config.gem 'mbleigh-acts-as-taggable-on', :lib => 'acts-as-taggable-on', :version => '>= 1.0.5', :source => 'http://gems.github.com'

  # paginação
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :version => '>= 2.3.11', :source => 'http://gems.github.com'

  config.gem 'RedCloth', :lib => 'redcloth', :version => '>= 4.2.2'

  config.gem "aws-s3", :lib => "aws/s3", :version => ">= 0.6.2"

  config.gem "twitter", :lib => "twitter", :version => ">= 0.6.15"

  config.gem "crack", :lib => "crack", :version => ">= 0.1.4"

  # Gems do brazilian-rails usadas
  config.gem 'brnumeros', :version => '2.1.8'
  config.gem 'brdinheiro', :version => '2.1.8'

  # usando o mini_magick como processador de imagens do ImageMagick
  # ele é que vai criar os thumbnails ao usar o attachment_fu
  config.gem 'mini_magick', :lib => 'mini_magick', :version => '1.2.5'
  # config.gem 'image_science', :lib => 'image_science', :version => '1.2.1'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
  config.active_record.observers = :link_observer, :post_observer, :note_observer, :comment_observer, :beer_vote_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  # The default locale is :pt and all translations from app/locales/*.rb,yml are auto loaded.
  config.i18n.load_path += Dir[File.join(RAILS_ROOT, 'app', 'locales', '**', '*.{rb,yml}')]
  config.i18n.default_locale = :pt

end
