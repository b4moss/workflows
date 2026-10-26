# Gitea ミラー

## 前提

- 社内 Gitea は 1.27 系相当の reusable / scoped workflow 機能を含むビルド
- セマンティック版番号の埋め込みが壊れている場合があるため、管理画面の表示でも再確認推奨

## 推奨構成

1. 公開正本: GitHub `b4moss/workflows`（本リポ）
2. Gitea 側: `b4m-inner/workflows` を **pull mirror**（読み取り専用）
3. 消費者は同一インスタンス内のみ `uses: b4m-inner/workflows/.gitea/workflows/lint.yaml@v1` など
4. テンプレ更新は GitHub で行い、ミラーが追従。`@v1` 移動前にカナリア 2〜3 リポ

## 現状（作成済み）

Gitea 側のプルミラー [`b4m-inner/workflows`](https://git.b4m.jp/b4m-inner/workflows) は作成済み。

| 項目 | 値 |
|---|---|
| Visibility | public |
| 種別 | pull mirror |
| Source | `https://github.com/b4moss/workflows.git` |
| 同期間隔 | 1h |
| 作成日 | 2026-10-25 |

public のため、Cross-Repository Access の設定は不要。

### 作り直す場合の参考手順

1. Gitea 管理 UI または API で `b4m-inner/workflows` を public で作成
2. Migration / Mirror: source = `https://github.com/b4moss/workflows.git`、interval 1h
3. Actions を有効化（public のため Cross-Repository Access の設定は不要）

## パス

本リポは Gitea 用を `.gitea/workflows/`、GitHub 用を `.github/workflows/` に置いている。  
そのまま `uses: b4m-inner/workflows/.gitea/workflows/<name>.yaml@v1` で呼べる。

呼び出し例（実ファイル名）:

- `b4m-inner/workflows/.gitea/workflows/lint.yaml@v1`
- `b4m-inner/workflows/.gitea/workflows/ci-gate.yaml@v1`
- `b4m-inner/workflows/.gitea/workflows/cd-stub.yaml@v1`
