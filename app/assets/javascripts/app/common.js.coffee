$(document).ready ->
  window.initializeSelect2 = ->
    $('.select2').select2()

    $('[data-js=tag-lookup]').each ->
      $elem = $(this)

      $elem.select2
        tags: $elem.data('tags')
        minimumInputLength: 3
        allowClear: true
        ajax:
          dataType: "json"
          delay: 250
          data: (params) ->
            q: params.term
            page: params.page

          processResults: (data, page) ->
            results = []
            $(data.tags).each ->
              results.push
                id: this
                text: this

            results: results

          cache: true

  window.initializeDateTimePickers = ->
    $('[data-datetimepicker]').each ->
      elem = $(this)
      options = {}

      if format = elem.data('datepicker-format')
        options['format'] = format

      elem.datetimepicker(options)

  initializeSelect2()
  initializeDateTimePickers()
