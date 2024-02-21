# vivliostyle_sample

A compilation of my vivliostyle/CSS press samples

vivliostyleを用いた CSS 組版を経て、プリプロセッシングと
CSS style fileにノウハウがたまってきた。
自分の備忘のためにノウハウとTipsを蓄積する。

## プリプロセッシング

* ワークフローの解説
* シェルスクリプトで前処理する。
* Markdownの良いところを残しつつ、記法を追加してゆく。

## 追加の構文

以下の記述自体が&lt;glossary>環境を使って書かれている。

<glossary>
||&lt;glossary><br> ...<br> &lt;/glossary>||
description環境。この間に以下の形式のエントリを書く。
  </div>
</div>
<div class="x2-grid">
  <div class="x-word"><code>|| name || ( ... )<br> .... </code></div>
  <div class="x-desc">description環境のエントリ定義。最初の name、次の括弧で囲まれた部分がFORTHのスタック効果を書く。  
  </div>
</div>
<div class="x2-grid">
  <div class="x-word"><code>|| name ||<br> .... </code></div>
  <div class="x-desc">通常のdescriptionエントリ記述。nameと説明のペアを書く。  

||^^X, ^^Y, ^^Z<NOCONV>||
脚注の合印。本文中で脚注を指したいところに置く。  

||^^X{ ... ^^}<NOCONV>||
脚注本文を書く。合印の次の段落の間に置く。X,Y,Zの3種類がキーとなる。実際にはファイルごとの連番が付される(^^X, ^^Y, ^^Z, ^^X のように)。

複数段落(空行)、`&lt;pre>`環境も置ける。
</glossary>

## Cover Page(カバーページ)

箱並べで表紙を作る。CSSの話

## toc(目次)

シェルスクリプトで toc.md を生成する。

## CSS組版ざっくりと

* 箱並べと流し込み
* <span>と<div> ... hbox/vboxに相当する
* 寸法の決まり方、外から決まるか、内側から決まるか。

## 環境

* LaTeXでいうところの環境、Markdownの本来の趣旨にそぐわないが。
* description環境
* glossary(FORTH word説明への対応)
* itemize環境 ... Markdownのアイテマイズは複数段落が書けない

## 脚注

* 脚注の仕組み
* 合印と本体文を別の場所に書きたい
* display: flexだと脚注が使えないらしい。
* 省略記法
* `[^1]`はサポートされていたようだ。が、Starting-FORTHには使えない[^1]。

[^1]: が、(1)複数段落を読み込まない。(2)ページ下段に置かず、ファイル末尾にまとめて表示するようだ。ちょっと使えないね。
 

## 図と文のレイアウト

* 箱並べと流し込み
* ページごとに個別対応する。
* float: right/left
* display: flex;
* grid

