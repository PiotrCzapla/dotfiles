# Piotr's dotfiles

## quick setup
```
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply piotrczapla
```

One shot setup 
```
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --one-shot piotrczapla
```

## to test init

```
chezmoi execute-template  '{{.codespaces}} {{.colab}} {{.container}} {{.conda_home}}'
```

License: MIT