# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

set_clock = ->
  date = new Date()
  hours = date.getHours()
  $(".hours").html((if hours < 10 then "0" else "") + hours)

  minutes = date.getMinutes()
  $(".minutes").html((if minutes < 10 then "0" else "") + minutes)

  seconds = date.getSeconds()
  $(".seconds").html((if seconds < 10 then "0" else "") + seconds)


$(document).on 'turbolinks:load', ->
  set_clock()
  setInterval set_clock, 1000


#  $(document).ready(function() {
#    setInterval( function() {
#    var hours = new Date().getHours();
#  $(".hours").html(( hours < 10 ? "0" : "" ) + hours);
#}, 1000);
#setInterval( function() {
#  var minutes = new Date().getMinutes();
#$(".min").html(( minutes < 10 ? "0" : "" ) + minutes);
#},1000);
#setInterval( function() {
#  var seconds = new Date().getSeconds();
#$(".sec").html(( seconds < 10 ? "0" : "" ) + seconds);
#},1000);
#});

