$(document).on "hidden.bs.modal", "#generic-modal", ->
  $(this).removeData "bs.modal"
  $("#" + $(this).attr("id") + " .modal-content").empty()
  $("#" + $(this).attr("id") + " .modal-content").append "Loading..."
