document.addEventListener('turbolinks:load', () => {
  var pathname:string = location.pathname;

  if(~pathname.indexOf('christmas')){
    document.body.classList.add('christmas-bg');
  }
});
