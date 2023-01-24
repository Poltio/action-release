## Create New Release & Tag

You can use this action to tag a new release after each Pull Request is closed.

### Inputs

**token**

(required) github token to use to create a new tag and release

example yaml file:

```yaml
name: Create new version
on:
  pull_request:
    types: [closed]

jobs:
  release:
    runs-on: ubuntu-latest
    name: Create a new release

    if: github.event.pull_request.merged

    steps:
      - uses: actions/checkout@v3
        with:
          fetch-depth: 0

      - id: release
        uses: poltio/action-release@v0
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
```
