# adaptado de http://railscasts.com/episodes/85
APP_CONFIG = YAML.load_file("#{RAILS_ROOT}/config/application.yml")[RAILS_ENV]

module Settings
  DISQUS_SITE_ID = APP_CONFIG['disqus_site_id']
  DISQUS_IN_DEVELOPMENT = APP_CONFIG['disqus_in_development']
end

