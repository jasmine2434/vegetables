'use strict'; 

{
  // データ取得
  // pagetopボタン
  const pageTop = document.querySelector('.pagetop');
  console.log(pageTop);

  // トップへ戻るボタンを表示する位置のsection
  const secGreen = document.querySelector('.sec-green');
  console.log(secGreen);

  // ビューポートの高さ
  const vh = window.innerHeight;
  console.log(vh);
  
  // イベント付加
   window.addEventListener('scroll', function() {
      // 処理を書く
      // スクロール量
      const scroll = window.pageYOffset;
      console.log(scroll);

      // 要素の位置までの相対数値
      const targetDistance = secGreen.getBoundingClientRect().top;
　　　 console.log(targetDistance);
  });
}