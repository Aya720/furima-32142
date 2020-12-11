// トークン化の処理を記述 //
const pay = () => {
  
  // PAY.JPテスト公開鍵   鍵情報は公開してはいけない。
  // 鍵情報をGitHubにPushするなどしてしまうと、コードに含まれる鍵情報が公開されてしまい、不正請求などの被害にあうリスクがある。
  // 鍵情報は環境変数に設定すること。
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
                       // ”charge-form”というidを指定して、フォーム全体の要素を取得している。ディベロッパーで確認するとフォームの大枠にidが付与されているのが確認できる//
  const form = document.getElementById("charge-form");
  console.log(form);
  // そのフォームが送信（submit）されたときにイベント(指定した処理)が発火する。 //
  form.addEventListener("submit", (e) => {
    // e.preventDefault(); ▶︎通常のRuby on Railsにおけるフォーム送信処理はキャンセルさせている。ボタンをクリックしても、サーバーサイドへリクエストは送られない。
    e.preventDefault();
    
          // ブラウザ上に表示されているフォームの情報を取得
    const formResult = document.getElementById("charge-form");
          // それをFormDataオブジェクトとして生成。FormDataオブジェクト：フォームに入力された値を取得できるオブジェクトのこと
          // new FormData(フォームの要素);のように、オブジェクトを生成。引数にフォームの要素を渡すことで、そのフォームに入力された値を取得できる。
    const formData = new FormData(formResult);
    
    // FormDataオブジェクトから、カード情報を取得し、変数cardに代入するオブジェクトとして定義
    // formData.get("name属性") ⬅️ディベロッパーツールで確認しよう
    // name属性:ユーザーが入力した値をサーバーやブラウザに送信するための識別子
    const card = {
      number: formData.get("purchase[number]"),
      cvc: formData.get("purchase[cvc]"),
      exp_month: formData.get("purchase[exp_month]"),
      exp_year: `20${formData.get("purchase[exp_year]")}`,
    };
    console.log(card)
    // カード情報が受け取れているかの確認
    
    //カード情報をトークン化
    // のためにpay.jsが提供するPayjp.createToken(card, callback)というオブジェクトを使用。第一引数のcardは、PAY.JP側に送るカード情報。第二引数のcallbackには、PAY.JP側からトークンが送付された後に実行する処理を記述
    // Payjp.createToken(カード情報, PAY.JP側からのレスポンスとステータスコード)
    // ここでcreateした時にparamsにtokenの値を入れて返してきてくれている。だからcontrollerでも：tokenを使うことができる
    Payjp.createToken(card, (status, response) => {
      // 暗号化された後に実行される処理＝レスポンスを受け取ったあとの処理
       //トークンの作成がうまくいったかどうかの確認できる、HTTPステータスコードが入る
      if (status == 200) {
        // response.idとすることでトークンの値を取得することができる。 // これまでのステップで、トークンを取得することができ
         // HTTPステータスコードが200のとき、すなわちうまく処理が完了したときだけ、トークンの値を取得するようにしている。
        const token = response.id;
        console.log(token);
        // tokenが受け取れているかの確認


        // ここからはトークンの値をサーバーサイドに情報を送信するためにフォームを作る //
        // getElementByIdで指定したIDに紐づく入力された値（ドキュメント要素）を取得
        const renderDom = document.getElementById("charge-form");
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        // valueは実際に送られる値
        // nameはvalueにくっついてくる、その値が何かをが表す情報（params[:name]のように取得できるようになる）
        // トークンの値をブラウザ上で非表示にする。-> type="hidden"
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        // insertAdjacentHTML:HTMLを差し込むやつ。画面に新しいHTML要素を追加する場合によく使う。
        // 第1引数に差し込む位置の指定をする文字列、第2引数に差し込むHTMLを渡す。
        renderDom.insertAdjacentHTML("afterbegin", tokenObj);
      }
        
        // サーバーサイドへの送信処理されないようクレジットカードの情報を削除 //
        // removeAttribute:指定した要素から、特定の属性を削除
        document.getElementById("card-number").removeAttribute("purchase[number]");
        document.getElementById("card-cvc").removeAttribute("purchase[cvc]");
        document.getElementById("card-exp-month").removeAttribute("purchase[exp_month]");
        document.getElementById("card-exp-year").removeAttribute("purchase[exp_year]");


        // サーバーサイドにフォームの情報を送る
        // Railsにおけるフォーム送信処理はキャンセルしているのでJavaScript側からフォームの送信処理を行う必要がある
        document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);

