document.addEventListener('turbolinks:load', function(){
  var pathname = location.pathname;
  var element;

  if (~pathname.indexOf('likes')){
    element = document.getElementById('badgeLikes');
  }else if(~pathname.indexOf('followers')){
    element = document.getElementById('badgeFollowers');
  }else if(~pathname.indexOf('followees')){
    element = document.getElementById('badgeFollowees');
  }else if(~pathname.indexOf('users')){
    element = document.getElementById('badgeNweets');
  }

  if(!!element){
    element.classList.add('active');
  }
});

document.addEventListener('turbolinks:load', function(){
  var btn = document.getElementById('buttonUnfollow');

  if(!!btn){
    btn.addEventListener('click', () => {
      btn.value = 'フォローする';
    }, false);
    btn.addEventListener('mouseover', () => {
      btn.value = 'フォロー解除';
    }, false);
    btn.addEventListener('mouseout', () => {
      btn.value = 'フォロー中';
    }, false);
  }
});
