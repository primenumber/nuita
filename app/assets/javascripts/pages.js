document.addEventListener("DOMContentLoaded", function(){
  document.getElementById('button-nuita').addEventListener('click', function(){
    this.className = "btn btn-block btn-complete";
    this.value = "おめでとうございます🎉🎉🎉🎉🎉🎉";
    this.setAttribute("disabled", "disabled");
  });
}, false);
