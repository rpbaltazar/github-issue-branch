# github-issue-branch

Inspired by [story_branch gem]() but applied to github with a lot of refactoring done, this gem provides a way of creating branches from existing issues on a github repository.

You need to generate your auth token and store it your machine in a file named
`.gihub_issue_branch_conf`. The search paths will be either the root of the project or the
user's home folder.

## Example of conf file

### Authentication

```
$> cat .github_issue_branch_conf
github_auth_token: YOUR_AUTH_TOKEN
```

The other option is setting an environment variable with the token. The variable name should be as such:

```
$> echo $GITHUB_AUTH_TOKEN
YOUR_AUTH_TOKEN
```

### Repository linking

By default it tries to load the repository owner and name from your git configs but you can also set it on the config file as such:

```
$> cat .github_issue_branch_conf
github_auth_token: YOUR_AUTH_TOKEN
github_owner: your-github-username
github_repo: your-github-repo
```

## Using it

For now, the use is quite limited to creating a branch from an existing issue. It will assign the issue to your username as well.

```
$> github_issue_branch
```

And follow the instructions

Future features will include:

- autocomplete on issue selection
- fuzzy matching on issue selection
- selecting issues from a specific label or milestone
- selecting issues that are alreday associated to you
- reading comments associated with an issue
- create a new issue
- add a final comment associated with this issue
- close the issue

....