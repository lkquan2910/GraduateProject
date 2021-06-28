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

  if ($('.first-col-stick').length > 0) {
    let first_col_stick_width = $('.first-col-stick').outerWidth();
    $('.second-col-stick').css('left', first_col_stick_width + 'px');
    $('.table-hover tbody tr').each(function () {
      $(this).mouseenter(function () {
        $(this).find('.first-col-stick, .second-col-stick, .last-col-stick').css('background-color', '#ededed');
      }).mouseleave(function () {
        $(this).find('.first-col-stick, .second-col-stick, .last-col-stick').css('background-color', 'white');
      })
    })
  }

  // Sidebar collapse and closed
  $("#sidebarToggle, #sidebarToggleTop").on("click", function (e) {
    $("body").toggleClass("sidebar-toggled"), $(".sidebar").toggleClass("toggled"), $(".sidebar").hasClass("toggled") && $(".sidebar .collapse").collapse("hide")
    if ($('.sidebar-dark').hasClass('toggled')) {
      $('#content-wrapper').css('cssText','margin-left: 104px !important');
    }
    else {
      $('#content-wrapper').css('cssText','margin-left: 224px !important');
    }
  }), $(window).resize(function () {
    $(window).width() < 768 && $(".sidebar .collapse").collapse("hide"), $(window).width() < 480 && !$(".sidebar").hasClass("toggled") && ($("body").addClass("sidebar-toggled"), $(".sidebar").addClass("toggled"), $(".sidebar .collapse").collapse("hide"))
  }), $("body.fixed-nav .sidebar").on("mousewheel DOMMouseScroll wheel", function (e) {
    if (768 < $(window).width()) {
      var o = e.originalEvent, l = o.wheelDelta || -o.detail;
      this.scrollTop += 30 * (l < 0 ? 1 : -1), e.preventDefault()
    }
  }), $(document).on("scroll", function () {
    100 < $(this).scrollTop() ? $(".scroll-to-top").fadeIn() : $(".scroll-to-top").fadeOut()
  }), $(document).on("click", "a.scroll-to-top", function (e) {
    var o = $(this);
    $("html, body").stop().animate({scrollTop: $(o.attr("href")).offset().top}, 1e3, "easeInOutExpo"), e.preventDefault()
  })

  // submit form has currency
  function stringToNumber(str) {
    return parseFloat(str.toString().split('.').join("").replace(/,/g, '.'));
  }

  function stringCommaToDot(str) {
    return parseFloat(str.toString().replace(/,/g, '.'));
  }

  if ($(".form-has-currency").length) {
    $(".form-has-currency").submit(function () {
      // currency
      $(this).find("input[data-type='currency']").each(function () {
        let price = $(this).val();
        if (price) {
          $(this).val(stringToNumber(price));
        }
      });
      // number
      $(this).find("input[data-type='number']").each(function () {
        let price = $(this).val();
        if (price) {
          $(this).val(stringCommaToDot(price));
        }
      });
    });
  }
});

let krajeeGetCount = function (id) {
  let cnt = $('#' + id).fileinput('getFilesCount');
  return cnt === 0 ? 'You have no files remaining.' :
    'You have ' + cnt + ' file' + (cnt > 1 ? 's' : '') + ' remaining.';
};

