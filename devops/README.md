## Upstream Updates

Since we are building off of the public open-source synapse server, there
are a number of steps that are required when merging changes in from the upstream.

What follows is a basic guide but great care will be needed when looking for
breaking changes introduced upstream. Please take your time and be mindful.

### Add Official Upstream

It is important to keep our fork current with the official maintainer's upstream.
Use the following commands to make sure you're building upon the latest release of riot.im:

Make sure you have an upstream remote:

```console
> cd ~/aloha/synapse
> git remote -v
origin	git@github.com:AlohaHealth/synapse.git (fetch)
origin	git@github.com:AlohaHealth/synapse.git (push)
upstream	git@github.com:matrix-org/synapse.git (fetch)
upstream	git@github.com:matrix-org/synapse.git (push)
```

If your remotes don't match above, add the upstream remote:

```console
git remote add upstream git@github.com:matrix-org/synapse.git
```

### Update from Upstream

Before starting a new major feature, make sure our fork is current with the
latest released version of synapse by comparing version numbers:

Check to see if the [matrix-org/synapse version](https://github.com/matrix-org/synapse/blob/master/synapse/__init__.py#L30)
matches our
[AlohaHealth/synapse version](https://github.com/AlohaHealth/synapse/blob/master/synapse/__init__.py#L30)

If the versions do not match, it's time for an update!

#### Fetch upstream changes

```console
cd ~/aloha/synapse
git fetch upstream
```

#### Create an upstream-update branch

```console
git hf feature start upstream-update
git merge upstream/master
```

#### Resolve Conflicts

It is perhaps likely at this point that you will run into merge conflicts.

**This is the point you'll need to take care to spot any upstream breaking changes**

Carefully review and resolve any upstream conflicts.

#### Push the upstream-update branch and open a Pull Request

```console
git hf push
git hf feature submit
```

Post a message to the #development slack channel with a link and a request to review the pull request.
Get approval before merging to master.

**IMPORTANT:** Make sure your PR is comparing the correct branches:

> base: develop <= compare: feature/upstream-update
