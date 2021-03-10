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
}