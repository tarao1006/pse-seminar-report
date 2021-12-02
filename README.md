# PSE Seminar Report

- PSE研究室向けのアクションです。
- LaTeXで作成したゼミ用のレポートをコンパイルし、配信用のPDFを作成します。

## Description

### Branch and directory structure

**配信用ブランチ**と**レポート作成用ブランチ**の二つの存在を仮定します。
また、レポート作成用ブランチに対して変更を都度プッシュする運用を想定しています。
しかし、レポート作成用ブランチ上でコンパイルしPDFを作成すると、このアクションが完了するごとにローカルリポジトリにプルする必要が生じてしまいます。
そのため、コンパイルはレポート作成用ブランチとは別の配信用ブランチ上で実行します。

実運用上は `on: push` をワークフローのトリガーとすることを想定しており、アクション内部で `${GITHUB_REF_NAME}` (マージされるブランチ名) を利用します。
さらに、マージされるブランチ名とレポートのファイルが存在するディレクトリ名が一致している必要があります。
例えば、以下のようなディレクトリ構成であった場合、ブランチ名は `seminar/20210101` である必要があります。

```shell
$ tree .
.
└── seminar
    └── 20210101
        └── report.tex
```

コンパイル後の配信用ブランチでは以下のようなディレクトリ構成となります。

```shell
$ tree .
.
├── distribution
│   └── seminar
│       └── 20210101
│           └── report.pdf
└── seminar
    └── 20210101
        └── report.tex
```

例えば、以下のようなディレクトリ構成の場合、 `inputs.prefix` の値を `src` に設定する必要があります。

```shell
$ tree
.
└── src
    └── seminar
        └── 20210101
            └── report.tex
```

### latexmk

デフォルトの設定では、以下のような `.latexmkrc` を利用してTeXファイルをコンパイルします。

```
$latex      = "find . -type f -name '*.tex' | xargs sed -i '' -e 's/、/，/g' -e 's/。/．/g'; platex -synctex=1 -halt-on-error %O %S";
$bibtex     = "pbibtex %O %B";
$dvipdf     = "dvipdfmx -f ptex-haranoaji.map -V 7 %O -o %D %S";
$max_repeat = 5;
$pdf_mode   = 3;
```

設定を変更したい場合は、このアクションを呼び出すリポジトリのルートディレクトリに `.latexmkrc` を配置してください。

## Inputs

| id | Description | Required | Default |
| :-: | :-- | :-: | :-: |
| `distribution_branch` | 配信用のPDFを保存するディレクトリ | ✅ | distribution |
| `report_filename` | コンパイルするTeXファイルの名前 | ✅ | report.tex |
| `prefix` | TeXファイルが存在するディレクトリのプレフィックス | ✅ | . |

## Environment variable

| id | Description | Required | Default |
| :-: | :-- | :-: | :-: |
| `GITHUB_TOKEN` | トークン | ✅ | - |

## Usage

```yaml
uses: tarao1006/pse-seminar-report@main
env:
  GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Future work

- [Description](#description) に記した示した制限を必要としない実装に変更する。
