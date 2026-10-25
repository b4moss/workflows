# Gitea ミラー案

## 前提

- 社内 Gitea は 1.27 系相当の reusable / scoped workflow 機能を含むビルド
- セマンティック版番号の埋め込みが壊れている場合があるため、管理画面の表示でも再確認推奨

## 推奨構成

1. 公開正本: GitHub `b4moss/workflows`（本リポ）
2. Gitea 側: `b4m-inner/workflows` を **pull mirror**（読み取り専用）
3. 消費者は同一インスタンス内のみ `uses: b4m-inner/workflows/.gitea/workflows/lint.yaml@v1` など
4. テンプレ更新は GitHub で行い、ミラーが追従。`@v1` 移動前にカナリア 2〜3 リポ

## ミラー作成手順（案）

1. Gitea 管理 UI または API で `b4m-inner/workflows` を private/public いずれかで作成
2. Migration / Mirror: source = `https://github.com/b4moss/workflows.git`、interval 例 1h
3. Actions を有効化し、Cross-Repository Access を org 内に設定（private の場合）

## パス

本リポは Gitea 用を `.gitea/workflows/`、GitHub 用を `.github/workflows/` に置いている。  
ミラー後はそのまま `uses: b4m-inner/workflows/.gitea/workflows/<name>.yaml@v1` で呼べる。

呼び出し例（実ファイル名）:

- `b4m-inner/workflows/.gitea/workflows/lint.yaml@v1`
- `b4m-inner/workflows/.gitea/workflows/ci-gate.yaml@v1`
- `b4m-inner/workflows/.gitea/workflows/cd-stub.yaml@v1`
