$( document ).ready(function() {
  $(".remove-seat").click(function() {
    if ($(this).parent().siblings().length > 0) {
      $(this).parent().remove();
    } else {
      alert("you can't delete the last seat!")
    }
  })
})
