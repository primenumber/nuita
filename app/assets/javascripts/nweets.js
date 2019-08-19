// いいねのajax処理。全体的に酷すぎるのでちゃんとサーバーと通信して実値を出すようにする

document.addEventListener('turbolinks:load', function(){
  document.querySelectorAll('.fav-btn').forEach(function(div){
    div.addEventListener('ajax:success', function(){
      var a = div.firstElementChild;
      var i = a.childNodes[0];
      var num = a.childNodes[1];
      a.classList.toggle('faved');

      var n;
      if(num.innerText){
        n = parseInt(num.innerText);
      }else{
        n = 0;
      }

      if(i.classList.contains('fas')){
        i.classList.replace('fas', 'far');
        a.setAttribute('data-method', 'post');
        n--;
        if(n){
          num.innerText = n;
        }else{
          num.innerText = "";
        }
      }else{
        i.classList.replace('far', 'fas');
        a.setAttribute('data-method', 'delete');
        n++;
        num.innerText = n;
      }
    })
  });

  document.querySelectorAll('.follow-icon-link').forEach(function(a){
    a.addEventListener('ajax:success', function(){
      var span = a.firstElementChild;
      var i = span.firstElementChild;

      if(span.classList.contains('unfollowable')){
        a.setAttribute('data-method', 'post');
        if(i.classList.contains('fa-exchange-alt')){
          i.classList.replace('fa-exchange-alt', 'fa-user-plus');
        }else{
          i.classList.replace('fa-user-check', 'fa-user-plus');
        }
      }else{
        a.setAttribute('data-method', 'delete');
        if(span.classList.contains('follower-true')){
          i.classList.replace('fa-user-plus', 'fa-exchange-alt');
        }else{
          i.classList.replace('fa-user-plus', 'fa-user-check');
        }
      }
      span.classList.toggle('unfollowable');
    });
  });
});
