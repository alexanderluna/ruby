jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      more_posts_url = $('.pagination .pagination .next_page a').attr('href')
      if more_posts_url && $(window).scrollTop() > $(document).height() - $(window).height() - 60
        $('.pagination').text("Cargando mas Oraciones")
        $.getScript more_posts_url
    $(window).scroll
