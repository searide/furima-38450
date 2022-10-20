addEventListener('load', () => {
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("input", () => {
  const inputValue = itemPrice.value;
  const calcFee = document.getElementById("add-tax-price");
  const calcProfit = document.getElementById("profit");
  // 入力した金額をもとに販売手数料を計算する処理
  calcFee.innerHTML = Math.floor(inputValue * 0.1);
  // 出品価格から販売手数料を引く処理
  calcProfit.innerHTML = inputValue - calcFee.innerHTML;
  });
});