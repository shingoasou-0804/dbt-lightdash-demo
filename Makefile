.PHONY: help

# デフォルトターゲット
.DEFAULT_GOAL := help

# 色付きヘルプ
help: ## このヘルプを表示
	@echo ""
	@echo "📚 利用可能なコマンド:"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-35s\033[0m %s\n", $$1, $$2}'
	@echo ""

# ========================================
# 開発環境チェック
# ========================================

check-docker: ## Docker環境をチェック
	@echo "🐳 Checking Docker..."
	@docker --version > /dev/null 2>&1 || (echo "❌ Docker is not installed" && exit 1)
	@docker compose version > /dev/null 2>&1 || (echo "❌ docker-compose is not installed" && exit 1)
	@echo "✅ Docker is ready"

check-gcloud: ## gcloud CLIをチェック
	@echo "☁️  Checking gcloud CLI..."
	@gcloud --version > /dev/null 2>&1 || (echo "❌ gcloud is not installed" && exit 1)
	@echo "✅ gcloud is ready"

check-terraform: ## Terraformをチェック
	@echo "🏗️  Checking Terraform..."
	@terraform --version > /dev/null 2>&1 || (echo "❌ Terraform is not installed" && exit 1)
	@echo "✅ Terraform is ready"

auth-gcloud-adc: ## gcloud ADCで認証（キーファイル不要）
	@echo "🔐 Setting up Application Default Credentials..."
	@gcloud auth application-default login
	@echo "✅ ADC configured"
	@echo ""
	@echo "環境変数は不要です。gcloudが自動的に認証情報を提供します。"

set-gcloud-project: ## gcloudのデフォルトプロジェクトを設定
	@if [ -z "$$GCP_PROJECT_ID" ]; then \
		echo "❌ GCP_PROJECT_ID is not set"; \
		echo "Run: export GCP_PROJECT_ID=your-project-id"; \
		exit 1; \
	fi
	@echo "🔧 Setting gcloud default project to $$GCP_PROJECT_ID..."
	@gcloud config set project $$GCP_PROJECT_ID
	@echo "✅ gcloud default project set to $$GCP_PROJECT_ID"

# 環境変数チェック
check-env: ## 環境変数をチェック（代替認証含む）
	@echo "🔍 Checking authentication..."
	@AUTH_METHOD="none"
	@if [ -n "$$GOOGLE_APPLICATION_CREDENTIALS" ]; then \
		echo "✅ Using GOOGLE_APPLICATION_CREDENTIALS"; \
		AUTH_METHOD="key_file"; \
	elif [ -n "$$GOOGLE_IMPERSONATE_SERVICE_ACCOUNT" ]; then \
		echo "✅ Using Service Account Impersonation"; \
		AUTH_METHOD="impersonation"; \
	elif gcloud auth application-default print-access-token > /dev/null 2>&1; then \
		echo "✅ Using Application Default Credentials (ADC)"; \
		AUTH_METHOD="adc"; \
	else \
		echo "❌ No authentication method found"; \
		echo ""; \
		echo "Choose one of the following:"; \
		echo "  1. make auth-gcloud-adc          (推奨: キーファイル不要)"; \
		echo "  2. make auth-create-temp-key     (一時キー作成)"; \
		echo "  3. make auth-impersonate         (なりすまし認証)"; \
		exit 1; \
	fi
	@if [ -z "$$GCP_PROJECT_ID" ]; then \
		echo "⚠️  GCP_PROJECT_ID is not set"; \
		echo "Run: export GCP_PROJECT_ID=your-project-id"; \
		exit 1; \
	else \
		echo "✅ GCP_PROJECT_ID: $$GCP_PROJECT_ID"; \
	fi

check-all: check-docker check-gcloud check-terraform check-env ## すべての前提条件をチェック
	@echo ""
	@echo "✅ All prerequisites are met!"
	@echo "You can now run: make setup-all"
	@echo ""
