$(document).ready ->
  $('#amount').on 'blur', ->
      $.ajax '/convert',
          type: 'GET'
          dataType: 'json'
          data: {
                  source_currency: $("#source_currency").val(),
                  target_currency: $("#target_currency").val(),
                  amount: $("#amount").val()
                }
          error: (jqXHR, textStatus, errorThrown) ->
            alert textStatus
          success: (data, text, jqXHR) ->
            $('#result').val(data.value.toFixed(2))
  $('.inverter').on 'click', ->
    source_currency = $("#source_currency").val()
    target_currency = $("#target_currency").val()

    $("#source_currency").val(target_currency)
    $("#target_currency").val(source_currency)
  $('form').submit ->
    if $('form').attr('action') == '/convert'
      return false;