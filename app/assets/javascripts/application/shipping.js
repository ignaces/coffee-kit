$(function(){
  if(!$('select#shipping_address_commune_id').val()){
    $.get('/shipping_addresses/load_communes.js', { city_id: $('select#city_id').val() });
  }

  $('select#city_id').on('change', function(){
    $.get('/shipping_addresses/load_communes.js', { city_id: $(this).val() });
  });
});