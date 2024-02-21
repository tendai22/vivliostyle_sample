## 脚注

* ふつうは`<span class="footnote">脚注に書くべき内容</span>`を本文の中に置くと、そこに脚注マークが描かれ、そのページ下端に脚注に書くべき内容が描かれる。

### CSS組版での仕組み

* float: footnote; で組むと、ページ下端に footnote 箱が蓄積されてページがいっぱいになるとレンダリングされる。
* `class="notenext"` でCSS定義していた。
* `::footnote-marker`で脚注本文の先頭マークを書く。
* `::footnote-call`で本文の脚注マーク(合印)を書く。
* counter(footnote)は発生するごとに自動インクリメントするらしい。ページごとにリセットされる?

```css
/* footnote */
.notetext {
	float: footnote;
	font-size: 11Q;
	line-height: 15Q;
	text-indent: 0;
}

::footnote-marker {
	content: "*" counter(footnote) " ";
}
::footnote-call {
	content: "*" counter(footnote);
	font-size: 0.7em;
	position: relative;
	inset-block-start: -0.5em;
}

```

### 課題

* このやり方だと、<span> ... </span> が解釈されない場所には脚注を置けない。
* 文中に置くので、複数段落からなる脚注本部が書けない、書くと構文が壊れてしまう(表内部、コード内部など)。
* 脚注本文に複数段落、コード(<pre>)も書きたい。

### 対応

* クラスを2つ(`refcall`, `refbody`)用意し、`::footnote-marker`のみを書くクラスと`::footnote-call`のみを書くクラスとの、2つのクラスを用意する。
* 本文中には`<span class="refcall" ref="a"></span>`、その下の段落の間に`<div class="refbody" ref="a"> ... </div>`と、脚注本文を書く。
* ref="a"の部分が合わせ鍵となっている。この文字列が合印や脚注先頭にdaggerとともにおかれる(&#8224;a)
* プリプロセッサ`do_note2.sh`で、`class="refcall" ref="a"`の"a"部分をカウンタ数字に置き換える。 ファイル単位で連番が振られることになる。

```
If we were going to keep 5#SUM for future use, we
could enter it  into our ever-growing glossary, 
along with a note that it  "expects five 
arguments"<span class="refcall" ref="a"></span> on 
the stack, which it will add together.

<span class="refbody" ref="a">
For Semantic Freaks

In mathematics, the word "argument" refers to an
independent variable of a function. Computer
linguists have borrowed this  term to refer to 
numbers being operated on by operators. They  
have also borrowed the word "parameters" to 
describe pretty much  the same thing.
</span>
```

### CSS

* `.refcall::footnote-call`, `.refbody::footnote-marker`に`content: attr(ref)`と書いておく。
* `\2020`はdaggerである。好きな文字に替えてかまわない。             

```css
.refbody {
	float: footnote;
	font-size: 11Q;
	line-height: 15Q;
	text-indent: -1em;
	padding-left: 1em;
}

.refbody > p {
	text-indent: 0;
}

.refcall {
	float: footnote;
}

.refbody::footnote-marker {
	content: "\2020" attr(ref) " ";
}

.refbody::footnote-call {
	content: '';
}

.refcall::footnote-marker {
	content: '';
}

.refcall::footnote-call {
	content: "\2020" attr(ref) ;
	font-size: 0.7em;
	position: relative;
	inset-block-start: -0.5em;
}
```

### 省略記法

`^^X` で footnote-call を書き、次の段落の間に
`^^X{ ... ^^}`で本部を書けるようにした。本文には複数パラグラフ、`<pre>`環境も書ける。

```
If we were going to keep 5#SUM for future use, we
could enter it  into our ever-growing glossary, 
along with a note that it  "expects five 
arguments"^^X on the stack, which it will add
together.

^^X{For Semantic Freaks

In mathematics, the word "argument" refers to an
independent variable of a function. Computer
linguists have borrowed this  term to refer to 
numbers being operated on by operators. They  
have also borrowed the word "parameters" to 
describe pretty much  the same thing.
^^}

```

