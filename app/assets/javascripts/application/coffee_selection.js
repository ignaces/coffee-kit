$(document).ready(function(){
  CoffeeSelection = {

    maxGrams: parseInt($('table#coffee-beans').attr('data-max-grams')),

    getSelectedGrams: function(){
      if ($('table#selected-beans tr').length != 0){
        var grams = _.map($('table#selected-beans tr'), function(bean){ return parseInt($(bean).attr('data-grams')) });
        return(_.reduce(grams, function(memo, num){ return memo + num }, 0));
      } else {
        return 0;
      }
    },

    addBean: function(newBean){
      var existingBean = $("tr[data-sku=" + newBean.data('sku') + "]");

      if($(existingBean).length != 0){
        var existingGrams = parseInt(existingBean.attr('data-grams'));
        var addedGrams = parseInt(newBean.data('grams'));
        var beanTotalGrams = existingGrams + addedGrams;

        existingBean.attr('data-grams', beanTotalGrams)
        .html('<td><span class="brown">' + gramsInWords(beanTotalGrams) + '</span> de ' + existingBean.data('name') + '</td><td><span class="glyphicon glyphicon-remove remove-bean"></span></td>');

        existingBean.append('<input type="hidden" name="beans[][sku]" value="' + newBean.attr('data-sku') + '"/>');
        existingBean.append('<input type="hidden" name="beans[][grams]" value="' + newBean.attr('data-grams') + '"/>');
        existingBean.find("input[name='beans[][grams]']").val(beanTotalGrams);

      }else{
        var newEl = $('<tr></tr>').attr('data-sku', newBean.attr('data-sku'))
        .attr('data-grams', newBean.attr('data-grams'))
        .attr('data-name', newBean.attr('data-name'))
        .html('<td><span class="brown">' + gramsInWords(newBean.attr('data-grams')) + '</span> de ' + newBean.attr('data-name') + '</td><td><span class="glyphicon glyphicon-remove remove-bean"></span></td>');

        newEl.append('<input type="hidden" name="beans[][sku]" value="' + newBean.attr('data-sku') + '"/>');
        newEl.append('<input type="hidden" name="beans[][grams]" value="' + newBean.attr('data-grams') + '"/>');

        newEl.appendTo($('table#selected-beans tbody'));
      }

      updateCounter();
      updateButtons();

    },

    removeBean: function(bean){
      bean.parents('tr').remove();
      updateCounter();
      updateButtons();
    }
  }

  function logSelection(){
    console.log('Max:' + CoffeeSelection.maxGrams + '|Selected:' + CoffeeSelection.getSelectedGrams());
  }

  function gramsInWords(grams){
    if(grams < 1000){
      return(grams + 'g');
    }else{
      return (parseInt(grams/1000) + 'kg');
    }

  }

  function updateCounter(){
    $('h3.selected-beans small').text(gramsInWords(CoffeeSelection.getSelectedGrams()) + ' de ' + gramsInWords(CoffeeSelection.maxGrams));
  }

  function updateButtons(){
    _.each($('button.add-bean'), function(button){
      if( CoffeeSelection.getSelectedGrams() + parseInt($(button).attr('data-grams')) <= CoffeeSelection.maxGrams ){
        $(button).attr('disabled', false);
      }else{
        $(button).attr('disabled', true);
      }
    });
  }

  $('button.add-bean').click(function(event){
    event.preventDefault();
    CoffeeSelection.addBean($(this));
  });

  $('table#selected-beans').on('click', 'span.remove-bean', function(){
    CoffeeSelection.removeBean($(this));
  });

  updateCounter();
  updateButtons();

});
