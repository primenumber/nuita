// add likes
document.addEventListener('turbolinks:load', function(){
  document.querySelectorAll('.fav-btn').forEach(function(div){
    div.addEventListener('ajax:success', function(){
      var a = div.firstElementChild;
      var i = a.firstElementChild;
      i.classList.toggle('faved');

      if(i.classList.contains('fa-heart')){
        i.classList.replace('fa-heart', 'fa-heart-o');
        a.setAttribute('data-method', 'post');
      }else{
        i.classList.replace('fa-heart-o', 'fa-heart');
        a.setAttribute('data-method', 'delete');
      }
    })
  });
});
