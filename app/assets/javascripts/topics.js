// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$('.topic-content').hover(function() {
  console.log('hello hover');
});

$('.topic-content').mouseleave(function() {
  $('.delete-topic-btn').removeClass('invisible');
});
