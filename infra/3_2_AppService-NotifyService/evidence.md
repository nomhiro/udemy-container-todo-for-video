
## 環境変数の設定

```json
[
  {
    "name": "POSTGRES_DB",
    "value": "todos",
    "slotSetting": false
  },
  {
    "name": "POSTGRES_HOST",
    "value": "udemytodoappshrkm0708-pg.postgres.database.azure.com",
    "slotSetting": false
  },
  {
    "name": "POSTGRES_PASSWORD",
    "value": "パスワード",
    "slotSetting": false
  },
  {
    "name": "POSTGRES_PORT",
    "value": "5432",
    "slotSetting": false
  },
  {
    "name": "POSTGRES_USER",
    "value": "pgadmin",
    "slotSetting": false
  },
  {
    "name": "POSTGRES_SSLMODE",
    "value": "require",
    "slotSetting": false
  },
  {
    "name": "SENDER_EMAIL",
    "value": "nomhiro1204@gmail.com",
    "slotSetting": false
  },
  {
    "name": "EMAIL_PASSWORD",
    "value": "ohxn hdsb xvck cmxj",
    "slotSetting": false
  },
  {
    "name": "RECIPIENT_EMAIL",
    "value": "nomhiro1204@gmail.com",
    "slotSetting": false
  },
  {
    "name": "SLEEP_SECONDS",
    "value": "3600",
    "slotSetting": false
  }
]
```

![alt text](image.png)


## システムマネージドID
有効化
![alt text](image-1.png)

![alt text](image-2.png)

## 診断設定
![alt text](image-4.png)

## コンテナデプロイ設定

```bash
az webapp config container set `
  --name udemytodoappshrkm0708-notify `
  --resource-group rg-udemytodoappshrkm0708 `
  --container-image-name udemytodoappshrkm0708acr01.azurecr.io/notify-service:latest
```

継続的デプロイをONに
![alt text](image-3.png)

![alt text](image-5.png)