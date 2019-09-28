document.addEventListener('turbolinks:load', () => {
  document.getElementById("buttonRenewRecommend").addEventListener("click", () => {
    fetch('./links/recommend')
    .then((response) => {
      return response.text();
    })
    .then((partial:string) => {
      let card = document.getElementById("recommendCard");
      card.textContent = "";
      card.insertAdjacentHTML("afterbegin", partial);
    });
  });
});

//{"id":2,"title":"僕の部屋の侵略者 | Komiflo","description":"著: 荒巻越前 / X-EROS #76","image":"https://t.komiflo.com/564_mobile_large_3x/contents/8b4e8c7a6ef15b8e5f4d7ce422e4cd245e14245a.jpg","card":null,"url":"https://komiflo.com/comics/4961","created_at":"2019-09-28T09:26:56.000+09:00","updated_at":"2019-09-28T09:26:56.000+09:00"}
