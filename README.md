# b4moss/workflows

共有 CI/CD テンプレート（秘密・内部ホスト名は入れない）。

| ディレクトリ | 用途 |
|---|---|
| [`github/`](github/) | GitHub Actions reusable workflows |
| [`gitea/`](gitea/) | Gitea Actions 用（同一インスタンスから呼ぶ前提の YAML） |
| [`examples/`](examples/) | 消費者リポへの呼び出し例・`scripts/ci/lint.sh` 規約サンプル |
| [`docs/GITEA-MIRROR.md`](docs/GITEA-MIRROR.md) | Gitea ミラー案（**未設定**） |

## 使い方（GitHub）

消費者リポの `.github/workflows/ci.yml`:

```yaml
jobs:
  lint:
    uses: b4moss/workflows/.github/workflows/lint.yml@v1
  gate:
    uses: b4moss/workflows/.github/workflows/ci-gate.yml@v1
```

テンプレを GitHub の reusable として認識させるには、運用で `github/*.yml` を `.github/workflows/` に配置（または symlink / リリース時コピー）する必要がある。  
**初回:** レビュー後に `.github/workflows/` へ同内容を置くフォロー PR を出す想定（本コミットは構成の正本を `github/` / `gitea/` に分離）。

## 規約: 個別上書き

各リポは `scripts/ci/lint.sh`（任意で `test.sh` / `deploy.sh`）を持つ。  
共有 workflow は言語セットアップと「そのスクリプトを実行」だけを行う。lint が無いリポは no-op でよい。

## 同一 SHA / 同一 tree スキップ

`ci-gate` は base（または default branch）と `HEAD^{tree}` が同一なら lint/test をスキップする。

## 版

移動タグ `v1` を将来付与する（charter と同様、作成は PO 指示後）。それまでは `@main` カナリアのみ。

## Gitea

ミラーはまだ作らない。手順は [`docs/GITEA-MIRROR.md`](docs/GITEA-MIRROR.md)。
