.PHONY: setup lint run clean

TTY_FLAG := $(shell [ -t 0 ] || echo "-T")

setup:
	uv sync --all-groups
	uv run prek install

lint:
	uv run prek run --all-files

run:
	docker compose -f docker/compose.yaml up --build

clean:
	docker compose -f docker/compose.yaml down --rmi local --volumes
	find . -not -path './.venv/*' -name "*.pyc" -delete
	find . -not -path './.venv/*' -type d -name __pycache__ -exec rm -rf {} +
	rm -rf .pytest_cache .ruff_cache
