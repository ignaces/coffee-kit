$(document).ready(function(){
  mixpanel.track_links('a#btn-plan', 'Botón Café Header');
  mixpanel.track_links('a#btn-kit', 'Botón Starter Kit Header.');
  $('div#grams').click(function(){ mixpanel.track('250g, 500g, 1K'); });
  mixpanel.track_forms('form#new-subscription', 'Suscribete Home');
  mixpanel.track_forms('form#new-kit', 'Compralo Home Starter Kit');
  mixpanel.track_forms('form.pricing', 'Continuar');
  mixpanel.track_forms('form.coffee', 'Continuar paso 2');
  mixpanel.track_forms('form.shipping', 'Confirma tu compra');

});