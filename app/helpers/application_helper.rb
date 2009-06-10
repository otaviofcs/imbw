# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # Retorna divs para o flash especificado, com a mensagem do flash como
  # conteúdo do div dentro de um parágrafo e classes no div de acordo com o tipo
  # do flash.
  #
  # Exemplo:
  #
  #   >> flash[:notice] = "Sucesso absoluto!"
  #   >> display_flashes
  #   => "<div class=\"flash\ id=\"flash_notice\"><p>Sucesso absoluto!</p></div>"
  #
  def display_flashes
    return nil if flash.empty?
    html = ''
    flash.each do |key, message|
      flash_message = content_tag(:p, message)
      close_link = content_tag(
        :span,
        link_to_function('fechar', "$(this).up('#flash_#{key}').remove()"),
        :class => 'close'
      )
      html << content_tag(:div, close_link + flash_message, :class => 'flash', :id => "flash_#{key}")
    end
    html
  end

  def disqus_comments_tag(disqus_site_id)
    html = ""
    html << javascript_tag("var disqus_developer = 1;") if Rails.env.development? && Settings::DISQUS_IN_DEVELOPMENT
    html << %{<div id="disqus_thread"></div><script type="text/javascript" src="http://disqus.com/forums/#{disqus_site_id}/embed.js"></script><noscript><a href="http://#{disqus_site_id}.disqus.com/?url=ref">View the discussion thread.</a></noscript><a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>}
    html
  end

  def disqus_comment_counter_tag(disqus_site_id)
    return if Rails.env.development? && !Settings::DISQUS_IN_DEVELOPMENT
    html = javascript_tag do
      <<-eos
      (function() {
      var links = document.getElementsByTagName('a');
      var query = '?';
      for(var i = 0; i < links.length; i++) {
      if(links[i].href.indexOf('#disqus_thread') >= 0) {
      query += 'url' + i + '=' + encodeURIComponent(links[i].href) + '&';
      }
      }
      document.write('<script charset="utf-8" type="text/javascript" src="http://disqus.com/forums/#{disqus_site_id}/get_num_replies.js' + query + '"></' + 'script>');
      })();
      eos
    end
    html
  end

end
