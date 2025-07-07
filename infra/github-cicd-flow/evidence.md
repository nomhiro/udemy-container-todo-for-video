## サービスプリンシパル登録
Azure認証情報（サービスプリンシパル）の登録

```bash
az ad sp create-for-rbac --name "ToDoAppDeployAuth" --role contributor `
--scopes /subscriptions/{サブスクID}/resourceGroups/rg-todo/providers/Microsoft.Web/sites/udemytodoapp-app `
--json-auth
```

notify-serviceへの権限付与
```bash
az role assignment create `
  --assignee サービスプリンシパルのクライアントID `
  --role contributor `
  --scope /subscriptions/{サブスクID}/resourceGroups/rg-todo/providers/Microsoft.Web/sites/udemytodoapp-notify
```

ACR への AcrPush 権限付与
```bash
az role assignment create `
  --assignee サービスプリンシパルのクライアントID `
  --role AcrPush `
  --scope /subscriptions/{サブスクID}/resourceGroups/rg-todo/providers/Microsoft.ContainerRegistry/registries/udemytodoappacr01
```


出力されるJSONをメモしておきます。


GitHub Secretsに登録
![alt text](image.png)

AZURE_CREDENTIALS
![alt text](image-1.png)


ACR_NAMEも登録
udemytodoappacr01
![alt text](image-2.png)


RESOURCE_GROUPも登録
rg-todo


![alt text](image-3.png)