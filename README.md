#### 時間割作成プログラム

##### どのようなプログラム？
大学の時間割として、
- 科目名
- シラバスURL
- WebClassURL
- 授業関連ページ

が入ったテーブルをhtmlとして出力するプログラムです．

htmlをスマホ、PCなどに入れ、通常の時間割のように手軽にみられることを目的としています．

#### 開発環境
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

#### 実行方法
- `bundle exec ruby generator.rb`を実行
- 表示されるガイドに従い入力
