# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "change", ".field", ->
  value = $(this).val()
  fields = $(this).closest ".fields"
  if value.match(/^is.*/) != null
    fields.find(".comparison").hide()
    fields.find(".value").hide()
  else
    fields.find(".comparison").show()
    fields.find(".value").show()
