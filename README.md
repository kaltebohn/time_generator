# 時間割作成プログラム

## どのようなプログラム？
大学の時間割として、
- 科目名
- シラバスURL
- WebClassURL
- 授業関連ページ

が入ったテーブルをhtmlとして出力するプログラムです．
テーブルの要素の組み合わせは他にもあり、また1枠だけですが、カスタマイズもできます．

htmlをスマホ、PCなどに入れ、通常の時間割のように手軽にみられることを目的としています．

## 実行方法
##### 環境構築
本プログラムの実行には、プログラム言語Ruby及びそのバージョン管理用gemであるBundlerが必要です．

加えて、このREADME.mdを手元でなくサイト上で見ている方は、リポジトリを手元にcloneする必要があります．

必要でしたら以下のサイト等を参考にしてください．

- rubyのインストール: https://www.ruby-lang.org/ja/documentation/installation/
- bundleのインストール: https://qiita.com/oshou/items/6283c2315dc7dd244aef
- gitのインストール(windows): https://qiita.com/ikegam1/items/ee592c84e0d102f2c550
- リポジトリからclone: https://help.github.com/ja/github/creating-cloning-and-archiving-repositories/cloning-a-repository


開発者の開発環境は「開発環境」の大見出しで示しています．
##### 時間割の作成
- `bundle exec ruby generator.rb`を実行
- 表示されるガイドに従い入力

##### 時間割の修正
- `bundle exec ruby editor.rb`を実行
- 表示されるガイドに従い入力

##### テーブル要素の組み合わせ変更
- `bundle exec ruby configuration.rb -t [好きな組み合わせ]`を実行

例えば`bundle exec ruby configuration.rb -t zoom`で
- 科目名
- zoomURL
- zoomID
- zoomパスワード
が入ったテーブルをhtmlとして出力するようにできます．

どのような組み合わせがあるかは、`bundle exec ruby configuration.rb --help`で確認できます．

##### テーブル要素の組み合わせをカスタム
1つまでですが、お好みのテーブル要素を作成できます．

テーブル要素にはデフォルトで科目名があり、科目名を除いて10項目まで要素を設定できます．

「リンク有」の項目は「表示名」で表示され、`generator.rb`等で科目毎に入力した値がURLとしてハイパーテキストになります．

「リンク無」であれば、「表示名」は便宜上の者となり、実際に表示されるのは科目毎に入力した値です．
- `bundle exec ruby configuration.rb -c`を実行
- 表示されるガイドに従い入力


# 開発環境
```
$cat /etc/os-release
NAME="Ubuntu"
VERSION="18.04.4 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.4 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```
```
$ruby --version
ruby 2.6.5p114 (2019-10-01 revision 67812) [x86_64-linux]
```
```
$bundle --version
Bundler version 2.1.2
```

# 本プログラムの仕様について
開発者の未熟により、本プログラムが生成するhtmlはcssが一切使われておらず、最低限の見やすさしか保証されていません．

また、CUIで動くため、扱いづらく、バグが埋まっている可能性もあります．

何かしかの不具合、または、提案したい改善点(追加してほしいテーブル要素の組み合わせなど)が見つかった場合は、お手数ですが本文書の末尾に示す連絡先までお伝えいただけると助かります．

###### 作成者
coldTOUFU

github: https://github.com/coldTOUFU

twitter: coldTOUFU

EMail: neubaum.doraku@gmail.com