$(document).ready(function() {
  // show and hide member info panels
  $('.member_entry').hover(
    function() {
      var target_div = $(this).find('.member_info');
      var move = 185 - target_div.height();
      $(this).find('.member_info').animate({top:move}, {queue:false, duration:250, easing: 'easeInSine'});
    },
    function() {
      $(this).find('.member_info').animate({top:'160px'}, {queue:false, duration:250, easing: 'easeOutSine'});
    }
  );
  
  // ajax link to show more members
  $('#pagination a').live('click', function() {
    $("#pagination").html('<p class="loading">Working on it...</p>');
    $.get(this.href, null, null, "script");
    return false;
  });
  
  // make sure they only choose a max of three categories
  $('.member_categories li input:checkbox').click(function() {
    if($(this).is(':checked') && $('.member_categories li input:checked').length > 3) {
      alert('Hey! You can only choose 3 categories!');
      return false;
    }
  })
});

