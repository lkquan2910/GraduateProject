Dropzone.autoDiscover = false;
var productFileStore = [];
var productPreviewArr = null;
$(document).on('turbolinks:load', function () {
  var url_high_autocomplete = $('#high-product-search').data('url-autocomplete');
  var highProductSuggestion = new Bloodhound({
    limit: 10,
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: url_high_autocomplete + '?level=0&query=%QUERY',
      filter: function (data) {
        return data;
      },
      wildcard: "%QUERY"
    }
  });

  highProductSuggestion.initialize();

  var highProductTypeahead = $('#high-product-search');
  highProductTypeahead.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      limit: 500,
      name: 'value',
      displayKey: 'value',
      source: highProductSuggestion.ttAdapter(),
      templates: {
        empty: '<div class="noitems">Không tìm thấy kết quả</div>'
      }
    });

  var url_low_autocomplete = $('#low-product-search').data('url-autocomplete');
  var lowProductSuggestion = new Bloodhound({
    limit: 10,
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: url_low_autocomplete + '?level=1&query=%QUERY',
      filter: function (data) {
        return data;
      },
      wildcard: "%QUERY"
    }
  });

  lowProductSuggestion.initialize();

  var lowProductTypeahead = $('#low-product-search');
  lowProductTypeahead.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      limit: 500,
      name: 'value',
      displayKey: 'value',
      source: lowProductSuggestion.ttAdapter(),
      templates: {
        empty: '<div class="noitems">Không tìm thấy kết quả</div>'
      }
    });

  var getDivisionPath = $('.division-static-path').attr('href');

  $('.select2-subdivision, .select2-block').change(function () {
    let parent = $(this);
    var isProject = null;
    if (parent.data('id') == 'project') isProject = true;
    let children = parent.data("select-child-target");
    children.forEach(function (child) {
      let $child = $("#" + child);
      let $default_child_value = $("#" + child + "_default_value");
      let parent_selected_value = parent.children('option:selected').val();
      if (parent_selected_value !== null && parent_selected_value !== '') {
        $.ajax({
          method: 'POST',
          url: getDivisionPath + '/get_divisions',
          contentType: 'application/json',
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          },
          data: JSON.stringify({
            parent_id: parent_selected_value,
            is_project: isProject
          }),
          success: function (response) {
            if ($child.data('select2')) {
              $child.empty();
            }
            response.forEach(function (item) {
              let option = `<option value="${item.id}">${item.name}</option>`;
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
  })

  $('#files-field').dropzone({
    url: location.pathname + '/import',
    dictDefaultMessage: 'Bạn có thể kéo hoặc thả ảnh, tài liệu để tải lên',
    addRemoveLinks: true,
    autoProcessQueue: false,
    uploadMultiple: false,
    maxFiles: 1,
    acceptedFiles: ".xls,.xlsx,.csv",
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
    },
    accept: function (file, done) {
      $('div#files-field').css({'height': 'auto'});
      done();
    },
    init: function () {
      var productDropzone = this;

      var form = document.getElementById('import-product-form');
      form.addEventListener('submit', function (event) {
        if (productDropzone.getQueuedFiles().length > 0) {
          event.preventDefault();
          event.stopPropagation();
          productDropzone.processQueue();
        }
      });

      productDropzone.on('sending', function (file, xhr, formData) {
        console.log(formData)
      });

      productDropzone.on('success', function (file) {
        if (this.getUploadingFiles().length === 0 && this.getQueuedFiles().length === 0) {
          productDropzone.removeFile(file);
          $('.btn-tool').click();
          $('.flash').html("<div class='tms-flash-notice alert'> <div class='row'> "
            + "<div class='col'style: 'padding-bottom: 8px'><i class='fas fa-check-circle icon-successful'></i> "
            + "<span class='text-successful'>Successfully!</span> <button class='close' 'aria-hidden'= 'true', 'data-dismiss'= 'alert', type= 'button'>"
            + "<i class='fas fa-times'></i></button></div></div><span>Bảng hàng đang được import. Kết quả sẽ được gửi lại sau khi xử lý xong!</span></div>")
        }
      });
    }
  })

  $('#new-product').on('click', function () {
    Swal.fire({
      title: 'Mời chọn khối sản phẩm',
      icon: 'question',
      showCloseButton: true,
      showCancelButton: true,
      confirmButtonText: 'Cao tầng',
      cancelButtonText: 'Thấp tầng',
      cancelButtonColor: '#28a745',
    }).then((result) => {
      if (result.value) {
        $('.new-high-product')[0].click();
      } else {
        $('.new-low-product')[0].click();
      }
    })
  });

  var changingState = $('input[name="product[state]"]').val();

  $(document).on('click', '#product-submit', function (e) {
    $('.kv-zoom-cache input').remove();
    if( $('#product-images-input').length ){
      $('#product-images-input')[0].files = new FileListItems(productFileStore);
    }
    var existingDeposits = [];
    var storedState = $('#product_stored_state').val();
    if (!(changingState == 'recall' && storedState != changingState)) {
      $('#edit-product').submit();
      return;
    }

    $('input[name="product[existing_deposit]"]').each(function () {
      var depositHtml = '</br><a href="' + $(this).data('url') + '" target="_blank">' + $(this).data('name') + '</a>';
      existingDeposits.push(depositHtml);
    })

    if (existingDeposits.length <= 0) {
      $('#edit-product').submit();
      return;
    }

    var recallHtml = 'Chuyển đổi trạng thái căn hộ sang Thu hồi, đồng nghĩa </br>' +
      'Phiếu cọc sau sẽ tự động hủy: ' + existingDeposits.join('');
    Swal.fire({
      title: 'Thu hồi căn hộ',
      icon: 'warning',
      html: recallHtml,
      showCancelButton: true,
      confirmButtonText: 'OK',
      cancelButtonText: 'Huỷ',
      allowOutsideClick: false,
    }).then((result) => {
      if (result.value) {
        $('#edit-product').submit();
      }
    })
  })

  $('input').on('ifChecked', function (event) {
    changingState = $(this).val();
  });

  var imageConfigs = [];
  var imageUrls = [];
  $('input[name="product[images][]"]').each(function (index, elm) {
    imageConfigs.push({
      caption: $(elm).val(),
      width: '120px',
      url: $(elm).data('delete-url') + '?type=images&filename=' + $(elm).val()
    });
    // imageUrls.push($(elm).data('url'));
    src = $(elm).data('url');
    if (src){
      filename = src.split('/').pop();
      element = `${elm.outerHTML}<img src="${src}" class="file-preview-image kv-preview-data" title="${filename}" alt="${filename}">`;
      imageUrls.push(element);
      $(elm).remove();
    }
  });


  $("#product-images-input").fileinput({
    initialPreview: imageUrls,
    // initialPreviewAsData: true,
    initialPreviewConfig: imageConfigs,
    overwriteInitial: false,
    allowedFileTypes: ['image'],
    showCancel: false,
    showRemove: false,
    browseLabel: '',
    removeClass: 'btn btn-danger',
    removeLabel: '',
    theme: 'fas',
    deleteUrl: '/',
    ajaxDeleteSettings: {
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    },
    fileActionSettings: {
      showZoom: function (config) {
        if (config.type === 'pdf' || config.type === 'image') {
          return true;
        }
        return false;
      }
    }
  }).on('filebeforedelete', function () {
    var aborted = !window.confirm('Are you sure you want to delete this file?');
    return aborted;
  }).on('filedeleted', function () {
    setTimeout(function () {
      window.alert('File deletion was successful! ' + krajeeGetCount('file-5'));
    }, 900);
  }).on('filebatchselected', function(event, files) {
    btn_remove = `<button type="button" class="kv-file-remove btn btn-sm btn-kv btn-default btn-outline-secondary btn-remove-preview-custom" title="Remove file" data-key="" data-id="product-images-input">
    <i class="fas fa-trash-alt"></i></button>`;
    $('#product-images-input').closest('.tms-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial) .file-footer-buttons').prepend(btn_remove);

    productFileStore.push.apply(productFileStore,files);
    if (productPreviewArr){
      $('#product-images-input').closest('.tms-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').first().before(productPreviewArr);
    }
    productPreviewArr = $('#product-images-input').closest('.tms-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').clone(true);
    // change text file select
    if (productPreviewArr.length > 1){
      $('#product-images-input').closest('.tms-field-group-body').find('.file-caption-name').val(`${productPreviewArr.length} files selected`);
    }
  });
  $('#product-images-input').closest('.tms-field-group-body').find('.file-caption-name').val('');
});
