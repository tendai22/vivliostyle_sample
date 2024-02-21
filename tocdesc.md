## toc .. 目次づくり

* toc.md に目次ページを作る
* 本文ファイルから目次に入れる項目を抽出して書く。
* grep '^#' | grep '{id=' で抽出する。

### 目次の仕組み

* listとanchorで書く。
* 本文の目次行は h1, h2, h3を抽出して作る。
* 目次行はアンカーで書く。
* ページ番号は a::after に `content: counter(page);`と書けばよい。
* 本文の h1,h2,h3要素には{id=XXX}と書く。これでタグ内にid属性が追加される。
* PDFでも目次から本文の該当箇所にジャンプできる。anchorだから。

### tocファイル

* 1行にアンカーのとび先 url="ch01_x.html#A1-03" を入れておく。
* 複数ファイルの場合ファイル名が必要。拡張子はmdではなくhtml.
* #の後ろに本文で指定したid属性値を書く。

* toc.mdファイル生成はシェルスクリプト`do_maketoc0.sh`で行う。
* `- [FORTHが生まれた世界](ch01.html#"H1-1"){.toc-chapter} `の形式のエントリを出力すればよい。

```html
<nav id="toc" role="doc-toc">

- [FORTHが生まれた世界](ch01.html#"H1-1"){.toc-chapter}
  - [FORTHの誕生](ch01.html#H01-2){.toc-section}

  ...

</nav>
```

* HTMLには以下のように書かれる。

```
    <li><a href="ch01.html#%22H1-1%22" class="toc-chapter">FORTHが生まれた世界</a>
        <ul>
        <li><a href="ch01.html#H01-2" class="toc-section">FORTHの誕生</a></li>
        </ul>
    </li>

```

* スタイルは css/sample1.css に書いてある。

```css
toc li a::after {
	content: target-counter(attr(href), page);
}

#toc li a {
	display: inline-flex;
	width: 100%;
	text-decoration: none;
	color: currentColor;
	align-items: baseline;
}

#toc li a::before {
	margin-left: 0.5em;
	margin-right: 0.5em;
	border-bottom: 1px dotted;
	content: '';
	order: 1;
	flex: auto;
}

#toc li a::after {
	text-align: right;
	content: target-counter(attr(href), page);
	align-self: flex-end;
	flex: none;
	order: 2;
}

```