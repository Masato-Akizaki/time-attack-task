var $target = document.querySelector('.completed_tasks')
var $button = document.querySelector('.completed_tasks_btn')
$button.addEventListener('click', function() {
  $target.classList.toggle('is-hidden')
})