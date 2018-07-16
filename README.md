pre-commit-scripts
=================

hooks for http://pre-commit.com/

### Using these hooks

Add this to your `.pre-commit-config.yaml`

    - repo: git@bitbucket.org:vettel_proj/pre-commit-scripts.git
      sha: HEAD
      hooks:
        - id: jira-fmt
          stages: [commit-msg]

Run `pre-commit autoupdate`.
Run `pre-commit install --hook-type commit-msg`

### Available hooks

- `jira-fmt` - Runs shell script that prepends commit message with [VET-####] 

### Example

There's an example .pre-commit-config.yaml added to this repo.
