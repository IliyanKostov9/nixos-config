# Contributing

## Versioning

We use SemanticVersioning [SemVer](https://semver.org/)

## Branching model

We use the [GitHub flow](https://guides.github.com/introduction/flow/)

in addtion with team branches.

with the following branches

### Naming convention of branches

- `feature/<context>` or `feat/<context>`  -> feature branch
- `fix/<context>` -> bug fix branch
- `hot/<context>` -> hot fix branch
- `doc/<context>` -> addition to the documentation
- `release/<context>` -> release new version
- `refact/<context>` -> refactoring

### Team branches

Merges into those branches are only allowed with a PR

- dev -> DEV environment
- qa -> QA environment
- prod -> PROD environment

with an exception of hotfixes, to `qa` and `prod` branch it is only allowed to open a PR in the following order:
`dev` -> `qa` -> `prod`

### Deployments

The deployments to **DEV/QA/PROD** are automated. That means that whenever a PR is merged to one of the **Team branches**
the CI/CD build is triggered and will automatically deploy those changes to the related environment.

## Commit messages

We use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/)
Please also add an issue and the issue number as prefix to your commit message header description.

```bash
git commit -m "<type>[optional scope]: <description> [optional (#ticket_nr)]"
```
