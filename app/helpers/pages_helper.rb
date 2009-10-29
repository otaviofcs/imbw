module PagesHelper

  def recent_box(recent_activity)
    self.send("#{recent_activity.recentable.class.name.underscore}_box".to_sym, recent_activity.recentable)
  end

  def post_box(post)
    content_tag(:div, :class => 'index_box') do
      html = ""
      html << content_tag(:h3) do
        html2 = link_to(image_tag('w_mini.png', :alt => 'Writing', :title => 'Artigos escritos aqui, no imbw.'), posts_path)
        html2 << link_to('Writing', posts_path, :title => 'Artigos escritos aqui, no imbw.')
        html2
      end
      html << content_tag(:p) do
        "#{post_link(post, 80, 'normal')}"
      end
      html
    end
  end

  def comment_box(comment)
    content_tag(:div, :class => 'index_box') do
      html = ""
      html << content_tag(:h3) do
        html2 = link_to(image_tag('o_mini.png', :alt => 'Observing', :title => 'Últimos comentários sobre as fotos.'), galleries_path)
        html2 << link_to('Observing', galleries_path, :title => 'Últimos comentários sobre as fotos.')
        html2
      end
      html << content_tag(:p) do
        html2 = content_tag(:span, "#{comment.name}", :class => 'destaque')
        html2 << " comentou em um álbum de fotos: "
        html2 << comment.comment
        html2
      end
      html
    end
  end

  def beer_vote_box(beer_vote)
    content_tag(:div, :class => 'index_box') do
      html = ""
      html << content_tag(:h3) do
        html2 = link_to(image_tag('g_mini.png', :alt => 'Gristing', :title => 'Cervejas. Aqui, só impressão sobre cervejas que bebi.'), beer_votes_path)
        html2 << link_to('Gristing', beer_votes_path, :title => 'Cervejas. Aqui, só impressão sobre cervejas que bebi.')
        html2
      end
      html << content_tag(:div, :class => 'text_box') do
        html2 = star_rating(beer_vote.vote) if beer_vote.vote
        html2 << "&nbsp;foi a nota para #{beer_vote_link beer_vote}"
        html2 << content_tag(:div, "&nbsp;", :class => "clear")
        html2
      end
      html
    end
  end

  def link_box(link)
    content_tag(:div, :class => 'index_box') do
      html = ""
      html << content_tag(:h3) do
        html2 = link_to(image_tag('r_mini.png', :alt => 'Reading', :title => 'Links de artigos interessantes na internet.'), links_path)
        html2 << link_to('Reading', links_path, :title => 'Links de artigos interessantes na internet.')
        html2
      end
      html << content_tag(:p) do
        link_for_links(link)
      end
      html
    end
  end

  def note_box(note)
    content_tag(:div, :class => 'index_box') do
      html = ""
      html << content_tag(:h3) do
        html2 = link_to(image_tag('n_mini.png', :alt => 'Taking Notes', :title => 'Pensamentos. Últimos pensamentos.'), notes_path)
        html2 << link_to('Taking Notes', notes_path, :title => 'Pensamentos. Últimos pensamentos.')
        html2
      end
      html << content_tag(:p) do
        link_to truncate(note.note, :length => 80, :omission => "..."), note_path(note)
      end
      html
    end
  end
end
