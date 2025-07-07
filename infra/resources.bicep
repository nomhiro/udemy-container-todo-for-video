// resources.bicep
// このモジュールは、リソースグループ配下に主要なAzureリソースを最安構成でデプロイします。
//
// 【払い出すリソースと設定の解説】
// - Azure Container Registry（ACR）
//   name: ${prefix}acr01
//   sku: Basic（最安）
//   adminUserEnabled: true（管理者ユーザー有効化）
//
// - Azure Database for PostgreSQL Flexible Server
//   name: ${prefix}-pg
//   sku: B_Standard_B1ms（Burstable最小構成）
//   version: 15
//   administratorLogin: 'pgadmin'（管理者ユーザー名）
//   administratorLoginPassword: adminPassword（mainから安全に受け渡し）
//   storageSizeGB: 32（最小）
//   highAvailability: Disabled（冗長化なし）
//   backupRetentionDays: 7（バックアップ保持7日）
//   geoRedundantBackup: Disabled（地理冗長バックアップなし）
//
// - Azure App Service Plan
//   name: ${prefix}-asp
//   sku: F1（Freeプラン）
//   reserved: false（Linuxでなければfalse）
//
// - Azure App Service
//   name: ${prefix}-app
//   serverFarmId: App Service Planに紐付け
//   httpsOnly: true
//
// - Azure App Service
//   name: ${prefix}-notify
//   serverFarmId: App Service Planに紐付け
//   httpsOnly: true

param prefix string
param location string
@secure()
param adminPassword string

resource acr 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: '${prefix}acr01'
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

resource postgres 'Microsoft.DBforPostgreSQL/flexibleServers@2022-12-01' = {
  name: '${prefix}-pg'
  location: location
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    version: '15'
    administratorLogin: 'pgadmin'
    administratorLoginPassword: adminPassword
    storage: {
      storageSizeGB: 32
    }
    highAvailability: {
      mode: 'Disabled'
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: '${prefix}-asp'
  location: location
  sku: {
    name: 'B1' // Basicプラン（Function Apps対応）
    tier: 'Basic'
  }
  properties: {
    reserved: true // Linuxコンテナ利用のためtrue
  }
}

resource appServiceTodo 'Microsoft.Web/sites@2022-09-01' = {
  name: '${prefix}-app'
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      // linuxFxVersion: 'DOCKER|<todo-app-image>' // デプロイ時にイメージ名へ置換
    }
  }
}

resource appServiceNotify 'Microsoft.Web/sites@2022-09-01' = {
  name: '${prefix}-notify'
  location: location
  kind: 'app,linux,container'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      // linuxFxVersion: 'DOCKER|<notify-service-image>' // デプロイ時にイメージ名へ置換
    }
  }
}
