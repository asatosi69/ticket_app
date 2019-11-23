#= require active_admin/base
$ ->
  path = location.pathname
  if path.match(/\/admin\/tickets\/edit_ticket_links/)
    $('.menu_item').removeClass('current')
    $('#公演とチケット種別の組み合わせ').addClass('current')
  if path.match(/\/admin\/users\/show_ticket_summary/)
    $('.menu_item').removeClass('current')
    $('#集計').addClass('current')
