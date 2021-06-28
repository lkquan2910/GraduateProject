// Investors
$(document).on('turbolinks:load', function() {
  var imageConfigs = [];
  var imageUrls = [];
  $('input[name="investor[logo]"]').each(function (index, elm) {
    imageConfigs.push({caption: $(elm).val(), width: '120px', url: $(elm).data('delete-url') + '?type=logo', filename: $(elm).val()});
    imageUrls.push($(elm).data('url'));
  });

  $("#investor-logo-input").fileinput({
    initialPreview: imageUrls,
    initialPreviewAsData: true,
    initialPreviewConfig: imageConfigs,
    overwriteInitial: false,
    allowedFileTypes: ['image'],
    showCancel: false,
    showRemove: false,
    browseLabel: '',
    removeClass: 'btn btn-danger',
    removeLabel: '',
    theme: 'fas',
    maxFileCount: 5,
    deleteUrl: '/',
    ajaxDeleteSettings: {
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    },
    fileActionSettings: {
      showZoom: function(config) {
        if (config.type === 'pdf' || config.type === 'image') {
          return true;
        }
        return false;
      }
    }
  }).on('filebeforedelete', function() {
    var aborted = !window.confirm('Are you sure you want to delete this file?');
    return aborted;
  }).on('filedeleted', function() {
    setTimeout(function() {
      window.alert('Xóa ảnh thành công.');
    }, 900);
  });
});

// Constructors
$(document).on('turbolinks:load', function() {
  var imageConfigs = [];
  var imageUrls = [];
  $('input[name="constructor[logo]"]').each(function (index, elm) {
    imageConfigs.push({caption: $(elm).val(), width: '120px', url: $(elm).data('delete-url') + '?type=logo', filename: $(elm).val()});
    imageUrls.push($(elm).data('url'));
  });

  $("#constructor-logo-input").fileinput({
    initialPreview: imageUrls,
    initialPreviewAsData: true,
    initialPreviewConfig: imageConfigs,
    overwriteInitial: false,
    allowedFileTypes: ['image'],
    showCancel: false,
    showRemove: false,
    browseLabel: '',
    removeClass: 'btn btn-danger',
    removeLabel: '',
    theme: 'fas',
    maxFileCount: 5,
    deleteUrl: '/',
    ajaxDeleteSettings: {
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    },
    fileActionSettings: {
      showZoom: function(config) {
        if (config.type === 'pdf' || config.type === 'image') {
          return true;
        }
        return false;
      }
    }
  }).on('filebeforedelete', function() {
    var aborted = !window.confirm('Are you sure you want to delete this file?');
    return aborted;
  }).on('filedeleted', function() {
    setTimeout(function() {
      window.alert('Xóa ảnh thành công.');
    }, 900);
  });
});

// Developments
$(document).on('turbolinks:load', function() {
  var imageConfigs = [];
  var imageUrls = [];
  $('input[name="development[logo]"]').each(function (index, elm) {
    imageConfigs.push({caption: $(elm).val(), width: '120px', url: $(elm).data('delete-url') + '?type=logo', filename: $(elm).val()});
    imageUrls.push($(elm).data('url'));
  });

  $("#development-logo-input").fileinput({
    initialPreview: imageUrls,
    initialPreviewAsData: true,
    initialPreviewConfig: imageConfigs,
    overwriteInitial: false,
    allowedFileTypes: ['image'],
    showCancel: false,
    showRemove: false,
    browseLabel: '',
    removeClass: 'btn btn-danger',
    removeLabel: '',
    theme: 'fas',
    maxFileCount: 5,
    deleteUrl: '/',
    ajaxDeleteSettings: {
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    },
    fileActionSettings: {
      showZoom: function(config) {
        if (config.type === 'pdf' || config.type === 'image') {
          return true;
        }
        return false;
      }
    }
  }).on('filebeforedelete', function() {
    var aborted = !window.confirm('Are you sure you want to delete this file?');
    return aborted;
  }).on('filedeleted', function() {
    setTimeout(function() {
      window.alert('Xóa ảnh thành công.');
    }, 900);
  });
});

// Operators
$(document).on('turbolinks:load', function() {
  var imageConfigs = [];
  var imageUrls = [];
  $('input[name="operator[logo]"]').each(function (index, elm) {
    imageConfigs.push({caption: $(elm).val(), width: '120px', url: $(elm).data('delete-url') + '?type=logo', filename: $(elm).val()});
    imageUrls.push($(elm).data('url'));
  });

  $("#operator-logo-input").fileinput({
    initialPreview: imageUrls,
    initialPreviewAsData: true,
    initialPreviewConfig: imageConfigs,
    overwriteInitial: false,
    allowedFileTypes: ['image'],
    showCancel: false,
    showRemove: false,
    browseLabel: '',
    removeClass: 'btn btn-danger',
    removeLabel: '',
    theme: 'fas',
    maxFileCount: 5,
    deleteUrl: '/',
    ajaxDeleteSettings: {
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    },
    fileActionSettings: {
      showZoom: function(config) {
        if (config.type === 'pdf' || config.type === 'image') {
          return true;
        }
        return false;
      }
    }
  }).on('filebeforedelete', function() {
    var aborted = !window.confirm('Are you sure you want to delete this file?');
    return aborted;
  }).on('filedeleted', function() {
    setTimeout(function() {
      window.alert('Xóa ảnh thành công.');
    }, 900);
  });
});

// User profile
$(document).on('turbolinks:load', function() {
  let imageConfigs = [];
  let imageUrls = [];
  $('input[name="user[avatar]"]').each(function (index, elm) {
    imageConfigs.push({caption: $(elm).val(), width: '120px', url: $(elm).data('delete-url') + '?type=avatar', filename: $(elm).val()});
    imageUrls.push($(elm).data('url'));
  });

  $("#user-avatar-input").fileinput({
    autoReplace: true,
    initialPreview: imageUrls,
    initialPreviewAsData: true,
    initialPreviewConfig: imageConfigs,
    overwriteInitial: false,
    allowedFileTypes: ['image'],
    showCancel: false,
    showRemove: false,
    browseLabel: '',
    removeClass: 'btn btn-danger',
    removeLabel: '',
    theme: 'fas',
    maxFileCount: 1,
    deleteUrl: '/',
    ajaxDeleteSettings: {
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    },
    fileActionSettings: {
      showZoom: function(config) {
        if (config.type === 'pdf' || config.type === 'image') {
          return true;
        }
        return false;
      }
    }
  })
    .on('filebeforedelete', function() {
      var aborted = !window.confirm('Are you sure you want to delete this file?');
      return aborted;
    }).on('filedeleted', function() {
    setTimeout(function() {
      window.alert('File deletion was successful! ' + krajeeGetCount('file-5'));
    }, 900);
  });

  $('.connect-with-google').on('ifChecked', function(event){
    $(this).closest('a').click();
  });

  function popupCenter(url, width, height, name) {
    var left = (screen.width/2)-(width/2);
    var top = (screen.height/2)-(height/2);
    return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
  }

  $("a.popup").click(function(e) {
    popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
    e.stopPropagation(); return false;
  });

  if(window.opener && window.location.search.includes("google_calendar")) {
    window.opener.location.reload(true);
    window.close()
  }

});
