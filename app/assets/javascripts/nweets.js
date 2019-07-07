document.addEventListener('turbolinks:load', function(){
  document.querySelectorAll('.fav-btn').forEach(function(div){
    div.addEventListener('ajax:success', function(){
      var a = div.firstElementChild;
      var i = a.childNodes[0];
      var span = div.childNodes[1];
      i.classList.toggle('faved');

      if(i.classList.contains('fa-heart')){
        i.classList.replace('fa-heart', 'fa-heart-o');
        a.setAttribute('data-method', 'post');
        span.classList.remove('faved-flash')
      }else{
        i.classList.replace('fa-heart-o', 'fa-heart');
        a.setAttribute('data-method', 'delete');
        span.innerHTML = 'いいねしました！'
        span.classList.add('faved-flash')
      }
    })
  });
});
