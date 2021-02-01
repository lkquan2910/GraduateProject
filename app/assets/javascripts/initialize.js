function readURL(input) {
  if (input.files && input.files[0]) {
    let reader = new FileReader();
    reader.onload = function (e) {
      $('.image-preview').attr('src', e.target.result);
    };
    reader.readAsDataURL(input.files[0]);
  }
}

$('.logo').change(function () {
  readURL(this);
});

$(document).on("turbolinks:before-cache", function () {
  // $('select.select2').select2('destroy');
  $('select').each( function() {
    if ($(this).hasClass("select2-hidden-accessible")) $(this).select2('destroy');
  });
});

$(document).on('turbolinks:load', function () {
  $('.gp-select2').select2({
    theme: 'bootstrap',
    language: 'vi',
    placeholder: 'Vui lòng chọn'
  });
  // Sidebar collapse and closed
  $("#sidebarToggle, #sidebarToggleTop").on("click", function (e) {
    $("body").toggleClass("sidebar-toggled"), $(".sidebar").toggleClass("toggled"), $(".sidebar").hasClass("toggled") && $(".sidebar .collapse").collapse("hide")
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

  if ($(".gp-icheck").length > 0) {
    $(".gp-icheck").each(function () {
      var $el = $(this);
      var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
        color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
      var opt = {
        checkboxClass: 'icheckbox' + skin + color,
        radioClass: 'iradio' + skin + color,
      };
      $el.iCheck(opt);
    });
  }

  $('.datepicker').datepicker({
    dateFormat: 'dd/mm/yy',
    showOtherMonths: true,
    firstDay: 1,
    monthNames: ['Tháng Một', 'Tháng Hai', 'Tháng Ba', 'Tháng Tư', 'Tháng Năm', 'Tháng Sáu', 'Tháng Bảy', 'Tháng Tám', 'Tháng Chín', 'Tháng Mười', 'Tháng Mười Một', 'Tháng Mười Hai'],
    monthNamesShort: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
    dayNames: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
    dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
    dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7']
  });

  // bsCustomFileInput.init();

  if ($('.field_with_errors').length > 0) {
    let errors = $('.field_with_errors');
    let errors_input = errors.find('.form-control')[0];
    if (errors.find('input[type=text]')[0] === undefined && errors.find('input[type=number]')[0] === undefined && errors.find('.gp-select2')[0] === undefined) {
      errors.find('.btn-file').focus();
    } else {
      let length = errors_input.value.length;
      errors_input.focus();
      if (length > 0) {
        errors_input.setSelectionRange(length, length);
      }
    }
  }
});

$(document).on('cocoon:after-insert', '#appointments, #calls, #online-feedbacks', function (e, insertedItem) {
  insertedItem.find('.datetimepicker').datetimepicker({
    format: 'd/m/Y H:i',
    lang: 'vi'
  })

  if ($(".gp-icheck").length > 0) {
    $(".gp-icheck").each(function () {
      var $el = $(this);
      var skin = ($el.attr('data-skin') !== undefined) ? "_" + $el.attr('data-skin') : "",
        color = ($el.attr('data-color') !== undefined) ? "-" + $el.attr('data-color') : "";
      var opt = {
        checkboxClass: 'icheckbox' + skin + color,
        radioClass: 'iradio' + skin + color,
      };
      $el.iCheck(opt);
    });
  }
});

$('#legal-documents').on('cocoon:after-insert', function (e, insertedItem) {
  insertedItem.find('.gp-select2').select2({
    theme: 'bootstrap',
    language: 'vi',
    placeholder: 'Vui lòng chọn'
  });
  bsCustomFileInput.init();
});

$('#milestones').on('cocoon:after-insert', function (e, insertedItem) {
  insertedItem.find('.datepicker').datepicker({
    dateFormat: 'dd/mm/yy',
    showOtherMonths: true,
    firstDay: 1,
    monthNames: ['Tháng Một', 'Tháng Hai', 'Tháng Ba', 'Tháng Tư', 'Tháng Năm', 'Tháng Sáu', 'Tháng Bảy', 'Tháng Tám', 'Tháng Chín', 'Tháng Mười', 'Tháng Mười Một', 'Tháng Mười Hai'],
    monthNamesShort: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
    dayNames: ['Chủ Nhật', 'Thứ Hai', 'Thứ Ba', 'Thứ Tư', 'Thứ Năm', 'Thứ Sáu', 'Thứ Bảy'],
    dayNamesShort: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7'],
    dayNamesMin: ['CN', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7']
  })
});

$('body').on('change', '.select2-region', function () {
  let parent = $(this);
  let children = parent.data("select-child-target");
  children.forEach(function (child) {
    let $child = $("#" + child);
    let $default_child_value = $("#" + child + "_default_value");
    let parent_selected_value = parent.children('option:selected').val();
    if (parent_selected_value !== null && parent_selected_value !== '') {
      $.ajax({
        method: 'POST',
        url: '/admin/regions/get_regions',
        contentType: 'application/json',
        data: JSON.stringify({
          parent_id: parent_selected_value
        }),
        headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
        success: function (response) {
          if ($child.data('select2')) {
            $child.empty();
          }
          response.forEach(function (item) {
            let option = `<option value="${item.id}">${item.name_with_type}</option>`;
            $child.append(option);
          });
          if ($default_child_value !== undefined) {
            $child.val($default_child_value.val());
            $default_child_value.remove();
          }
        }
      })
    }
  })
});

// Trim whitespace
$('form').submit(function () {
  $(this).find('input:text').each(function () {
    $(this).val($.trim($(this).val()));
  });
  $('textarea').each(function () {
    $(this).val($.trim($(this).val()));
  });
});
