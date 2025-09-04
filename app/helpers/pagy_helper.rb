module PagyHelper
  include Pagy::Frontend

  def pagy_bootstrap_nav(pagy)
    html = +%(<nav aria-label="Pagination"><ul class="pagination justify-content-center">)

    # Previous page
    if pagy.prev
      html << %(<li class="page-item"><a class="page-link" href="#{pagy_url(pagy, pagy.prev)}" aria-label="Previous">&laquo;</a></li>)
    else
      html << %(<li class="page-item disabled"><span class="page-link">&laquo;</span></li>)
    end

    # Page links
    pagy.series.each do |item|
      case item
      when Integer
        if item == pagy.page
          html << %(<li class="page-item active" aria-current="page"><span class="page-link">#{item}</span></li>)
        else
          html << %(<li class="page-item"><a class="page-link" href="#{pagy_url(pagy, item)}">#{item}</a></li>)
        end
      when String
        html << %(<li class="page-item disabled"><span class="page-link">#{item}</span></li>)
      end
    end

    # Next page
    if pagy.next
      html << %(<li class="page-item"><a class="page-link" href="#{pagy_url(pagy, pagy.next)}" aria-label="Next">&raquo;</a></li>)
    else
      html << %(<li class="page-item disabled"><span class="page-link">&raquo;</span></li>)
    end

    html << %(</ul></nav>)
    html.html_safe
  end
end
