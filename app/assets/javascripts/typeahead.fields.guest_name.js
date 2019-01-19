var guest_names = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('full_name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  identify: function(obj) { return obj.full_name; },
  prefetch: '/guest_names'
});

$('#guest_name').typeahead(
  {
    hint: false,
    highlight: true,
  },
  {
    name: 'guest_names',
    display: 'full_name',
    source: guest_names,
  }
);
