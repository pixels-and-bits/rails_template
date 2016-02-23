(($, window, undefined_) ->
  $.attachmentUpload = $.extend({},
    addFile: (id, i, file) ->
      template = "<div id=\"upload-file" + i + "\">" + "<span class=\"upload-file-id\">#" + i + "</span> - " + file.name + " <span class=\"upload-file-size\">(" + $.attachmentUpload.humanizeSize(file.size) + ")</span> - Status: <span class=\"upload-file-status\">Waiting to upload</span>" + "<div class=\"progress progress-striped active\">" + "<div class=\"progress-bar\" role=\"progressbar\" style=\"width: 0%;\">" + "<span class=\"sr-only\">0% Complete</span>" + "</div>" + "</div>" + "</div>"
      i = $(id).attr("file-counter")
      i++
      $(id).attr "file-counter", i
      $(id).append template

    updateFileStatus: (i, status, message) ->
      $("#upload-file" + i).find("span.upload-file-status").html(message).addClass "upload-file-status-" + status

    updateFileProgress: (i, percent) ->
      $("#upload-file" + i).find("div.progress-bar").width percent
      $("#upload-file" + i).find("span.sr-only").html percent + " Complete"

    humanizeSize: (size) ->
      i = Math.floor(Math.log(size) / Math.log(1024))
      (size / Math.pow(1024, i)).toFixed(2) * 1 + " " + [ "B", "kB", "MB", "GB", "TB" ][i]

    showFile: (id, data) ->
      if data.target
        elem = $(data.target)
        elem.fadeOut
          complete: () ->
            if data.markup?
              elem.html(data.markup).fadeIn()
            else
              elem.prop('src', data.url).fadeIn()

            $("#upload-file" + id).html null
      else
        $("#upload-file" + id).html data.markup

  , $.attachmentUpload)
) jQuery, this

$(document).ready ->

  $('[data-js=drop-zone]').each ->
    $elem = $(this)
    url = $elem.data('drop-url')
    attachableId = $elem.data('attachable-id')
    attachableType = $elem.data('attachable-type')
    attachmentType = $elem.data('attachment-type')
    target = $elem.data('target')
    size = $elem.data('size')

    $elem.dmUploader
      url: url
      method: "POST"
      dataType: "json"
      extraData:
        target: target
        size: size
        attachable_id: attachableId
        attachable_type: attachableType
        attachment_type: attachmentType

      onInit: ->

      onBeforeUpload: (id) ->

      onNewFile: (id, file) ->
        $.attachmentUpload.addFile "#upload-files", id, file

      onComplete: ->

      onUploadProgress: (id, percent) ->
        percentStr = percent + "%"
        $.attachmentUpload.updateFileProgress id, percentStr

      onUploadSuccess: (id, data) ->
        $.attachmentUpload.showFile id, data

      onUploadError: (id, message) ->
        $.attachmentUpload.updateFileStatus id, "error", message

      onFileTypeError: (file) ->

      onFileSizeError: (file) ->

      onFallbackMode: (message) ->

$(document).on 'ajax:success', '[data-js=delete-attachment]', (e) ->
  $(this).parents('div.file-attachment').fadeOut()
