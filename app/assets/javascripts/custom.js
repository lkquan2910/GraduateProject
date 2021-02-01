$(document).on('turbolinks:load', function () {
  $('.table-hover tbody tr td').each(function () {
    if ($(this).find('a.btn-edit').length == 0) {
      $(this).click(function () {
        if ($(this).parent().find('.btn-edit').length > 0) {
          $(this).parent().find('.btn-edit')[0].click();
        }
      })
    }
  })
});