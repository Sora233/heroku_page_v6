# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
import "quill/dist/quill.snow.css";
import Quill from "quill";


check_id = (id) ->
  return $(id).length > 0

get_content = (id) ->
  try
    content = JSON.parse($(id).val())
  catch
    content = {}
  return content

do_editor = (id) ->
  if check_id(id)
    toolbarOptions = [
      ['bold', 'italic', 'underline', 'strike'], # toggled buttons
      ['blockquote', 'code-block', 'indent'],
      [{'header': 1}, {'header': 2},], # custom button values
      [{'list': 'ordered'}, {'list': 'bullet'}],
      [{'script': 'sub'}, {'script': 'super'}], # superscript/subscript
      [{'indent': '-1'}, {'indent': '+1'}], # outdent/indent
      [{'direction': 'rtl'}], # text direction

      [{'size': ['small', false, 'large', 'huge']}], # custom dropdown
      [{'header': [1, 2, 3, 4, 5, 6, false]}],

      [{'color': []}, {'background': []}], # dropdown with defaults from theme
      [{'font': []}],
      [{'align': []}],

      ['formula', 'image', 'video', 'clean']                                         # remove formatting button
    ];
    content = get_content("#post_content")
    editor = new Quill(id, {
      modules: {
        toolbar: toolbarOptions,
        history: {
          delay: 2000,
          maxStack: 500,
        }
      },
      placeholder: 'Begin to change the world..',
      theme: 'snow'
    })
    editor.setContents(content)

    $("[type=submit]").click (event) ->
      if editor.getText().trim().length > 0
        $("#post_content").val(JSON.stringify(editor.getContents()))

do_reader = (id) ->
  if check_id(id)
    content = get_content("#post_content")
    editor = new Quill(id, {
      modules: {
        toolbar: false
      }
      theme: 'snow',
      readOnly: true,
    })
    editor.setContents(content)

$(document).on 'turbolinks:load', ->
  do_editor("#post-content-editor:not(.ql-container)")
  do_reader("#post-content-reader:not(.ql-container)")


