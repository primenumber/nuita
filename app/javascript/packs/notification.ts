function fetchNotificationCount(){
  fetch('/notification/refresh')
  .then((response) => {
    return response.text();
  })
  .then((response:string) => {
    let unreadCount:number = parseInt(response);
    let badgeDiv = document.getElementById("badgeUnreadNotifications");

    badgeDiv.textContent = unreadCount.toString();
    if(unreadCount){
      badgeDiv.classList.remove("d-none");
    }else{
      badgeDiv.classList.add("d-none");
    }
  });
}

document.addEventListener("turbolinks:load", () => {
  if(document.getElementById("badgeUnreadNotifications")){
    const intervalSec:number = 30;
    fetchNotificationCount();
    setInterval(fetchNotificationCount, intervalSec * 1000);
  }
});
