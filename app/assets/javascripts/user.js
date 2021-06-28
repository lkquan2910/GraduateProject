$(document).on('turbolinks:load', function () {
  var userSuggestion = new Bloodhound({
    limit: 10,
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '../admin/users/autocomplete?query=%QUERY',
      filter: function(data) {
        return data;
      },
      wildcard: "%QUERY"
    }
  });

  userSuggestion.initialize();

  var userTypeahead = $('#user-search');
  userTypeahead.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      limit: 500,
      name: 'value',
      displayKey: 'value',
      source: userSuggestion.ttAdapter(),
      templates: {
        empty: '<div class="noitems">Không tìm thấy kết quả</div>'
      }
    });
});

// function sliceName(e) {
//   return e.split('-')[0].trim()
// }
//
// function sliceEmail(e) {
//   return e.split('-')[1].trim()
// }

// function resetAncestry() {
//   $('.orgchart').find('.focused').removeClass('focused');
//   $('#selected-node').val('');
//   $('#selected-node-email').val('');
//   $('.new-node').val('');
//   $('#new-nodelist').find('input:first').val('').parent().siblings().remove();
//   $("#select-node").val('').change();
// }
//
// var status;
// function addAncestryToUser(parent, child, selectType) {
//   var groupId = $('#group-id-hidden').val();
//   $.ajax({
//     method: 'post',
//     url: '/admin/groups/' + groupId + '/add_' + selectType + '_ancestry',
//     contentType: 'application/json',
//     async: false,
//     headers: {
//       'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//     },
//     data: JSON.stringify(
//       {
//         parent: parent,
//         child: child
//       }
//     )
//   }).done(function (response) {
//     if (response.status === 'success') {
//       resetAncestry();
//       status = response.status;
//     } else {
//       alert(response.message);
//       status = response.status;
//     }
//   });
//   return status;
// }
//
// function removeAncestry(node, oc) {
//   var groupId = $('#group-id-hidden').val();
//   $.ajax({
//     method: 'post',
//     url: '/admin/groups/' + groupId + '/remove_ancestry',
//     contentType: 'application/json',
//     headers: {
//       'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
//     },
//     data: JSON.stringify(
//       {
//         node: node,
//       }
//     )
//   }).done(function () {
//     oc.removeNodes($('#selected-node').data('node'));
//     $('#selected-node').val('').data('node', null);
//     $('#selected-node-email').val('');
//   })
//     .fail(function () {
//       alert("Đã có lỗi xảy ra. Vui lòng thử lại!");
//     })
// }
//
// $(document).on('turbolinks:load', function () {
//   initializeMemberSearch('member-search');
//   var getId = function () {
//     return (new Date().getTime()) * 1000 + Math.floor(Math.random() * 1001);
//   };
//   var nodeTemplate = function (data) {
//     return `
//         <div class="title">${data.name}</div>
//         <div class="content">${data.email}</div>
//       `;
//   };
//   if ($('#org-chart-data-source').length > 0) {
//     var orgStructure = JSON.parse($('#org-chart-data-source').val());
//     var oc = $('#chart-container').orgchart({
//       'data': orgStructure,
//       'chartClass': 'edit-state',
//       'pan': true,
//       'zoom': true,
//       'nodeTemplate': nodeTemplate,
//       'createNode': function ($node, data) {
//         $node[0].id = getId();
//       }
//     });
//     oc.$chartContainer.on('click', '.node', function () {
//       var $this = $(this);
//       $('#selected-node').val($this.find('.title').text()).data('node', $this);
//       $('#selected-node-email').val($this.find('.content').text());
//     });
//     oc.$chartContainer.on('click', '.orgchart', function (event) {
//       if (!$(event.target).closest('.node').length) {
//         $('#selected-node').val('');
//         $('#selected-node-email').val('');
//       }
//     });
//   }
//   $('input[name="chart-state"]').on('click', function () {
//     $('.orgchart').toggleClass('edit-state', this.value !== 'view');
//     $('#edit-panel').toggleClass('edit-state', this.value === 'view');
//     if ($(this).val() === 'edit') {
//       $('.orgchart').find('tr').removeClass('hidden')
//         .find('td').removeClass('hidden')
//         .find('.node').removeClass('slide-up slide-down slide-right slide-left');
//     } else {
//       $('#btn-reset').trigger('click');
//     }
//   });
//   $('#select-node').on('change', function () {
//     var $this = $('#select-node option:selected');
//     if ($this.val() === 'parent') {
//       $('#edit-panel').addClass('edit-parent-node');
//       $('#new-nodelist').children(':gt(0)').remove();
//       $('.btn-inputs').css('display', 'none');
//     } else {
//       $('#edit-panel').removeClass('edit-parent-node');
//       $('.btn-inputs').css('display', 'block');
//     }
//   });
//   $('#btn-add-input').on('click', function () {
//     let newClass = 'member-search-' + $('.new-node.member-search.tt-input').length + 1;
//     $('#new-nodelist').append('<li><input type="text" class="new-node member-search form-control ' + newClass + '"></li>');
//     initializeMemberSearch(newClass);
//   });
//   $('#btn-remove-input').on('click', function () {
//     var inputs = $('#new-nodelist').children('li');
//     if (inputs.length > 1) {
//       inputs.last().remove();
//     }
//   });
//   $('#btn-add-nodes').on('click', function () {
//     var $chartContainer = $('#chart-container');
//     var nodeVals = [];
//     $('#new-nodelist').find('.new-node').each(function (index, item) {
//       var validVal = item.value.trim();
//       if (validVal.length) {
//         nodeVals.push(validVal);
//       }
//     });
//     var $node = $('#selected-node').data('node');
//     if (!nodeVals.length) {
//       alert('Vui lòng nhập thông tin cho vị trí mới.');
//       return;
//     }
//     var selectType = $('#select-node option:selected');
//     if (selectType.val() === '') {
//       alert('Vui lòng chọn một cấp bậc trên sơ đồ.');
//       return;
//     }
//     if (selectType.val() !== 'parent' && !$('.orgchart').length) {
//       alert('Vui lòng tạo vị trí cấp cao nhất trước khi bạn muốn xây dựng sơ đồ tổ chức.');
//       return;
//     }
//     if ((selectType.val() !== 'parent' && !$node) || ((selectType.val() !== 'parent' && !$node) && $('#selected-node-email').val() === '')) {
//       alert('Vui lòng chọn một vị trí trên sơ đồ.');
//       return;
//     }
//     if ($chartContainer.children('.orgchart').length > 0 && selectType.val() === 'parent') {
//       alert('Bạn không được phép thêm vị trí cấp trên khi đã có vị trí với cấp bậc cao nhất.');
//       return;
//     }
//     if (selectType.val() === 'parent') {
//       if (!$chartContainer.children('.orgchart').length) {// if the original chart has been deleted
//         oc = $chartContainer.orgchart({
//           'data': {'name': sliceName(nodeVals[0]), 'email': sliceEmail(nodeVals[0])},
//           'pan': true,
//           'zoom': true,
//           'nodeTemplate': nodeTemplate,
//           'createNode': function ($node, data) {
//             $node[0].id = getId();
//           }
//         });
//         oc.$chart.addClass('view-state');
//         addAncestryToUser(sliceEmail(nodeVals[0]), null, 'root')
//       } else {
//         oc.addParent($chartContainer.find('.node:first'), {
//           'name': sliceName(nodeVals[0]),
//           'email': sliceEmail(nodeVals[0]),
//           'id': getId()
//         });
//         addAncestryToUser(sliceEmail(nodeVals[0]), null, 'root')
//       }
//     } else if (selectType.val() === 'siblings') {
//       if ($node[0].id === oc.$chart.find('.node:first')[0].id) {
//         alert('Bạn không được phép thêm trực tiếp vị trí cùng cấp bậc với vị trí cao nhất.');
//         return;
//       }
//       addAncestryToUser($('#selected-node-email').val(), $('.tt-input').map(function() { return sliceEmail($(this).val())}).toArray(), 'sibling');
//       if (status === 'success') {
//         oc.addSiblings($node, nodeVals.map(function (item) {
//           return {'name': sliceName(item), 'email': sliceEmail(item), 'relationship': '110', 'id': getId()};
//         }));
//       }
//     } else {
//       var hasChild = $node.parent().attr('colspan') > 0 ? true : false;
//       if (!hasChild) {
//         var rel = nodeVals.length > 1 ? '110' : '100';
//         addAncestryToUser($('#selected-node-email').val(), $('.tt-input').map(function() { return sliceEmail($(this).val())}).toArray(), 'child');
//         if (status === 'success') {
//           oc.addChildren($node, nodeVals.map(function (item) {
//             return {'name': sliceName(item), 'email': sliceEmail(item), 'relationship': rel, 'id': getId()}
//           }));
//         }
//       } else {
//         addAncestryToUser($('#selected-node-email').val(), $('.tt-input').map(function() { return sliceEmail($(this).val())}).toArray(), 'child');
//         if (status === 'success') {
//           oc.addSiblings($node.closest('tr').siblings('.nodes').find('.node:first'), nodeVals.map(function (item) {
//             return {'name': sliceName(item), 'email': sliceEmail(item), 'relationship': '110', 'id': getId()};
//           }));
//         }
//       }
//     }
//   });
//   $('#btn-delete-nodes').on('click', function () {
//     var $node = $('#selected-node').data('node');
//     if (!$node) {
//       alert('Vui lòng chọn một vị trí trong sơ đồ.');
//       return;
//     } else if ($node[0] === $('.orgchart').find('.node:first')[0]) {
//       if (!window.confirm('Bạn có chắc muốn xóa toàn bộ sơ đồ?')) {
//         return;
//       }
//     }
//     removeAncestry($('#selected-node-email').val(), oc);
//   });
//   $('#btn-reset').on('click', function () {
//     resetAncestry();
//   });
// });
//
// $(document).on('click', '.node', function () {
//   var $this = $(this);
//   $('#selected-node').val($this.find('.title').text()).data('node', $this);
//   $('#selected-node-email').val($this.find('.content').text());
// });
//
// $(document).on('click', '.orgchart', function (event) {
//   if (!$(event.target).closest('.node').length) {
//     $('#selected-node').val('');
//     $('#selected-node-email').val('');
//   }
// });
//
// $(document).on('turbolinks:load', function () {
//   $('#edit-node').click(function () {
//     $(this).css('display', 'none');
//     $('.back').css('display', 'block');
//     $('#btn-add-remove-nodes').css('display', 'block');
//     $('.btn-inputs').css('display', 'block');
//     $('.new-node').prop('disabled', false).css('background-color', 'white');
//     $('#select-node').prop('disabled', false);
//   });
//
//   $('.back').click(function () {
//     $(this).css('display', 'none');
//     $('#edit-node').css('display', 'block');
//     $('#btn-add-remove-nodes').css('display', 'none');
//     $('.btn-inputs').css('display', 'none');
//     $('.new-node').prop('disabled', true).css('background-color', '#e9ecef');
//     $('#select-node').prop('disabled', true);
//   })
// });
