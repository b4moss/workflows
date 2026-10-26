# b4moss/workflows

共有 CI/CD テンプレート（秘密・内部ホスト名は入れない）。

| ディレクトリ | 用途 |
|---|---|
| [`.github/workflows/`](.github/workflows/) | GitHub Actions reusable workflows |
| [`.gitea/workflows/`](.gitea/workflows/) | Gitea Actions reusable workflows（同一インスタンスのミラーから呼ぶ） |
| [`github/`](github/) | GitHub 用テンプレ正本（`.github/workflows/` と同内容） |
| [`examples/`](examples/) | 消費者リポへの呼び出し例・`scripts/ci/lint.sh` 規約サンプル |
| [`docs/GITEA-MIRROR.md`](docs/GITEA-MIRROR.md) | Gitea ミラー（b4m-inner/workflows、作成済み） |

## 使い方（GitHub）

消費者リポの `.github/workflows/ci.yml`:

```yaml
jobs:
  lint:
    uses: b4moss/workflows/.github/workflows/lint.yml@v1
  gate:
    uses: b4moss/workflows/.github/workflows/ci-gate.yml@v1
  deploy:
    uses: b4moss/workflows/.github/workflows/cd-stub.yml@v1
    with:
      environment: staging
```

## 使い方（Gitea）

社内ミラー `b4m-inner/workflows` から、消費者リポの `.gitea/workflows/ci.yaml`:

```yaml
jobs:
  lint:
    uses: b4m-inner/workflows/.gitea/workflows/lint.yaml@v1
  gate:
    uses: b4m-inner/workflows/.gitea/workflows/ci-gate.yaml@v1
  deploy:
    uses: b4m-inner/workflows/.gitea/workflows/cd-stub.yaml@v1
    with:
      environment: staging
```

## 規約: 個別上書き

各リポは `scripts/ci/lint.sh`（任意で `test.sh` / `deploy.sh`）を持つ。  
共有 workflow は言語セットアップと「そのスクリプトを実行」だけを行う。lint が無いリポは no-op でよい。

## 同一 SHA / 同一 tree スキップ

`ci-gate` は base（または default branch）と `HEAD^{tree}` が同一なら lint/test をスキップする。

## 版

移動タグ `v1`（および注釈付き `v1.0.0`）を付与する。カナリアは `@main` でも可。

## Gitea

ミラーの説明は [`docs/GITEA-MIRROR.md`](docs/GITEA-MIRROR.md)。
