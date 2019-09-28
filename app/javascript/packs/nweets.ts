// いいねのajax処理

document.addEventListener('turbolinks:load', function(){
  document.querySelectorAll('.like-btn').forEach(function(div){
    div.addEventListener('ajax:success', function(){
      var anchor = <HTMLElement>div.firstElementChild;
      var icon = <HTMLElement>anchor.childNodes[0];
      var likeNumElement = <HTMLElement>anchor.childNodes[1];
      anchor.classList.toggle('liked');

      var likeCount:number;
      if(likeNumElement.innerText){
        likeCount = parseInt(likeNumElement.innerText);
      }else{
        likeCount = 0;
      }

      if(icon.classList.contains('fas')){
        icon.classList.replace('fas', 'far');
        anchor.setAttribute('data-method', 'post');
        likeCount--;
        if(likeCount){
          likeNumElement.innerText = likeCount.toString();
        }else{
          likeNumElement.innerText = "";
        }
      }else{
        icon.classList.replace('far', 'fas');
        anchor.setAttribute('data-method', 'delete');
        likeCount++;
        likeNumElement.innerText = likeCount.toString();
      }
    })
  });
});
