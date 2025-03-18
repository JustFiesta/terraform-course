# Lab for testing different validation/lint/document utilities for Terraform

Mainly used:

- [checkov](https://github.com/bridgecrewio/checkov)
- [terrascan](https://github.com/tenable/terrascan)
- [tfsec](https://github.com/aquasecurity/tfsec)
- [terraform-docs](https://github.com/terraform-docs/terraform-docs)
- [pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform)

Additionally tried to use validation blocks in variables and pre-commit.

Example outputs are present inside `tools-outputs` directory.

## Reproduction

1. Install terraform from [docs](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

2. Install and configure [aws](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) CLI with credentials

3. Install tools with provided script

    ```shell
    chmod +x setup-tools.sh

    ./setup-tools.sh
    ```

4. Run checks

    ```shell
    checkov -d . # this sould be ran from inside .venv
    terrascan scan -d .
    tfsec .
    terraform-docs markdown . > Module-README.md 
    ```
  
    To ignore any regule shown one can use `# tfsec:ignore:AWS002 - Comment_Here` in given resource

5. Run pre-commit hooks

This should be ran via `.venv/bin/` as there will its binary reside.

```shell
pre-commit autoupdate
pre-commit install --install-hooks
pre-commit run --all-files
```
