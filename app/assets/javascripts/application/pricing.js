$(document).ready(function(){

  $('.btn-khipu').click(function(e){
    var form = this.form;
    e.preventDefault();
    $.blockUI({message: 'Redireccionando a medio de pago', css: { 
            
            border: 'none', 
            padding: '15px', 
            backgroundColor: '#000', 
            '-webkit-border-radius': '10px', 
            '-moz-border-radius': '10px', 
            opacity: .5, 
            color: '#fff' 
        } }); 
    mixpanel.track('Khipu');
    form.submit();
  })

  $('.btn-paypal').click(function(e){
    var form = this.form;
    e.preventDefault();
    $.blockUI({message: 'Redireccionando a medio de pago', css: { 
            
            border: 'none', 
            padding: '15px', 
            backgroundColor: '#000', 
            '-webkit-border-radius': '10px', 
            '-moz-border-radius': '10px', 
            opacity: .5, 
            color: '#fff' 
        } }); 
    mixpanel.track('Paypal');

    form.submit();
  })
});