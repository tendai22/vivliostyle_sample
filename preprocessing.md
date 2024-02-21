# プリプロセス

* Markdownで書くのは書きやすい。Markdownを基本とする。
* 但しこれだけではできないことも多い。
* が、HTMLタグを書いてCSSを自分で書けばHTML+CSSで書けることはなんでもできるはず。
* vivliostyleはCSS組版エンジンをバックエンドとして、Markdownを処理してHTMLタグを生成する。CSSファイルも自分で指定できる。
* ならば、自分でタグ・スタイルを作り都合の良いページにすればよい。

## シェルスクリプト

単に私がテキスト処理はシェルスクリプトで書く芸風だから。ふつうは Node.js とか python とか使うと思うが。

WSLができて Windows マシンで Linux 環境が使えるようになったので、シェルスクリプトは追加一切不要で裸のLinux/Unixで使える。かれすぎているので「バージョンが上がったので以前のバージョンで動いていたスクリプトが動かなくなった」もない。

複数スクリプトをパイプラインでつないで、最後のコマンドの出力を vivliostyle が処理する Markdown ファイルとする。

## Makefile

vivliostyle コマンド呼び出し前に喰わせる Markdown ファイルの準備が自明でなくなってくる。自動化のために make コマンドを使う。

vivliostyleコマンドが最終処理で、PDFファイルを生成するので、vivliostyleコマンドの入力ファイルのターゲット化と依存関係を記述しておく。