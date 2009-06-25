module BeerVotesHelper

  def star_rating(value)
    link = ""
    link << "<div class='star-rating'>"
    link << "<span>Voto</span>"
    link << "<ul>"
    link << "</ul>"
    link << "<div class='clear'></div>"
    link << "</div>"
    link
  end
end
