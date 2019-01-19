var sponsor_names = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('full_name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  identify: function(obj) { return obj.full_name; },
  prefetch: '/sponsor_names'
});

$('#sponsor_name').typeahead(
  {
    hint: false,
    highlight: true,
  },
  {
    name: 'sponsor_names',
    display: 'full_name',
    source: sponsor_names,
  }
);
