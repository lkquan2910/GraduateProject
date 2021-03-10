$(document).on('turbolinks:load', function () {
  var customerSuggestion = new Bloodhound({
    limit: 10,
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '../admin/customers/autocomplete?query=%QUERY',
      filter: function(data) {
        return data;
      },
      wildcard: "%QUERY"
    }
  });

  customerSuggestion.initialize();

  var customerTypeahead = $('#customer-search');
  customerTypeahead.typeahead({
      hint: true,
      highlight: true,
      minLength: 1
    },
    {
      limit: 500,
      name: 'value',
      displayKey: 'value',
      source: customerSuggestion.ttAdapter(),
      templates: {
        empty: '<div class="noitems">Không tìm thấy kết quả</div>'
      }
    });
});