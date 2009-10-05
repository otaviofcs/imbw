module BeerVotesHelper

  def beer_vote_link(beer_vote)
    title = beer_vote.title
    link_to title, beer_vote_url(:id => "#{beer_vote.id}-#{h( beer_vote.title.gsub(' ','-') )}" ), :class => 'link-beer-vote'
  end

  def star_rating(value)
    rating_value = value
    rating_value = 5.0 if value > 5
    rating_value = 0 if value < 0
    link = ""
    link << "<div class='star-rating'>"
    link << "<ul>"
    (6 - rating_value.to_i).upto(5) do
      link << "<li>"
      link << image_tag("star-high.gif", :alt => "nota: #{rating_value}", :title => "nota: #{rating_value}")
      link << "</li>"
    end
    if (rating_value * 10 % 10) == 5.0
      link << "<li>"
      link << image_tag("star-high-half.gif", :alt => "nota: #{rating_value}", :title => "nota: #{rating_value}")
      link << "</li>"
    end
    link << "</ul>"
    link << "<div class='clear'></div>"
    link << "</div>"
    link
  end
end
