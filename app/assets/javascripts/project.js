$(document).on('turbolinks:load', function () {
  let projectSuggestion = new Bloodhound({
    limit: 10,
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '../admin/projects/autocomplete?query=%QUERY',
      filter: function (data) {
        return data;
      },
      wildcard: "%QUERY"
    }
  });

  projectSuggestion.initialize();

  let projectTypeahead = $('#project-search');
  projectTypeahead.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      limit: 500,
      name: 'value',
      displayKey: 'value',
      source: projectSuggestion.ttAdapter(),
      templates: {
        empty: '<div class="noitems">Không tìm thấy kết quả</div>'
      }
    });

  let imageConfigs = [];
  let imageUrls = [];
  $('input[name="project[images][]"]').each(function (index, elm) {
    imageConfigs.push({
      caption: $(elm).val(),
      width: '120px',
      url: $(elm).data('delete-url') + '?type=images&filename=' + $(elm).val()
    });
    // imageUrls.push($(elm).data('url'));
    let src = $(elm).data('url');
    if (src) {
      let filename = src.split('/').pop();
      let element = `${elm.outerHTML}<img src="${src}" class="file-preview-image kv-preview-data" title="${filename}" alt="${filename}">`;
      imageUrls.push(element);
      $(elm).remove();
    }
  });

  $("#project-images-input").fileinput({
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
    return !window.confirm('Are you sure you want to delete this file?');
  }).on('filedeleted', function () {
    setTimeout(function () {
      window.alert('File deletion was successful! ' + krajeeGetCount('file-5'));
    }, 900);
  }).on('filebatchselected', function (event, files) {
    let btn_remove = `<button type="button" class="kv-file-remove btn btn-sm btn-kv btn-default btn-outline-secondary btn-remove-preview-custom" title="Remove file" data-key="" data-id="project-images-input">
    <i class="fas fa-trash-alt"></i></button>`;
    $('#project-images-input').closest('.tms-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial) .file-footer-buttons').prepend(btn_remove);
    fileStoreImages.push.apply(fileStoreImages, files);
    if (imagePreviewArr) {
      $('#project-images-input').closest('.tms-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').first().before(imagePreviewArr);
    }
    imagePreviewArr = $('#project-images-input').closest('.tms-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').clone(true);
    // change text file select
    if (imagePreviewArr.length > 1) {
      $('#project-images-input').closest('.tms-field-group-body').find('.file-caption-name').val(`${imagePreviewArr.length} files selected`);
    }
  });
  $('#project-images-input').closest('.tms-field-group-body').find('.file-caption-name').val('');

  let fileStoreImages = [];
  let fileStoreFloorplanImages = [];
  let imagePreviewArr = null;
  let floorplanImagePreviewArr = null;

  let floorImageConfigs = [];
  let floorImageUrls = [];
  $('input[name="project[floorplan_images][]"]').each(function (index, elm) {
    floorImageConfigs.push({
      caption: $(elm).val(),
      width: '120px',
      url: $(elm).data('delete-url') + '?type=floorplan_images&filename=' + $(elm).val()
    });
    // floorImageUrls.push($(elm).data('url'));
    let src = $(elm).data('url');
    if (src) {
      let filename = src.split('/').pop();
      let element = `${elm.outerHTML}<img src="${src}" class="file-preview-image kv-preview-data" title="${filename}" alt="${filename}">`;
      floorImageUrls.push(element);
      $(elm).remove();
    }
  });

  $("#floorplan-images-input").fileinput({
    initialPreview: floorImageUrls,
    // initialPreviewAsData: true,
    initialPreviewConfig: floorImageConfigs,
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
    return !window.confirm('Are you sure you want to delete this file?');
  }).on('filedeleted', function () {
    setTimeout(function () {
      window.alert('File deletion was successful!');
    }, 900);
  }).on('filebatchselected', function (event, files) {
    let btn_remove = `<button type="button" class="kv-file-remove btn btn-sm btn-kv btn-default btn-outline-secondary btn-remove-preview-custom" title="Remove file" data-key="" data-id="floorplan-images-input">
    <i class="fas fa-trash-alt"></i></button>`;
    $('#floorplan-images-input').closest('.gp-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial) .file-footer-buttons').prepend(btn_remove);

    fileStoreFloorplanImages.push.apply(fileStoreFloorplanImages, files);
    if (floorplanImagePreviewArr) {
      $('#floorplan-images-input').closest('.gp-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').first().before(floorplanImagePreviewArr);
    }
    floorplanImagePreviewArr = $('#floorplan-images-input').closest('.gp-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').clone(true);
    // change text file select
    if (floorplanImagePreviewArr.length > 1) {
      $('#floorplan-images-input').closest('.gp-field-group-body').find('.file-caption-name').val(`${floorplanImagePreviewArr.length} files selected`);
    }
  });
  $('#floorplan-images-input').closest('.gp-field-group-body').find('.file-caption-name').val('');

  $("#project-submit-form").on('submit', function () {
    $('.kv-zoom-cache input').remove();
    $("#high-payment-schedules").find('.label-schedule').val(0);
    $("#low-payment-schedules").find('.label-schedule').val(1);
    $('#project-images-input')[0].files = new FileListItems(fileStoreImages);
    $('#floorplan-images-input')[0].files = new FileListItems(fileStoreFloorplanImages);
  })

  change_commission_type();
  $('#project_commission_type').change(function () {
    change_commission_type();
  });

  $('input, select').on('keyup change', function () {
    $(this).closest('.field_with_errors').removeClass('field_with_errors');
    $(this).closest('.form-group').find('.custom-validation').hide();
  });

  $(document).on('click', '.btn-remove-preview-custom', function () {
    let num_element_exsist = $(this).closest('.file-preview-thumbnails').find('.kv-preview-thumb.file-preview-initial').length;
    let index_in_field = $(this).closest('.kv-preview-thumb').index() - num_element_exsist;
    $(this).closest('.kv-preview-thumb').remove();
    let input_id = $(this).attr('data-id');
    if (input_id == 'project-images-input') {
      fileStoreImages.splice(index_in_field, 1);
      imagePreviewArr = $('#project-images-input').closest('.gp-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').clone(true);
      changeTextCap($('#project-images-input'));
    }
    // else if (input_id == 'product-images-input') {
    //   productFileStore.splice(index_in_field, 1);
    //   productPreviewArr = $('#product-images-input').closest('.gp-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)').clone(true);
    //   changeTextCap($('#product-images-input'));
    // }
    // else {
    //   input_file_store[input_id].splice(index_in_field, 1);
    //   input_file_image_preview[input_id] = $(`#${input_id}`).closest('.input-file-container').find('.kv-preview-thumb:not(.file-preview-initial)').clone(true);
    //   changeTextCap($(`#${input_id}`));
    // }
  });

  function change_commission_type() {
    if ($('#project_commission_type').length) {
      if ($('#project_commission_type').val() == 0) {
        $("#project_commission").attr('data-type', 'currency');
        $("#project_bonus").attr('data-type', 'currency');
      } else if ($('#project_commission_type').val() == 1) {
        $("#project_commission").attr('data-type', 'number');
        $("#project_bonus").attr('data-type', 'number');
      }
    }
  }

  function FileListItems(files) {
    let b = new ClipboardEvent("").clipboardData || new DataTransfer()
    for (let i = 0, len = files.length; i < len; i++) b.items.add(files[i])
    return b.files
  }

  function changeTextCap($input) {
    let item_preview = $input.closest('.gp-field-group-body').find('.kv-preview-thumb:not(.file-preview-initial)');
    let num_file = item_preview.length;
    if (num_file > 1) {
      $input.closest('.gp-field-group-body').find('.file-caption-name').val(`${item_preview.length} files selected`);
    } else if (num_file == 1) {
      $input.closest('.gp-field-group-body').find('.file-caption-name').val(item_preview.find('.file-caption-info').text());
    } else {
      $input.closest('.gp-field-group-body').find('.file-caption-name').val('');
    }
  }
})