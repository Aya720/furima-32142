
window.addEventListener('load', () => {
    // document.getElementById("id名")：引数に渡したidを持つHTMLの要素を取得
    const price = document.getElementById("item-price");
    price.addEventListener("input", () => {
      const inputValue = price.value;
      console.log(inputValue);
      const tax = document.getElementById("add-tax-price");
      tax.innerHTML = Math.round(inputValue * 0.9);
      console.log(tax);
      const profit = document.getElementById("profit");
      profit.innerHTML = Math.round(inputValue - tax.innerHTML);
      console.log(profit);
    })
});