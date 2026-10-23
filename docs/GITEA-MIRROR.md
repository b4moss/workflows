# Gitea ミラー案（未設定）

**この文書は案のみ。ミラー作成・push・Actions 有効化はまだ行わない。**

## 前提（確認済み）

- `GET https://git.b4m.jp/api/v1/version`（認証付き）→ `{"version":"4a5cac2a49"}`
- 稼働コンテナ `gitea --version` → 同じハッシュ、`built with go1.27.1`
- バイナリに `WORKFLOW_DIRS` / `SCOPED_WORKFLOW_DIRS` 文字列あり → **1.27 系の reusable / scoped workflow 機能を含むビルド**とみなす
- セマンティック版番号の埋め込みが壊れているため、管理画面の表示でも再確認推奨

## 推奨構成

1. 公開正本: GitHub `b4moss/workflows`（本リポ）
2. Gitea 側: `b4m-inner/workflows` を **pull mirror**（読み取り専用）
3. 消費者は同一インスタンス内のみ `uses: b4m-inner/workflows/.gitea/workflows/….yaml@v1`
4. テンプレ更新は GitHub で行い、ミラーが追従。`@v1` 移動前にカナリア 2〜3 リポ

## ミラー作成手順（案・未実行）

1. Gitea 管理 UI または API で `b4m-inner/workflows` を private/public いずれかで作成
2. Migration / Mirror: source = `https://github.com/b4moss/workflows.git`、interval 例 1h
3. Actions を有効化し、Cross-Repository Access を org 内に設定（private の場合）
4. ミラー後、Gitea 側パスが `.gitea/workflows/` を要求するなら、ミラー同期後にパス合わせ用の薄いラッパリポを検討（本リポは `gitea/` ディレクトリに YAML を置いている）

## パス注意

Gitea reusable `uses:` は **ワークフローディレクトリ配下**を要求する。ミラー先では次のどちらか:

- A. ミラーリポで `gitea/*.yaml` → `.gitea/workflows/` へコピーする同期ジョブを足す
- B. 本リポの Gitea 用ファイルを最初から `.gitea/workflows/` に置き、GitHub 用は `.github/workflows/` に置く（将来の整理案）

現状はレビューしやすいよう `github/` と `gitea/` に分けている。ミラー実装時に B へ寄せる判断を PO に仰ぐ。
