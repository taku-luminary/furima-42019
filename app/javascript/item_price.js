const price = () => {
  
  const priceInput = document.getElementById("item-price");
  const addTaxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");
  
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    
    if (inputValue === "" || isNaN(inputValue)) {
      addTaxDom.innerHTML = 0;
      profitDom.innerHTML = 0;
      return;
    }
    
    // 価格を数値に変換
    const price = parseInt(inputValue);
    
    // 販売手数料の計算（10%）- Math.floorで小数点以下切り捨て
    const fee = Math.floor(price * 0.1);
    
    // 販売利益の計算
    const profit = price - fee;
    
    // 画面に表示
    addTaxDom.innerHTML = fee;
    profitDom.innerHTML = profit;
  });
};


window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);