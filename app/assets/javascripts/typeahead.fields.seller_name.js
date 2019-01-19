var seller_names = new Bloodhound({
  datumTokenizer: Bloodhound.tokenizers.obj.whitespace('full_name'),
  queryTokenizer: Bloodhound.tokenizers.whitespace,
  identify: function(obj) { return obj.full_name; },
  prefetch: '/seller_names'
});

$('#seller_name').typeahead(
  {
    hint: false,
    highlight: true,
  },
  {
    name: 'seller_names',
    display: 'full_name',
    source: seller_names,
  }
);
