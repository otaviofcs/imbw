module BeerVotesHelper

  def star_rating(value)
    link = ""
    link << "<div class='star-rating'>"
    link << "<ul>"
    (value.to_i - 5).upto(5) do |star|
      link << "<li>"
      link << star.to_s
      link << "</li>"
    end
    link << "</ul>"
    link << "<div class='clear'></div>"
    link << "</div>"
    link
  end
end
