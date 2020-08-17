document.addEventListener("turbolinks:load", function(){

  var url = document.location.href;
  var min = document.getElementById("min");
  var sec = document.getElementById("sec");
  var start = document.getElementById("start");
  var stop = document.getElementById("stop");
  var reset = document.getElementById("reset");

  if (url.includes('timer') && min) {
    var task_time = document.getElementById("min").innerHTML * 60;
    var time = document.getElementById("min").innerHTML * 60;
    var counter;

    start.onclick = function() {
      toggle();
      counter = setInterval(count, 1000);
    }

    stop.onclick = function() {
      toggle();
      clearInterval(counter);
    }

    reset.onclick = function() {
      time = task_time;
      sec.innerHTML = ('00' + (time % 60)).slice(-2);
      min.innerHTML = ('00' + (Math.floor(time / 60))).slice(-2);
    }

    $(document).on('turbolinks:before-cache turbolinks:before-render', function() {
      clearTimeout(counter);
    });

    function toggle() {
      if(start.disabled) {
        start.disabled = false;
        stop.disabled = true;
      } else {
        start.disabled = true
        stop.disabled = false;
      }
    }

    function count() {
      if(time === 0) {
        sec.innerHTML = ('00' + 0).slice(-2);
        min.innerHTML = ('00' + 0).slice(-2);
        toggle();
        alert("時間になりました。");
        clearInterval(counter);
      } else {
        time -= 1;
        sec.innerHTML = ('00' + (time % 60)).slice(-2);
        min.innerHTML = ('00' + (Math.floor(time / 60))).slice(-2);
      }
    }
  }
})